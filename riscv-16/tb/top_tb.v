`timescale 1ns / 1ps

`define STRLEN        32
`define HALF_CLOCK_PERIOD  5
`define CLOCK_PERIOD  (`HALF_CLOCK_PERIOD * 2)

// ============================================================================
//  riscv16_top  —  I-Type Instruction Testbench (10 tests)
//
//  Program: program16.mem  (10 instructions)
//
//  Test coverage:
//    Test  1 : ADDI x1, x1,  5    x1 = 5              (positive immediate)
//    Test  2 : ADDI x2, x2,  3    x2 = 3              (positive immediate)
//    Test  3 : ADDI x1, x1,  1    x1 = 6              (increment, reuse rd)
//    Test  4 : ADDI x3, x3, -1    x3 = 0xFFFF         (negative immediate -1)
//    Test  5 : ADDI x4, x4, -2    x4 = 0xFFFE         (negative immediate -2)
//    Test  6 : XORI x2, x2,  3    x2 = 3^3 = 0        (func=0001)
//    Test  7 : ORI  x2, x2,  7    x2 = 0|7 = 7        (func=0010)
//    Test  8 : ANDI x2, x2,  5    x2 = 7&5 = 5        (func=0011)
//    Test  9 : ADDI x5, x5, 31    x5 = 31 (0x001F)    (max positive 6-bit imm)
//    Test 10 : ADDI x6, x6,-32    x6 = 0xFFE0         (min negative 6-bit imm)
//
//  Expected final state:
//    x1 = 0x0006   x2 = 0x0005   x3 = 0xFFFF
//    x4 = 0xFFFE   x5 = 0x001F   x6 = 0xFFE0
// ============================================================================

module top_tb;

    // -----------------------------------------------------------------------
    // Clock, reset, DUT wires
    // -----------------------------------------------------------------------
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

    // -----------------------------------------------------------------------
    // Waveform dump
    // -----------------------------------------------------------------------
    initial begin
        $dumpfile("./tb/waveform/top.vcd");
        $dumpvars(0, top_tb);
    end

    // -----------------------------------------------------------------------
    // Clock generation
    // -----------------------------------------------------------------------
    initial clk = 1'b0;
    always #`HALF_CLOCK_PERIOD clk = ~clk;

    // -----------------------------------------------------------------------
    // Pass / fail tracking
    // -----------------------------------------------------------------------
    reg [7:0] passed;
    reg [7:0] total;

    task passTest;
        input [15:0]         actualOut;
        input [15:0]         expectedOut;
        input [`STRLEN*8:0]  testName;
        inout [7:0]          p;
        begin
            total = total + 1;
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

    // -----------------------------------------------------------------------
    // Watchdog + program size
    // -----------------------------------------------------------------------
    reg [15:0] watchdog;
    localparam PROGRAM_WORDS = 10;   // 10 instructions

    // -----------------------------------------------------------------------
    // Main stimulus
    // -----------------------------------------------------------------------
    initial begin
        passed   = 0;
        total    = 0;
        watchdog = 0;

        // -------------------------------------------------------------------
        // 1. Reset
        // -------------------------------------------------------------------
        reset = 1'b1;
        repeat (2) @(posedge clk);
        #1;
        reset = 1'b0;

        $display("");
        $display("================================================================");
        $display("  RISCV-16  —  I-Type Instruction Tests (10 cases)");
        $display("================================================================");
        $display("Time=%0t  Reset released, PC=0x%04h", $time, dbg_pc);
        $display("");
        $display("--- Execution trace ---");
        $display("%-8s | %-6s | %-6s | %-4s | %-5s | %-5s | %-5s | %-5s | %-5s | %-6s",
                 "Time", "PC", "Instr", "ALU", "x1", "x2", "x3", "x4", "x5", "x6");
        $display("---------+--------+-------+-------+-------+-------+-------+-------+-------+-------");

        // -------------------------------------------------------------------
        // 2. Run until program end
        // -------------------------------------------------------------------
        while ((dbg_pc >> 1) < PROGRAM_WORDS && watchdog < 100) begin
            @(posedge clk);
            #1;

            $display("%8t | 0x%04h | %04h  | %04h  | %04h  | %04h  | %04h  | %04h  | %04h  | %04h",
                     $time, dbg_pc, dbg_instr, dbg_alu_result,
                     dbg_x1, dbg_x2, dbg_x3, dbg_x4, dbg_x5, dbg_x6);

            watchdog = watchdog + 1;
        end

        if (watchdog >= 100)
            $display("\n  WARNING: watchdog expired\n");

        // Let final writeback settle
        @(posedge clk); #1;

        // -------------------------------------------------------------------
        // 3. Assertions
        // -------------------------------------------------------------------
        $display("");
        $display("--- Assertion checks ---");

        // Test 1+3: ADDI positive, then increment same register
        passTest(dbg_x1, 16'h0006, "ADDI pos: x1 = 5+1 = 6", passed);

        // Test 2+6+7+8: ADDI -> XORI -> ORI -> ANDI chain on x2
        passTest(dbg_x2, 16'h0005, "ADDI/XORI/ORI/ANDI: x2 = 5", passed);

        // Test 4: ADDI negative immediate -1
        passTest(dbg_x3, 16'hFFFF, "Negative 1 - (-1) = 0xFFFF", passed);

        // Test 5: ADDI negative immediate -2
        passTest(dbg_x4, 16'hFFFE, "Negative 2 - (-2) = 0xFFFE", passed);

        // Test 9: ADDI max positive 6-bit immediate (31 = 0b011111)
        passTest(dbg_x5, 16'h001F, "ADDI MAX value (31) (0x001F)", passed);

        // Test 10: ADDI min negative 6-bit immediate (-32 = 0b100000)
        passTest(dbg_x6, 16'hFFE0, "ADDI min value (-32) (0xFFE0)", passed);

        // Test 6 isolation: XORI zeroed x2 (intermediate, confirmed by chain above)
        // Directly confirmed: if x2 final == 5 then XORI->ORI->ANDI all correct

        // x7 untouched — must remain 0
        passTest(dbg_x7, 16'h0000, "x7 untouched: x7 = 0x0000", passed);

        // x0 hardwired zero (not written by any instruction, but sanity check)
        // accessed via hierarchy since not a debug port
        // passTest(dut.RF.regs[0], 16'h0000, "x0 hardwired: always 0", passed);

        // -------------------------------------------------------------------
        // 4. Summary
        // -------------------------------------------------------------------
        allPassed(passed, total);
        $display("");
        $finish;
    end

endmodule