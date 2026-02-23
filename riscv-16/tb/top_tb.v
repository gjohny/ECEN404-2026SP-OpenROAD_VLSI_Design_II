`timescale 1ns / 1ps

`define STRLEN 32
`define HALF_CLOCK_PERIOD 5
`define CLOCK_PERIOD (`HALF_CLOCK_PERIOD * 2)

module top_tb;

    // Clock and reset
    reg clk;
    reg reset;

    // Debug outputs from DUT
    wire [15:0] dbg_pc;
    wire [15:0] dbg_instr;
    wire [15:0] dbg_alu_result;
    wire [15:0] dbg_x1;

    // Instantiate DUT
    riscv16_top dut (
        .clk(clk),
        .reset(reset),
        .dbg_pc(dbg_pc),
        .dbg_instr(dbg_instr),
        .dbg_alu_result(dbg_alu_result),
        .dbg_x1(dbg_x1)
    );

    // Waveform dump
    initial begin
        $dumpfile("./tb/waveform/top.vcd");
        $dumpvars(0, top_tb);
    end

    // Clock generation
    initial begin
        clk = 1'b0;
    end
    always begin
        #`HALF_CLOCK_PERIOD clk = ~clk;
    end

    // Simple pass/fail tracking
    reg  [7:0] passed;

    task passTest;
        input [15:0] actualOut;
        input [15:0] expectedOut;
        input [`STRLEN*8:0] testName;
        inout [7:0] passed;
        begin
            if (actualOut === expectedOut) begin
                $display("%s passed (0x%04h)", testName, actualOut);
                passed = passed + 1;
            end else begin
                $display("%s FAILED: got 0x%04h, expected 0x%04h",
                         testName, actualOut, expectedOut);
            end
        end
    endtask

    task allPassed;
        input [7:0] passed;
        input [7:0] numTests;
        begin
            if (passed == numTests)
                $display("All %0d tests passed.", numTests);
            else
                $display("Some tests failed: %0d of %0d passed.", passed, numTests);
        end
    endtask

    // Watchdog
    reg [15:0] watchdog;

    // ------------------------------------------------------------
    // Periodic debug print (every 10000 ns starting at t=0)
    // ------------------------------------------------------------
    initial begin
        passed   = 0;
        watchdog = 0;

        // 1. Reset the system
        reset = 1'b1;
        #20;
        reset = 1'b0; 
        @(posedge clk);
        

        $display("--- Starting Execution ---");

        // 2. Run for exactly 8 cycles and print every step
        repeat (8) begin
            @(negedge clk); // Sample values right after the rising edge
            #7;
            $display("Time=%0t | PC=0x%04h | Instr=0x%04h | ALU=0x%04h | x1=0x%04h",
                     $time, dbg_pc, dbg_instr, dbg_alu_result, dbg_x1);
        end

        // 3. Final Check (Adjust expected to 0x0004 or 0x0006 based on your .mem)
        passTest(dbg_x1, 16'h0001, "Program 1: x1 = 3 - 2", passed);

        allPassed(passed, 1);
        $finish;
    end

endmodule