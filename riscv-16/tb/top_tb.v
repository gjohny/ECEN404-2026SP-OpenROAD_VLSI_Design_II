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
    wire [15:0] dbg_x2;
    wire [15:0] dbg_x3;


    // Instantiate DUT
    riscv16_top dut (
        .clk(clk),
        .reset(reset),
        .dbg_pc(dbg_pc),
        .dbg_instr(dbg_instr),
        .dbg_alu_result(dbg_alu_result),
        .dbg_x1(dbg_x1),
        .dbg_x2(dbg_x2),
        .dbg_x3(dbg_x3)
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

    // Number of instructions in program16.mem
    localparam PROGRAM_WORDS = 50;


    // Main stimulus
    initial begin
        passed   = 0;
        watchdog = 0;

        // 1. Reset
        reset = 1'b1;
        #10;
        @(posedge clk);
        reset = 1'b0;   

        $display("--- Starting Execution ---");



        // 2. Monitoring Loop
        while ((dbg_pc >> 1) < PROGRAM_WORDS && watchdog < 100) begin
            @(posedge clk);
            #1;  // allow register file & memory to update

            $display("Time=%0t | PC=0x%04h | Instr=0x%04h | ALU=0x%04h | x1=0x%04h | x2=0x%04h | x3=0x%04h | zero=%b",
                    $time, dbg_pc, dbg_instr, dbg_alu_result, dbg_x1, dbg_x2, dbg_x3, dut.ALU_CORE.zero);
            

            $display("STORE: addr=%h data=%h | MEM snapshot: [0]=%h [1]=%h [2]=%h \n\n",
                    dut.DMEM.mem_access_addr,
                    dut.DMEM.mem_write_data,
                    dut.DMEM.memory[0],
                    dut.DMEM.memory[1],
                    dut.DMEM.memory[2]);


            watchdog = watchdog + 1;
        end

        // 3. Final Check
        $display("--- Simulation Finished ---\n\n");
        // passTest(dbg_x1, 16'h0004, "Program 1: x1 = 3 + 1", passed);

        // allPassed(passed, 1);
        $finish;
    end

endmodule