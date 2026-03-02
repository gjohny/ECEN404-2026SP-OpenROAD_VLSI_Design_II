`timescale 1ns / 1ps

`define STRLEN             64
`define HALF_CLOCK_PERIOD  5
`define CLOCK_PERIOD       (`HALF_CLOCK_PERIOD * 2)

module top_pipeline_tb;

    reg  clk;
    reg  reset;

    wire [15:0] dbg_pc;
    wire [15:0] dbg_instr;
    wire [15:0] dbg_alu_result;
    wire [15:0] dbg_x1;
    wire [15:0] dbg_x2;
    wire [15:0] dbg_x3;
    wire [15:0] dbg_x4;
    wire [15:0] dbg_x5;
    wire [15:0] dbg_x6;
    wire [15:0] dbg_x7;

    riscv16_top dut (
        .clk(clk),
        .reset(reset),
        .dbg_pc(dbg_pc),
        .dbg_instr(dbg_instr),
        .dbg_alu_result(dbg_alu_result),
        .dbg_x1(dbg_x1),
        .dbg_x2(dbg_x2),
        .dbg_x3(dbg_x3),
        .dbg_x4(dbg_x4),
        .dbg_x5(dbg_x5),
        .dbg_x6(dbg_x6),
        .dbg_x7(dbg_x7)
    );

    initial begin
        $dumpfile("./tb/waveform/top_pipeline.vcd");
        $dumpvars(0, top_pipeline_tb);
    end

    initial clk = 1'b0;
    always #`HALF_CLOCK_PERIOD clk = ~clk;

    reg [7:0] passed;
    reg [7:0] total;

    task passTest;
        input [15:0]         actualOut;
        input [15:0]         expectedOut;
        input [`STRLEN*8:0]  testName;
        inout [7:0]          p;
        inout [7:0]          n;
        begin
            n = n + 1;
            if (actualOut === expectedOut) begin
                $display("  \033[32mPASS\033[0m  %s  (got 0x%04h)", testName, actualOut);
                p = p + 1;
            end else begin
                $display("  \033[31mFAIL\033[0m  %s  got 0x%04h, expected 0x%04h",
                         testName, actualOut, expectedOut);
            end
        end
    endtask

    task allPassed;
        input [7:0] p;
        input [7:0] n;
        begin
            $display("");
            if (p == n) begin
                $display("========================================");
                $display("  All %0d / %0d tests PASSED.", p, n);
                $display("========================================");
            end else begin
                $display("  %0d / %0d tests PASSED  (%0d FAILED).", p, n, n - p);
            end
        end
    endtask

    reg [15:0] watchdog;

    localparam PROGRAM_WORDS  = 10;
    localparam PIPE_DRAIN     = 6;
    localparam MAX_CYCLES     = 200;

    integer drain_count;

    initial begin
        passed   = 0;
        total    = 0;
        watchdog = 0;

        reset = 1'b1;
        repeat (3) @(posedge clk);
        #1;
        reset = 1'b0;

        $display("");
        $display("================================================================");
        $display("  RISCV-16 PIPELINE — I-Type Instruction Tests");
        $display("================================================================");
        $display("Time=%0t  Reset released, PC=0x%04h", $time, dbg_pc);
        $display("");
        $display("--- Execution trace ---");
        $display("%-8s | %-6s | %-6s | %-6s | %-5s | %-5s | %-5s | %-5s | %-5s | %-6s",
                 "Time", "PC", "Instr", "ALU", "x1", "x2", "x3", "x4", "x5", "x6");
        $display("---------+--------+--------+--------+-------+-------+-------+-------+-------+-------");

        drain_count = -1;

        begin : RUN_LOOP
            while (watchdog < MAX_CYCLES) begin
                @(posedge clk);
                #1;

                $display("%8t | 0x%04h | %04h  | %04h  | %04h  | %04h  | %04h  | %04h  | %04h  | %04h",
                         $time, dbg_pc, dbg_instr, dbg_alu_result,
                         dbg_x1, dbg_x2, dbg_x3, dbg_x4, dbg_x5, dbg_x6);

                if (drain_count < 0 && ((dbg_pc >> 1) >= PROGRAM_WORDS)) begin
                    drain_count = PIPE_DRAIN;
                end

                if (drain_count >= 0) begin
                    drain_count = drain_count - 1;
                    if (drain_count == 0) begin
                        disable RUN_LOOP;
                    end
                end

                watchdog = watchdog + 1;
            end
        end

        @(posedge clk); #1;

        $display("");
        $display("--- Assertion checks ---");

        passTest(dbg_x1, 16'h0006, "ADDI pos: x1 = 5+1 = 6", passed, total);
        passTest(dbg_x2, 16'h0005, "ADDI/XORI/ORI/ANDI: x2 = 5", passed, total);
        passTest(dbg_x3, 16'hFFFF, "ADDI -1 => x3 = 0xFFFF", passed, total);
        passTest(dbg_x4, 16'hFFFE, "ADDI -2 => x4 = 0xFFFE", passed, total);
        passTest(dbg_x5, 16'h001F, "ADDI max +31 => x5 = 0x001F", passed, total);
        passTest(dbg_x6, 16'hFFE0, "ADDI min -32 => x6 = 0xFFE0", passed, total);
        passTest(dbg_x7, 16'h0000, "x7 untouched => 0x0000", passed, total);

        allPassed(passed, total);
        $display("");
        $finish;
    end

endmodule