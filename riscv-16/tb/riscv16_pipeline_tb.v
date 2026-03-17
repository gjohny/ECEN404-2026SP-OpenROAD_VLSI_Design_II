`timescale 1ns / 1ps

// =============================================================================
//  Testbench : riscv16_pipeline_top  (Icarus Verilog compatible)
//
//  Changes vs original:
//    • Per-test pass/fail tracking via test_pass[] array (T1–T13).
//    • Named result summary table printed at end of simulation.
//    • check() task now takes a test-index argument so each assertion
//      is attributed to the correct test slot.
//    • All instruction encodings, timing, and program content are
//      identical to the original testbench.
// =============================================================================

module riscv16_pipeline_tb;

    // ─── DUT ports ────────────────────────────────────────────────────────────
    reg         clk;
    reg         reset;

    wire [15:0] dbg_pc;
    wire [15:0] dbg_instr;
    wire [15:0] dbg_alu_result;
    wire [15:0] dbg_x1;
    wire [15:0] dbg_x2;
    wire [15:0] dbg_x3;

    riscv16_pipeline_top DUT (
        .clk           (clk),
        .reset         (reset),
        .dbg_pc        (dbg_pc),
        .dbg_instr     (dbg_instr),
        .dbg_alu_result(dbg_alu_result),
        .dbg_x1        (dbg_x1),
        .dbg_x2        (dbg_x2),
        .dbg_x3        (dbg_x3)
    );

    // ─── Clock  (10 ns period) ────────────────────────────────────────────────
    initial clk = 0;
    always #5 clk = ~clk;

    // =========================================================================
    //  Scoreboard  –  per-test tracking
    //  Index 1..13 maps directly to T1..T13.
    //  0 = unused.
    //  test_pass[i] = 1  → all checks in that test passed
    //  test_pass[i] = 0  → at least one check failed
    // =========================================================================
    integer pass_count;
    integer fail_count;
    reg [13:0] test_pass;   // bit i = result for Ti (1=pass, 0=fail)
    reg [13:0] test_seen;   // bit i set when first check for Ti runs

    // Labels for the summary (packed string per test)
    // Stored as a simple 2-D array of bytes for display purposes.
    reg [239:0] test_label [1:13];

    // check task now takes a test index so each assertion is attributed
    // to the correct slot in test_pass[].
    task check;
        input integer    tidx;          // which test (1–13)
        input [239:0]    name;
        input [15:0]     got;
        input [15:0]     exp;
        begin
            // Mark this test as having been seen
            test_seen[tidx] = 1'b1;

            if (got === exp) begin
                $display("  PASS  %-36s  got=0x%04h", name, got);
                pass_count = pass_count + 1;
                // Keep test_pass[tidx]=1 only if it was already 1
                // (initial value set before each test block)
            end else begin
                $display("  FAIL  %-36s  got=0x%04h  exp=0x%04h",
                         name, got, exp);
                fail_count = fail_count + 1;
                test_pass[tidx] = 1'b0;   // any failure marks the test failed
            end
        end
    endtask

    // Helper: mark the start of a test (resets per-test state to PASS).
    task begin_test;
        input integer tidx;
        begin
            test_pass[tidx] = 1'b1;
        end
    endtask

    // Advance N rising edges then a 1 ns setup margin
    task advance;
        input integer n;
        integer k;
        begin
            for (k = 0; k < n; k = k + 1)
                @(posedge clk);
            #1;
        end
    endtask

    // ─── Program loader ───────────────────────────────────────────────────────
    reg [15:0] prog [0:255];

    task load_program;
        input [15:0] i0,  i1,  i2,  i3,
                     i4,  i5,  i6,  i7,
                     i8,  i9,  i10, i11,
                     i12, i13, i14, i15;
        integer j;
        begin
            prog[0]=i0;  prog[1]=i1;  prog[2]=i2;  prog[3]=i3;
            prog[4]=i4;  prog[5]=i5;  prog[6]=i6;  prog[7]=i7;
            prog[8]=i8;  prog[9]=i9;  prog[10]=i10; prog[11]=i11;
            prog[12]=i12; prog[13]=i13; prog[14]=i14; prog[15]=i15;
            for (j = 16; j < 256; j = j + 1) prog[j] = 16'h0000;
            $writememh("tb_prog_tmp.mem", prog);
            $readmemh("tb_prog_tmp.mem", DUT.IMEM.memory);
        end
    endtask

    // Hard reset: 2 clocks asserted, released on negedge
    task do_reset;
        begin
            reset = 1;
            @(posedge clk); @(posedge clk);
            @(negedge clk); reset = 0;
        end
    endtask

    // ─── Instruction encoding functions ──────────────────────────────────────

    function [15:0] r_instr;
        input [2:0] rs1, rs2, rd;
        input [3:0] func;
        r_instr = {rs1, rs2, rd, func, 3'b000};
    endfunction

    function [15:0] i_instr;
        input [5:0] imm6;
        input [2:0] rd;
        input [3:0] func;
        i_instr = {imm6, rd, func, 3'b001};
    endfunction

    function [15:0] l_instr;
        input [6:0] imm7;
        input [2:0] rs1, rd;
        l_instr = {imm7, rs1, rd, 3'b010};
    endfunction

    function [15:0] s_instr;
        input [6:0] imm7;
        input [2:0] rs1, rs2;
        s_instr = {imm7, rs1, rs2, 3'b011};
    endfunction

    function [15:0] b_instr;
        input [4:0] imm5;
        input [2:0] rs1, rs2;
        b_instr = {imm5, rs1, rs2, 3'b100};
    endfunction

    function [15:0] j_instr;
        input [9:0] imm10;
        input [2:0] rd;
        j_instr = {imm10, rd, 3'b101};
    endfunction

    function [15:0] u_instr;
        input [9:0] imm10;
        input [2:0] rd;
        u_instr = {imm10, rd, 3'b110};
    endfunction

    function [15:0] jr_instr;
        input [6:0] imm7;
        input [2:0] rs1, rd;
        jr_instr = {imm7, 1'b0, rs1, rd, 3'b111};
    endfunction

    localparam NOP = 16'h0000;

    // =========================================================================
    //  TESTS
    // =========================================================================
    initial begin
        $dumpfile("riscv16_pipeline_tb.vcd");
        $dumpvars(0, riscv16_pipeline_tb);

        // ── Initialise scoreboard ─────────────────────────────────────────────
        pass_count  = 0;
        fail_count  = 0;
        test_pass   = 14'h3FFE;   // bits 1–13 start as 1 (pass); bit 0 unused
        test_seen   = 14'h0000;

        // Pre-load test labels (displayed in summary table)
        test_label[1]  = "T1  Reset Sanity";
        test_label[2]  = "T2  ADDI (I-type)";
        test_label[3]  = "T3  R-type ADD";
        test_label[4]  = "T4  R-type SUB";
        test_label[5]  = "T5  R-type AND";
        test_label[6]  = "T6  R-type OR";
        test_label[7]  = "T7  MEM->EX Forwarding";
        test_label[8]  = "T8  Load-Use Stall";
        test_label[9]  = "T9  LUI (U-type)";
        test_label[10] = "T10 BEQ Taken";
        test_label[11] = "T11 BEQ Not Taken";
        test_label[12] = "T12 JAL";
        test_label[13] = "T13 JALR";

        // Initial reset before any program is loaded
        reset = 1;
        @(posedge clk); @(posedge clk);
        @(negedge clk); reset = 0;

        // ==================================================================
        //  T1 – Reset sanity
        // ==================================================================
        $display("\n=== T1: Reset ===");
        begin_test(1);
        advance(1);
        check(1, "pc after reset",         dbg_pc,         16'h0000);
        check(1, "alu_result after reset",  dbg_alu_result, 16'h0000);

        // ==================================================================
        //  T2 – ADDI
        // ==================================================================
        $display("\n=== T2: ADDI ===");
        begin_test(2);
        load_program(
            i_instr(6'd5,  3'd1, 4'b0000),
            i_instr(6'd10, 3'd2, 4'b0000),
            i_instr(6'd15, 3'd3, 4'b0000),
            NOP, NOP, NOP, NOP, NOP,
            NOP, NOP, NOP, NOP, NOP, NOP, NOP, NOP
        );
        do_reset;
        advance(6);
        check(2, "x1=5  (ADDI)",  dbg_x1, 16'd5);
        check(2, "x2=10 (ADDI)",  dbg_x2, 16'd10);
        check(2, "x3=15 (ADDI)",  dbg_x3, 16'd15);

        // ==================================================================
        //  T3 – R-type ADD
        // ==================================================================
        $display("\n=== T3: R-type ADD ===");
        begin_test(3);
        load_program(
            i_instr(6'd3, 3'd1, 4'b0000),
            i_instr(6'd4, 3'd2, 4'b0000),
            NOP,
            r_instr(3'd1, 3'd2, 3'd3, 4'b0000),
            NOP, NOP, NOP, NOP,
            NOP, NOP, NOP, NOP, NOP, NOP, NOP, NOP
        );
        do_reset;
        advance(8);
        check(3, "x3=7 (ADD)", dbg_x3, 16'd7);

        // ==================================================================
        //  T4 – R-type SUB
        // ==================================================================
        $display("\n=== T4: R-type SUB ===");
        begin_test(4);
        load_program(
            i_instr(6'd10, 3'd1, 4'b0000),
            i_instr(6'd3,  3'd2, 4'b0000),
            NOP,
            r_instr(3'd1, 3'd2, 3'd3, 4'b0001),
            NOP, NOP, NOP, NOP,
            NOP, NOP, NOP, NOP, NOP, NOP, NOP, NOP
        );
        do_reset;
        advance(8);
        check(4, "x3=7 (SUB)", dbg_x3, 16'd7);

        // ==================================================================
        //  T5 – R-type AND
        // ==================================================================
        $display("\n=== T5: R-type AND ===");
        begin_test(5);
        load_program(
            i_instr(6'h3F, 3'd1, 4'b0000),
            i_instr(6'h0F, 3'd2, 4'b0000),
            NOP,
            r_instr(3'd1, 3'd2, 3'd3, 4'b0010),
            NOP, NOP, NOP, NOP,
            NOP, NOP, NOP, NOP, NOP, NOP, NOP, NOP
        );
        do_reset;
        advance(8);
        check(5, "x3=0x0F (AND)", dbg_x3, 16'h000F);

        // ==================================================================
        //  T6 – R-type OR
        // ==================================================================
        $display("\n=== T6: R-type OR ===");
        begin_test(6);
        load_program(
            i_instr(6'h30, 3'd1, 4'b0000),
            i_instr(6'h0F, 3'd2, 4'b0000),
            NOP,
            r_instr(3'd1, 3'd2, 3'd3, 4'b0011),
            NOP, NOP, NOP, NOP,
            NOP, NOP, NOP, NOP, NOP, NOP, NOP, NOP
        );
        do_reset;
        advance(8);
        check(6, "x3=0x3F (OR)", dbg_x3, 16'h003F);

        // ==================================================================
        //  T7 – MEM→EX Forwarding
        // ==================================================================
        $display("\n=== T7: MEM->EX Forwarding ===");
        begin_test(7);
        load_program(
            i_instr(6'd8, 3'd1, 4'b0000),
            r_instr(3'd1, 3'd1, 3'd2, 4'b0000),
            r_instr(3'd2, 3'd1, 3'd3, 4'b0000),
            NOP, NOP, NOP, NOP, NOP,
            NOP, NOP, NOP, NOP, NOP, NOP, NOP, NOP
        );
        do_reset;
        advance(8);
        check(7, "x2=16 (forwarded x1+x1)", dbg_x2, 16'd16);
        check(7, "x3=24 (forwarded x2+x1)", dbg_x3, 16'd24);

        // ==================================================================
        //  T8 – Load-Use Stall
        // ==================================================================
        $display("\n=== T8: Load-Use Stall ===");
        begin_test(8);
        load_program(
            i_instr(6'd42, 3'd1, 4'b0000),
            s_instr(7'd0,  3'd0, 3'd1),
            l_instr(7'd0,  3'd0, 3'd2),
            r_instr(3'd2,  3'd0, 3'd3, 4'b0000),
            NOP, NOP, NOP, NOP,
            NOP, NOP, NOP, NOP, NOP, NOP, NOP, NOP
        );
        do_reset;
        advance(12);
        check(8, "x2=42 (after LW)",          dbg_x2, 16'd42);
        check(8, "x3=42 (load-use stall ok)",  dbg_x3, 16'd42);

        // ==================================================================
        //  T9 – LUI
        // ==================================================================
        $display("\n=== T9: LUI ===");
        begin_test(9);
        load_program(
            u_instr(10'd1, 3'd1),
            NOP, NOP, NOP, NOP, NOP, NOP, NOP,
            NOP, NOP, NOP, NOP, NOP, NOP, NOP, NOP
        );
        do_reset;
        advance(6);
        check(9, "x1=0x0040 (LUI 1)", dbg_x1, 16'h0040);

        // ==================================================================
        //  T10 – BEQ taken
        // ==================================================================
        $display("\n=== T10: BEQ Taken ===");
        begin_test(10);
        load_program(
            i_instr(6'd0, 3'd1, 4'b0000),
            i_instr(6'd0, 3'd2, 4'b0000),
            b_instr(5'd2, 3'd1, 3'd2),
            i_instr(6'd99, 3'd3, 4'b0000),
            i_instr(6'd55, 3'd3, 4'b0000),
            NOP, NOP, NOP,
            NOP, NOP, NOP, NOP, NOP, NOP, NOP, NOP
        );
        do_reset;
        advance(12);
        check(10, "x3=55 (BEQ taken, 99 flushed)", dbg_x3, 16'd55);

        // ==================================================================
        //  T11 – BEQ not taken
        // ==================================================================
        $display("\n=== T11: BEQ Not Taken ===");
        begin_test(11);
        load_program(
            i_instr(6'd1, 3'd1, 4'b0000),
            i_instr(6'd2, 3'd2, 4'b0000),
            b_instr(5'd2, 3'd1, 3'd2),
            i_instr(6'd77, 3'd3, 4'b0000),
            NOP, NOP, NOP, NOP,
            NOP, NOP, NOP, NOP, NOP, NOP, NOP, NOP
        );
        do_reset;
        advance(10);
        check(11, "x3=77 (BEQ not taken)", dbg_x3, 16'd77);

        // ==================================================================
        //  T12 – JAL
        // ==================================================================
        $display("\n=== T12: JAL ===");
        begin_test(12);
        load_program(
            j_instr(10'd2, 3'd1),
            NOP,
            i_instr(6'd33, 3'd3, 4'b0000),
            NOP, NOP, NOP, NOP, NOP,
            NOP, NOP, NOP, NOP, NOP, NOP, NOP, NOP
        );
        do_reset;
        advance(10);
        check(12, "x3=33 (JAL landing)",     dbg_x3, 16'd33);
        check(12, "x1=2  (JAL return addr)", dbg_x1, 16'd2);

        // ==================================================================
        //  T13 – JALR
        // ==================================================================
        $display("\n=== T13: JALR ===");
        begin_test(13);
        load_program(
            i_instr(6'd6, 3'd1, 4'b0000),
            NOP,
            jr_instr(7'd0, 3'd1, 3'd2),
            i_instr(6'd88, 3'd3, 4'b0000),
            NOP, NOP, NOP, NOP,
            NOP, NOP, NOP, NOP, NOP, NOP, NOP, NOP
        );
        do_reset;
        advance(10);
        check(13, "x3=88 (JALR landing)",  dbg_x3, 16'd88);
        check(13, "x2=6  (JALR ret addr)", dbg_x2, 16'd6);

        // ==================================================================
        //  PER-INSTRUCTION RESULT SUMMARY
        // ==================================================================
        $display("");
        $display("╔══════════════════════════════════════════════════════════╗");
        $display("║            PER-INSTRUCTION TEST RESULTS                 ║");
        $display("╠══════╦══════════════════════════════════════╦════════════╣");
        $display("║  ID  ║  Instruction / Feature Tested        ║   Result   ║");
        $display("╠══════╬══════════════════════════════════════╬════════════╣");

        begin : summary_block
            integer i;
            for (i = 1; i <= 13; i = i + 1) begin
                if (!test_seen[i]) begin
                    $display("║  T%-2d  ║  %-36s  ║  %-8s  ║",
                             i, test_label[i], "SKIPPED");
                end else if (test_pass[i]) begin
                    $display("║  T%-2d  ║  %-36s  ║   PASS     ║",
                             i, test_label[i]);
                end else begin
                    $display("║  T%-2d  ║  %-36s  ║ **FAIL**   ║",
                             i, test_label[i]);
                end
            end
        end

        $display("╠══════╩══════════════════════════════════════╩════════════╣");
        $display("║  Total checks:  %-3d passed,  %-3d failed               ║",
                 pass_count, fail_count);
        $display("╚══════════════════════════════════════════════════════════╝");

        if (fail_count == 0)
            $display("\n  *** ALL TESTS PASSED ***\n");
        else
            $display("\n  *** %0d TEST(S) FAILED – review output above ***\n",
                     fail_count);

        $finish;
    end

    // ─── Cycle trace ──────────────────────────────────────────────────────────
    initial begin
        $display("\nTime | PC   | Instr | ALU  | x1   | x2   | x3");
        $display("-----+------+-------+------+------+------+------");
    end
    always @(posedge clk) #1
        $display("%4t | %04h | %04h  | %04h | %04h | %04h | %04h",
                 $time, dbg_pc, dbg_instr, dbg_alu_result,
                 dbg_x1, dbg_x2, dbg_x3);

    // ─── Watchdog ─────────────────────────────────────────────────────────────
    initial begin
        #30_000;
        $display("TIMEOUT – simulation exceeded 30 us");
        $finish;
    end

endmodule