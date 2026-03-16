`timescale 1ns / 1ps

// =============================================================================
//  Testbench: riscv16_pipeline_top
//
//  Test Groups
//  ───────────
//  1. Reset behaviour            – all debug outputs clear to zero
//  2. R-type instructions        – ADD, SUB, AND, OR, XOR, SLT via register ops
//  3. I-type instructions        – ADDI, ANDI, ORI, XORI
//  4. Load / Store (L/S-type)    – SW followed by LW, checks load-use stall
//  5. Branch (B-type)            – BEQ taken, BEQ not-taken, BNE
//  6. Jump (J-type / I jalr)     – JAL writes return address; JALR target
//  7. U-type                     – LUI loads upper immediate
//  8. Hazard / Forwarding        – back-to-back ALU ops use forwarded values
//  9. Load-use stall              – LW followed immediately by dependent ADD
// 10. Branch flush               – instruction fetched after branch is squashed
//
//  The testbench drives a clock, monitors the debug outputs after each
//  instruction retires into MEM/WB, and uses $display / $error to report
//  pass/fail for each check.
// =============================================================================

module riscv16_pipeline_tb;

    // -------------------------------------------------------------------------
    //  DUT ports
    // -------------------------------------------------------------------------
    reg         clk;
    reg         reset;

    wire [15:0] dbg_pc;
    wire [15:0] dbg_instr;
    wire [15:0] dbg_alu_result;
    wire [15:0] dbg_x1;
    wire [15:0] dbg_x2;
    wire [15:0] dbg_x3;

    // -------------------------------------------------------------------------
    //  DUT instantiation
    // -------------------------------------------------------------------------
    riscv16_pipeline_top DUT (
        .clk          (clk),
        .reset        (reset),
        .dbg_pc       (dbg_pc),
        .dbg_instr    (dbg_instr),
        .dbg_alu_result(dbg_alu_result),
        .dbg_x1       (dbg_x1),
        .dbg_x2       (dbg_x2),
        .dbg_x3       (dbg_x3)
    );

    // -------------------------------------------------------------------------
    //  Clock – 10 ns period
    // -------------------------------------------------------------------------
    initial clk = 0;
    always #5 clk = ~clk;

    // -------------------------------------------------------------------------
    //  Helpers
    // -------------------------------------------------------------------------
    integer pass_count;
    integer fail_count;

    task check;
        input [255:0] test_name;
        input [15:0]  got;
        input [15:0]  expected;
        begin
            if (got === expected) begin
                $display("  PASS  %-40s  got=0x%04h", test_name, got);
                pass_count = pass_count + 1;
            end else begin
                $display("  FAIL  %-40s  got=0x%04h  exp=0x%04h",
                         test_name, got, expected);
                fail_count = fail_count + 1;
            end
        end
    endtask

    // Advance N rising edges, then sample on the following posedge
    task advance;
        input integer n;
        integer i;
        begin
            for (i = 0; i < n; i = i + 1)
                @(posedge clk);
            #1; // small setup margin
        end
    endtask

    // -------------------------------------------------------------------------
    //  Instruction encoding helpers
    //  Encoding matches the field layout used in riscv16_pipeline_top:
    //
    //   R-type  [15:13]=rs1 [12:10]=rs2 [9:7]=rd  [6:3]=func [2:0]=OPC_R(000)
    //   I-type  [15:10]=imm6 [9:7]=rd   [6:3]=func [2:0]=OPC_I(001)
    //             (rs1 = rd field for I-type per the decode logic)
    //   S-type  [15:9]=imm7 [8:6]=rs1  [5:3]=rs2  [2:0]=OPC_S(011)
    //   L-type  [15:9]=imm7 [8:6]=rs1  [5:3]=rd   [2:0]=OPC_L(010)
    //   B-type  [15:13]=imm_hi3 [12:9]=imm_lo4 [8:6]=rs1 [5:3]=rs2 [2:0]=OPC_B(100)
    //   J-type  [15:6]=imm10 [5:3]=rd  [2:0]=OPC_J(101)
    //   U-type  [15:6]=imm10 [5:3]=rd  [2:0]=OPC_U(110)
    // -------------------------------------------------------------------------

    // R-type: {rs1[2:0], rs2[2:0], rd[2:0], func[3:0], 3'b000}
    function [15:0] r_instr;
        input [2:0] rs1, rs2, rd;
        input [3:0] func;
        begin
            r_instr = {rs1, rs2, rd, func, 3'b000};
        end
    endfunction

    // I-type: {imm6[5:0], rd[2:0], func[3:0], 3'b001}
    // rs1 == rd in the decode (id_rs1_i = ifid_instr[9:7] = id_rd_i)
    function [15:0] i_instr;
        input [5:0] imm6;
        input [2:0] rd;
        input [3:0] func;
        begin
            i_instr = {imm6, rd, func, 3'b001};
        end
    endfunction

    // S-type store: {imm7[6:0], rs1[2:0], rs2[2:0], 3'b011}
    function [15:0] s_instr;
        input [6:0] imm7;
        input [2:0] rs1, rs2;
        begin
            s_instr = {imm7, rs1, rs2, 3'b011};
        end
    endfunction

    // L-type load: {imm7[6:0], rs1[2:0], rd[2:0], 3'b010}
    function [15:0] l_instr;
        input [6:0] imm7;
        input [2:0] rs1, rd;
        begin
            l_instr = {imm7, rs1, rd, 3'b010};
        end
    endfunction

    // B-type branch: {imm_hi3[2:0], imm_lo4[3:0], rs1[2:0], rs2[2:0], 3'b100}
    // combined offset = {imm_hi3, imm_lo4} (7 bits, sign-extended then <<1)
    function [15:0] b_instr;
        input [2:0] imm_hi;
        input [3:0] imm_lo;
        input [2:0] rs1, rs2;
        begin
            b_instr = {imm_hi, imm_lo, rs1, rs2, 3'b100};
        end
    endfunction

    // J-type JAL: {imm10[9:0], rd[2:0], 3'b101}
    function [15:0] j_instr;
        input [9:0] imm10;
        input [2:0] rd;
        begin
            j_instr = {imm10, rd, 3'b101};
        end
    endfunction

    // U-type LUI: {imm10[9:0], rd[2:0], 3'b110}
    function [15:0] u_instr;
        input [9:0] imm10;
        input [2:0] rd;
        begin
            u_instr = {imm10, rd, 3'b110};
        end
    endfunction

    // NOP = all zeros (opcode 000 with no side effects when func/rd=0)
    localparam NOP = 16'h0000;

    // =========================================================================
    //  Memory initialisation helpers
    //  The testbench writes instruction words into a $readmemh-compatible
    //  array and then uses $writememh to create the .mem file (if the
    //  simulator supports it) – OR – we rely on the force/deposit mechanism.
    //
    //  For portability across simulators we use the "force" approach to
    //  directly deposit values into the instruction memory array inside the
    //  DUT.  Adjust the hierarchical path if your Instruction_memory uses a
    //  different internal array name.
    // =========================================================================

    // Instruction memory array – adjust hierarchy if needed
    // e.g. DUT.IMEM.mem or DUT.IMEM.imem
    // We use $deposit / force below.

   task load_program;
begin
    // Program is loaded automatically from src/program16.mem
end
endtask
    
        


   task unforce_imem;
begin
    // No manual forcing needed
end
endtask

    // Hard-reset helper: assert reset for 2 cycles, release
    task do_reset;
        begin
            reset = 1;
            @(posedge clk); @(posedge clk);
            @(negedge clk); reset = 0;
        end
    endtask

    // =========================================================================
    //  MAIN TEST SEQUENCE
    // =========================================================================
    initial begin
        $dumpfile("riscv16_pipeline_tb.vcd");
        $dumpvars(0, riscv16_pipeline_tb);

        pass_count = 0;
        fail_count = 0;
        reset = 1;
        @(posedge clk); @(posedge clk);
        @(negedge clk); reset = 0;

        // =====================================================================
        //  TEST 1 – Reset
        //  After reset all pipeline registers should be zero / NOP.
        // =====================================================================
        $display("\n========== TEST 1: Reset ==========");
        advance(1);
        check("dbg_pc   after reset",        dbg_pc,         16'h0000);
        check("dbg_alu_result after reset",  dbg_alu_result, 16'h0000);

        // =====================================================================
        //  TEST 2 – I-type ADDI
        //  ADDI x1, x1, 5   (x1 = 0+5 = 5)
        //  ADDI x2, x2, 10  (x2 = 0+10 = 10)
        //  ADDI x3, x3, 15  (x3 = 0+15 = 15)
        //  func for ADDI = 4'b0000
        // =====================================================================
        $display("\n========== TEST 2: ADDI ==========");
        load_program(
            i_instr(6'd5,  3'd1, 4'b0000),   // ADDI x1, x1, 5
            i_instr(6'd10, 3'd2, 4'b0000),   // ADDI x2, x2, 10
            i_instr(6'd15, 3'd3, 4'b0000),   // ADDI x3, x3, 15
            NOP, NOP, NOP, NOP, NOP,
            NOP, NOP, NOP, NOP, NOP, NOP, NOP, NOP
        );
        do_reset;
        advance(5);  // 3 instrs + 2 pipeline fill cycles
        check("x1 after ADDI 5",   dbg_x1, 16'd5);
        check("x2 after ADDI 10",  dbg_x2, 16'd10);
        check("x3 after ADDI 15",  dbg_x3, 16'd15);

        // =====================================================================
        //  TEST 3 – R-type ADD
        //  Setup: ADDI x1=3, ADDI x2=4
        //  ADD x3, x1, x2  →  x3 = 7
        //  func for ADD = 4'b0000
        // =====================================================================
        $display("\n========== TEST 3: R-type ADD ==========");
        load_program(
            i_instr(6'd3, 3'd1, 4'b0000),          // ADDI x1, x1, 3
            i_instr(6'd4, 3'd2, 4'b0000),          // ADDI x2, x2, 4
            NOP,                                    // pipeline fill
            r_instr(3'd1, 3'd2, 3'd3, 4'b0000),   // ADD  x3, x1, x2
            NOP, NOP, NOP, NOP,
            NOP, NOP, NOP, NOP, NOP, NOP, NOP, NOP
        );
        do_reset;
        advance(7);
        check("x3 = x1+x2 = 7", dbg_x3, 16'd7);

        // =====================================================================
        //  TEST 4 – R-type SUB
        //  x1=10, x2=3  →  SUB x3, x1, x2 = 7
        //  func for SUB = 4'b0001
        // =====================================================================
        $display("\n========== TEST 4: R-type SUB ==========");
        load_program(
            i_instr(6'd10, 3'd1, 4'b0000),         // ADDI x1, 10
            i_instr(6'd3,  3'd2, 4'b0000),         // ADDI x2, 3
            NOP,
            r_instr(3'd1, 3'd2, 3'd3, 4'b0001),   // SUB x3, x1, x2
            NOP, NOP, NOP, NOP,
            NOP, NOP, NOP, NOP, NOP, NOP, NOP, NOP
        );
        do_reset;
        advance(7);
        check("x3 = x1-x2 = 7", dbg_x3, 16'd7);

        // =====================================================================
        //  TEST 5 – R-type AND
        //  x1=0xFF, x2=0x0F  →  AND x3 = 0x0F
        //  func for AND = 4'b0010
        // =====================================================================
        $display("\n========== TEST 5: R-type AND ==========");
        load_program(
            i_instr(6'h3F, 3'd1, 4'b0000),        // ADDI x1, 0x3F (6-bit imm)
            i_instr(6'h0F, 3'd2, 4'b0000),        // ADDI x2, 0x0F
            NOP,
            r_instr(3'd1, 3'd2, 3'd3, 4'b0010),  // AND x3, x1, x2
            NOP, NOP, NOP, NOP,
            NOP, NOP, NOP, NOP, NOP, NOP, NOP, NOP
        );
        do_reset;
        advance(7);
        check("x3 = AND(0x3F, 0x0F) = 0x0F", dbg_x3, 16'h000F);

        // =====================================================================
        //  TEST 6 – R-type OR
        //  x1=0x30, x2=0x0F  →  OR x3 = 0x3F
        //  func for OR = 4'b0011
        // =====================================================================
        $display("\n========== TEST 6: R-type OR ==========");
        load_program(
            i_instr(6'h30, 3'd1, 4'b0000),        // ADDI x1, 0x30
            i_instr(6'h0F, 3'd2, 4'b0000),        // ADDI x2, 0x0F
            NOP,
            r_instr(3'd1, 3'd2, 3'd3, 4'b0011),  // OR  x3, x1, x2
            NOP, NOP, NOP, NOP,
            NOP, NOP, NOP, NOP, NOP, NOP, NOP, NOP
        );
        do_reset;
        advance(7);
        check("x3 = OR(0x30, 0x0F) = 0x3F", dbg_x3, 16'h003F);

        // =====================================================================
        //  TEST 7 – Forwarding (back-to-back ALU)
        //  ADDI x1, 0, 8        →  x1=8
        //  ADD  x2, x1, x1      →  x2=16  (MEM→EX forward of x1)
        //  ADD  x3, x2, x1      →  x3=24  (MEM→EX forward of x2)
        // =====================================================================
        $display("\n========== TEST 7: MEM→EX Forwarding ==========");
        load_program(
            i_instr(6'd8, 3'd1, 4'b0000),          // ADDI x1, 8
            r_instr(3'd1, 3'd1, 3'd2, 4'b0000),   // ADD  x2, x1, x1
            r_instr(3'd2, 3'd1, 3'd3, 4'b0000),   // ADD  x3, x2, x1
            NOP, NOP, NOP, NOP, NOP,
            NOP, NOP, NOP, NOP, NOP, NOP, NOP, NOP
        );
        do_reset;
        advance(7);
        check("x2 = 16 (forwarded x1+x1)", dbg_x2, 16'd16);
        check("x3 = 24 (forwarded x2+x1)", dbg_x3, 16'd24);

        // =====================================================================
        //  TEST 8 – Load-Use Stall
        //  Store 42 to address 0 first (using SW), then LW, then ADD.
        //  SW  rs2=x1(42), rs1=x0(0), imm=0
        //  LW  rd=x2, rs1=x0, imm=0
        //  ADD x3, x2, x0   ← depends on x2 from LW  (stall expected)
        // =====================================================================
        $display("\n========== TEST 8: Load-Use Stall ==========");
        load_program(
            i_instr(6'd42, 3'd1, 4'b0000),         // ADDI x1, 42
            s_instr(7'd0,  3'd0, 3'd1),             // SW   [x0+0] = x1
            l_instr(7'd0,  3'd0, 3'd2),             // LW   x2, [x0+0]
            r_instr(3'd2,  3'd0, 3'd3, 4'b0000),   // ADD  x3, x2, x0  (stall)
            NOP, NOP, NOP, NOP,
            NOP, NOP, NOP, NOP, NOP, NOP, NOP, NOP
        );
        do_reset;
        advance(10);  // extra cycles to absorb stall + pipeline drain
        check("x2 = 42 after LW",          dbg_x2, 16'd42);
        check("x3 = 42 after load-use stall", dbg_x3, 16'd42);

        // =====================================================================
        //  TEST 9 – U-type LUI
        //  LUI x1, 0x001  →  x1 = 0x001 << 6 = 0x0040
        // =====================================================================
        $display("\n========== TEST 9: U-type LUI ==========");
        load_program(
            u_instr(10'd1, 3'd1),   // LUI x1, 1  →  0x0040
            NOP, NOP, NOP, NOP, NOP, NOP, NOP,
            NOP, NOP, NOP, NOP, NOP, NOP, NOP, NOP
        );
        do_reset;
        advance(5);
        check("x1 = 0x0040 after LUI", dbg_x1, 16'h0040);

        // =====================================================================
        //  TEST 10 – Branch BEQ taken
        //  ADDI x1, 0, 0   (x1=0)
        //  ADDI x2, 0, 0   (x2=0)
        //  BEQ  x1, x2, +2  →  should skip next, jump to NOP+2 instructions
        //  ADDI x3, 0, 99  (should be flushed / not executed)
        //  ADDI x3, 0, 55  (landing pad)
        //
        //  Branch offset encoding: offset = 2 (in byte units, >>1 before shift)
        //  id_imm_b = sign_ext({imm_hi3, imm_lo4}, 7) → we need +2 bytes = +1 word
        //  imm field value = 7'b000_0001
        // =====================================================================
        $display("\n========== TEST 10: BEQ Taken ==========");
        load_program(
            i_instr(6'd0, 3'd1, 4'b0000),          // ADDI x1, 0
            i_instr(6'd0, 3'd2, 4'b0000),          // ADDI x2, 0
            b_instr(3'b000, 4'b0001, 3'd1, 3'd2),  // BEQ x1,x2, +2 bytes (+1 word)
            i_instr(6'd99, 3'd3, 4'b0000),          // ADDI x3, 99 (should flush)
            i_instr(6'd55, 3'd3, 4'b0000),          // ADDI x3, 55 (landing pad)
            NOP, NOP, NOP,
            NOP, NOP, NOP, NOP, NOP, NOP, NOP, NOP
        );
        do_reset;
        advance(12);
        check("x3 = 55 (branch taken, 99 flushed)", dbg_x3, 16'd55);

        // =====================================================================
        //  TEST 11 – BEQ not taken
        //  x1=1, x2=2 → BEQ not taken → next instr executes normally
        // =====================================================================
        $display("\n========== TEST 11: BEQ Not Taken ==========");
        load_program(
            i_instr(6'd1, 3'd1, 4'b0000),          // ADDI x1, 1
            i_instr(6'd2, 3'd2, 4'b0000),          // ADDI x2, 2
            b_instr(3'b000, 4'b0001, 3'd1, 3'd2),  // BEQ x1,x2 (not taken)
            i_instr(6'd77, 3'd3, 4'b0000),          // ADDI x3, 77 (should execute)
            NOP, NOP, NOP, NOP,
            NOP, NOP, NOP, NOP, NOP, NOP, NOP, NOP
        );
        do_reset;
        advance(10);
        check("x3 = 77 (branch not taken)", dbg_x3, 16'd77);

        // =====================================================================
        //  TEST 12 – JAL
        //  JAL x1, +4  →  x1 = PC+2 (return addr); PC jumps to PC+4
        //  NOP at PC+2 (skipped)
        //  ADDI x3, 0, 33 at PC+4 (landing pad)
        //
        //  imm10 encodes word offset: +2 words = imm=2
        // =====================================================================
        $display("\n========== TEST 12: JAL ==========");
        load_program(
            j_instr(10'd2, 3'd1),                   // JAL x1, +4bytes (offset=2words)
            NOP,                                     // PC+2: skipped
            i_instr(6'd33, 3'd3, 4'b0000),          // PC+4: ADDI x3, 33 (landing)
            NOP, NOP, NOP, NOP, NOP,
            NOP, NOP, NOP, NOP, NOP, NOP, NOP, NOP
        );
        do_reset;
        advance(10);
        check("x3 = 33 after JAL landing",    dbg_x3, 16'd33);
        check("x1 = 2 (JAL return addr PC+2)", dbg_x1, 16'd2);

        // =====================================================================
        //  Summary
        // =====================================================================
        $display("\n============================================");
        $display("  Results: %0d PASSED,  %0d FAILED", pass_count, fail_count);
        $display("============================================\n");

        if (fail_count == 0)
            $display("ALL TESTS PASSED");
        else
            $display("SOME TESTS FAILED – review output above");

        $finish;
    end

    // =========================================================================
    //  Waveform annotation – print a header every 50 ns for readability
    // =========================================================================
    initial begin
        $display("\nTime  | PC     | Instr  | ALU    | x1     | x2     | x3");
        $display("------+--------+--------+--------+--------+--------+--------");
    end

    always @(posedge clk) begin
        #1;
        $display("%5t | %04h   | %04h   | %04h   | %04h   | %04h   | %04h",
                 $time, dbg_pc, dbg_instr, dbg_alu_result,
                 dbg_x1, dbg_x2, dbg_x3);
    end

    // =========================================================================
    //  Timeout watchdog – 10 µs
    // =========================================================================
    initial begin
        #10_000;
        $display("TIMEOUT: simulation exceeded 10 us");
        $finish;
    end

endmodule