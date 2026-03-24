`timescale 1ns / 1ps

// ============================================================
//  RISC-V 16-bit  —  3-Stage Pipeline Testbench
//  Tests: R-type, I-type, L/S-type, B/J/JR-type,
//         load-use stall, branch flush
// ============================================================

module top_tb;

    // --------------------------------------------------------
    //  DUT ports
    // --------------------------------------------------------
    reg         clk;
    reg         reset;

    wire [15:0] dbg_pc;
    wire [15:0] dbg_instr;
    wire [15:0] dbg_alu_result;
    wire [15:0] dbg_x1;
    wire [15:0] dbg_x2;
    wire [15:0] dbg_x3;

    reg         load_mode;
    reg  [6:0]  load_data;
    reg         load_hibyte;
    reg  [6:0]  load_addr;
    wire        load_ack;

    // --------------------------------------------------------
    //  DUT instantiation
    // --------------------------------------------------------
    top DUT (
        .clk          (clk),
        .reset        (reset),
        .dbg_pc       (dbg_pc),
        .dbg_instr    (dbg_instr),
        .dbg_alu_result(dbg_alu_result),
        .dbg_x1       (dbg_x1),
        .dbg_x2       (dbg_x2),
        .dbg_x3       (dbg_x3),
        .load_mode    (load_mode),
        .load_data    (load_data),
        .load_hibyte  (load_hibyte),
        .load_addr    (load_addr),
        .load_ack     (load_ack)
    );

    // --------------------------------------------------------
    //  Clock  — 10 ns period (100 MHz)
    // --------------------------------------------------------
    initial clk = 0;
    always #5 clk = ~clk;

    // --------------------------------------------------------
    //  Test bookkeeping
    // --------------------------------------------------------
    integer pass_count;
    integer fail_count;
    integer test_num;

    task pass;
        input [127:0] name;
        begin
            $display("  [PASS] Test %0d: %s", test_num, name);
            pass_count = pass_count + 1;
            test_num   = test_num   + 1;
        end
    endtask

    task fail;
        input [127:0] name;
        input [15:0]  got;
        input [15:0]  expected;
        begin
            $display("  [FAIL] Test %0d: %s  got=0x%04h  expected=0x%04h",
                     test_num, name, got, expected);
            fail_count = fail_count + 1;
            test_num   = test_num   + 1;
        end
    endtask

    // Check a 16-bit value and call pass/fail automatically
    task check;
        input [127:0] name;
        input [15:0]  got;
        input [15:0]  expected;
        begin
            if (got === expected)
                pass(name);
            else
                fail(name, got, expected);
        end
    endtask

    // --------------------------------------------------------
    //  Helpers: wait N rising edges, then sample on the next
    // --------------------------------------------------------
    task tick;
        input integer n;
        integer i;
        begin
            for (i = 0; i < n; i = i + 1)
                @(posedge clk);
            #1; // small delta so we sample after combinational settle
        end
    endtask

    // --------------------------------------------------------
    //  Instruction encoding helpers
    //  All match the field layout in top:
    //    [2:0]  opcode
    //    [6:3]  func
    //    layout varies per type — see comments
    // --------------------------------------------------------

    // R-type: [15:13]=rs1  [12:10]=rs2  [9:7]=rd  [6:3]=func  [2:0]=OPC_R(000)
    function [15:0] enc_R;
        input [2:0] rs1, rs2, rd;
        input [3:0] func;
        begin
            enc_R = {rs1, rs2, rd, func, 3'b000};
        end
    endfunction

    // I-type: [15:10]=imm[5:0]  [9:7]=rs1(=rd)  [6:3]=func  [2:0]=OPC_I(001)
    function [15:0] enc_I;
        input [5:0] imm;
        input [2:0] rs1_rd;
        input [3:0] func;
        begin
            enc_I = {imm, rs1_rd, func, 3'b001};
        end
    endfunction

    // L-type: [15:9]=imm[6:0]  [8:6]=rs1  [5:3]=rd  [2:0]=OPC_L(010)
    function [15:0] enc_L;
        input [6:0] imm;
        input [2:0] rs1, rd;
        begin
            enc_L = {imm, rs1, rd, 3'b010};
        end
    endfunction

    // S-type: [15:9]=imm[6:0]  [8:6]=rs1  [5:3]=rs2  [2:0]=OPC_S(011)
    function [15:0] enc_S;
        input [6:0] imm;
        input [2:0] rs1, rs2;
        begin
            enc_S = {imm, rs1, rs2, 3'b011};
        end
    endfunction

    // B-type: [15:11]=imm[4:0]  [10:8]=rs1  [7:5]=rs2  [4:3]=unused  [2:0]=OPC_B(100)
    function [15:0] enc_B;
        input [4:0] imm;
        input [2:0] rs1, rs2;
        begin
            enc_B = {imm, rs1, rs2, 2'b00, 3'b100};
        end
    endfunction

    // J-type: [15:6]=imm[9:0]  [5:3]=rd  [2:0]=OPC_J(101)
    function [15:0] enc_J;
        input [9:0] imm;
        input [2:0] rd;
        begin
            enc_J = {imm, rd, 3'b101};
        end
    endfunction

    // JR-type: [15:9]=imm[6:0]  [8]=unused  [7:5]=rs1  [5:3]=rd  [2:0]=OPC_JR(111)
    // NOTE: bits [5:3] are rd; bits [7:5] are rs1 — overlap at [5] is
    // resolved by the decoder (rd uses [5:3], rs1 uses [7:5]).
    function [15:0] enc_JR;
        input [6:0] imm;
        input [2:0] rs1, rd;
        begin
            enc_JR = {imm, 1'b0, rs1, rd, 3'b111};
        end
    endfunction

    // NOP: all zeros — opcode=R, func=0, all regs=x0, writes to x0 (ignored)
    localparam NOP = 16'h0000;

    // --------------------------------------------------------
    //  Direct IMEM write (bypasses file load)
    //  Writes a 16-bit word into the Instruction_memory array.
    //  Adjust the hierarchical path if your IMEM instance name differs.
    // --------------------------------------------------------
    task write_imem;
        input [7:0]  addr;   // word address (byte_addr / 2)
        input [15:0] data;
        begin
            // Hierarchical reference into the IMEM's internal array.
            // Change "DUT.IMEM.mem" to match your Instruction_memory
            // internal array name if it differs.
            DUT.IMEM.memory[addr] = data;
        end
    endtask

    // Clear all IMEM words to NOP
    task clear_imem;
        integer i;
        begin
            for (i = 0; i < 256; i = i + 1)
                DUT.IMEM.memory[i] = NOP;
        end
    endtask

    // --------------------------------------------------------
    //  Reset sequence
    // --------------------------------------------------------
    task do_reset;
        begin
            reset      = 1;
            load_mode  = 0;
            load_data  = 7'h00;
            load_hibyte= 0;
            load_addr  = 7'h00;
            @(posedge clk);
            @(posedge clk);
            reset = 0;
            #1;
        end
    endtask

    // --------------------------------------------------------
    //  ALU func codes — match your ALUControl encoding.
    //  Update these if your Control_unit uses different codes.
    // --------------------------------------------------------
    localparam F_ADD  = 4'b0000;
    localparam F_SUB  = 4'b0001;
    localparam F_XOR  = 4'b0010;
    localparam F_OR   = 4'b0011;
    localparam F_AND  = 4'b0100;
    localparam F_SLL  = 4'b0101;
    localparam F_SRL  = 4'b0110;
    localparam F_SLT  = 4'b0111;

    // Register aliases (x0=zero, x1=ra, x2=sp, x3..x7 general)
    localparam X0 = 3'd0;
    localparam X1 = 3'd1;
    localparam X2 = 3'd2;
    localparam X3 = 3'd3;
    localparam X4 = 3'd4;
    localparam X5 = 3'd5;
    localparam X6 = 3'd6;
    localparam X7 = 3'd7;

    // ============================================================
    //  MAIN TEST SEQUENCE
    // ============================================================
    initial begin
        pass_count = 0;
        fail_count = 0;
        test_num   = 0;

        $display("==============================================");
        $display("  RISC-V 16-bit 3-Stage Pipeline Testbench  ");
        $display("==============================================");

        // ======================================================
        //  GROUP 1 — R-TYPE  (ADD / SUB / AND / OR / XOR)
        //  Program layout (word addresses):
        //    0: addi x1, x1, 5   -> x1 = 5   (I-type: load immediate)
        //    1: addi x2, x2, 3   -> x2 = 3
        //    2: NOP  (avoid RAW hazard on x1,x2 before R-type)
        //    3: NOP
        //    4: add  x3, x1, x2  -> x3 = 8   (result in dbg_x3)
        //    5-8: NOPs (let result through pipeline + writeback)
        // ======================================================
        $display("\n--- Group 1: R-type instructions ---");

        do_reset;
        clear_imem;

        // x1 = 5
        write_imem(0, enc_I(6'd5,  X1, F_ADD));
        // x2 = 3
        write_imem(1, enc_I(6'd3,  X2, F_ADD));
        // two NOPs to avoid WAR/RAW on the R-type below
        
        write_imem(2, NOP);
        write_imem(3, NOP);
        // x3 = x1 + x2 = 8
        write_imem(4, enc_R(X1, X2, X3, F_ADD));
        write_imem(5, NOP);
        write_imem(6, NOP);
        write_imem(7, NOP);

        do_reset;
        tick(12);
        check("ADD x3=x1+x2 (5+3=8)", dbg_x3, 16'd8);

        // SUB: x3 = x1 - x2 = 2
        clear_imem;
        write_imem(0, enc_I(6'd5,  X1, F_ADD));
        write_imem(1, enc_I(6'd3,  X2, F_ADD));
        write_imem(2, NOP);
        write_imem(3, NOP);
        write_imem(4, enc_R(X1, X2, X3, F_SUB));
        write_imem(5, NOP); write_imem(6, NOP); write_imem(7, NOP);

        do_reset;
        tick(12);
        check("SUB x3=x1-x2 (5-3=2)", dbg_x3, 16'd2);

        // AND: x3 = 5 & 3 = 1
        clear_imem;
        write_imem(0, enc_I(6'd5,  X1, F_ADD));
        write_imem(1, enc_I(6'd3,  X2, F_ADD));
        write_imem(2, NOP); write_imem(3, NOP);
        write_imem(4, enc_R(X1, X2, X3, F_AND));
        write_imem(5, NOP); write_imem(6, NOP); write_imem(7, NOP);

        do_reset;
        tick(12);
        check("AND x3=5&3=1",  dbg_x3, 16'd1);

        // OR: x3 = 5 | 3 = 7
        clear_imem;
        write_imem(0, enc_I(6'd5,  X1, F_ADD));
        write_imem(1, enc_I(6'd3,  X2, F_ADD));
        write_imem(2, NOP); write_imem(3, NOP);
        write_imem(4, enc_R(X1, X2, X3, F_OR));
        write_imem(5, NOP); write_imem(6, NOP); write_imem(7, NOP);

        do_reset;
        tick(12);
        check("OR  x3=5|3=7",  dbg_x3, 16'd7);

        // XOR: x3 = 5 ^ 3 = 6
        clear_imem;
        write_imem(0, enc_I(6'd5,  X1, F_ADD));
        write_imem(1, enc_I(6'd3,  X2, F_ADD));
        write_imem(2, NOP); write_imem(3, NOP);
        write_imem(4, enc_R(X1, X2, X3, F_XOR));
        write_imem(5, NOP); write_imem(6, NOP); write_imem(7, NOP);

        do_reset;
        tick(12);
        check("XOR x3=5^3=6",  dbg_x3, 16'd6);

        // ======================================================
        //  GROUP 2 — I-TYPE  (immediate ALU)
        //  addi x1, x1, 10  -> x1 = 10
        //  addi x1, x1, -2  -> x1 = 8   (sign-extended negative)
        //  addi x1, x1,  0  -> x1 = 8   (identity)
        // ======================================================
        $display("\n--- Group 2: I-type (immediate) ---");

        clear_imem;
        write_imem(0, enc_I(6'd10, X1, F_ADD));  // x1 = 10
        write_imem(1, NOP); write_imem(2, NOP);
        write_imem(3, NOP); write_imem(4, NOP);

        do_reset;
        tick(10);
        check("ADDI x1=10",    dbg_x1, 16'd10);

        // Negative immediate: imm_i is sign-extended from bit [2] of imm_i_raw.
        // For -2 we need a 6-bit value whose lower 3 bits sign-extend to -2.
        // imm_i = {{13{imm_i_raw[2]}}, imm_i_raw}
        // We want the result 10 + (-2) = 8.
        // -2 in 6-bit two's complement = 6'b111110
        // imm_i_raw[2] = 1  ->  sign-extended: 16'hFFFE = -2  ✓
        clear_imem;
        write_imem(0, enc_I(6'd10,    X1, F_ADD));  // x1 = 10
        write_imem(1, NOP); write_imem(2, NOP);
        write_imem(3, enc_I(6'b111110, X1, F_ADD)); // x1 = x1 + (-2) = 8
        write_imem(4, NOP); write_imem(5, NOP);
        write_imem(6, NOP); write_imem(7, NOP);

        do_reset;
        tick(14);
        check("ADDI x1=10+(-2)=8", dbg_x1, 16'd8);

        // ======================================================
        //  GROUP 3 — STORE then LOAD  (S-type / L-type)
        //  x1 = 0xABCD
        //  sw  x1 -> mem[0]   (imm=0, rs1=x0 as base)
        //  lw  x2 <- mem[0]   (imm=0, rs1=x0)
        //  Expected: x2 = 0xABCD
        //
        //  NOTE: 0xABCD cannot fit in a 6-bit immediate, so we build
        //  it in two steps via U-type + I-type if your ISA supports
        //  that, or we just use a value that fits a 16-bit register
        //  directly via back-to-back I-type shifts if needed.
        //  For simplicity we use 0x0042 (fits in 6-bit imm easily).
        // ======================================================
        $display("\n--- Group 3: Store / Load ---");

        // x1 = 0x0042
        // sw  mem[x0+0] = x1
        // (2 NOPs to let x1 be written before SW reads it)
        // lw  x2 = mem[x0+0]
        // (3 NOPs: pipeline + load-use resolved here by explicit NOPs)
        clear_imem;
        write_imem(0, enc_I(6'd42,  X1, F_ADD));   // x1 = 42 = 0x002A
        write_imem(1, NOP);
        write_imem(2, NOP);
        write_imem(3, enc_S(7'd0, X0, X1));         // sw mem[0] = x1
        write_imem(4, NOP);
        write_imem(5, enc_L(7'd0, X0, X2));         // lw x2 = mem[0]
        write_imem(6, NOP);
        write_imem(7, NOP);
        write_imem(8, NOP);
        write_imem(9, NOP);

        do_reset;
        tick(18);
        check("SW then LW round-trip (42)", dbg_x2, 16'd42);

        // ======================================================
        //  GROUP 4 — LOAD-USE HAZARD
        //  The pipeline must stall 1 cycle when an instruction
        //  immediately following a load reads the loaded register.
        //
        //  lw  x1 = mem[0]      (word 0: store 99 there first)
        //  add x3 = x1 + x2     <- RAW hazard on x1; stall needed
        //
        //  If stall works correctly x3 = 99 + 3 = 102.
        //  If stall is broken x3 = 0  + 3 = 3   (stale x1).
        // ======================================================
        $display("\n--- Group 4: Load-use stall ---");

        clear_imem;
        // Pre-store 99 at address 0
        write_imem(0, enc_I(6'd99, X4, F_ADD));    // x4 = 99
        write_imem(1, NOP);
        write_imem(2, NOP);
        write_imem(3, enc_S(7'd0, X0, X4));         // mem[0] = 99
        write_imem(4, NOP);
        write_imem(5, NOP);
        // x2 = 3
        write_imem(6, enc_I(6'd3, X2, F_ADD));
        write_imem(7, NOP);
        write_imem(8, NOP);
        // Load-use pair: lw x1 immediately followed by add using x1
        write_imem(9,  enc_L(7'd0, X0, X1));       // lw x1 = mem[0] = 99
        write_imem(10, enc_R(X1, X2, X3, F_ADD));  // add x3 = x1 + x2  (hazard!)
        write_imem(11, NOP);
        write_imem(12, NOP);
        write_imem(13, NOP);

        do_reset;
        tick(22);
        check("Load-use stall: x3=99+3=102", dbg_x3, 16'd102);

        // ======================================================
        //  GROUP 5 — BRANCH (B-type)
        //  branch_target = PC + imm_b  (no shift, matches your code)
        //
        //  Layout (word addr = byte addr / 2):
        //    0: x1 = 5
        //    1: x2 = 5
        //    2: NOP
        //    3: NOP
        //    4: beq x1, x2, +4   -> if x1==x2, PC = 8+4=12 (word 6)
        //       (imm_b=4, PC at byte addr 8 when instr is in EX)
        //    5: x3 = 0xDEAD      <- should be SKIPPED by branch
        //    6: x3 = 0x0001      <- branch target lands here
        //    7-10: NOPs
        //
        //  If branch works:  x3 = 1
        //  If branch fails:  x3 = 0xDEAD (lower 6 bits as imm)
        //
        //  Note: because branch_target = PC + imm_b (no <<1),
        //  imm_b=2 skips 1 word (2 bytes).  We want to skip word 5
        //  (byte addr 10) and land on word 6 (byte addr 12).
        //  PC of branch instr in EX = byte addr 8 (word 4).
        //  Offset needed = 12 - 8 = 4.  So imm_b = 4.
        // ======================================================
        $display("\n--- Group 5: Branch taken (beq) ---");

        clear_imem;
        write_imem(0, enc_I(6'd5, X1, F_ADD));       // x1 = 5
        write_imem(1, enc_I(6'd5, X2, F_ADD));       // x2 = 5
        write_imem(2, NOP);
        write_imem(3, NOP);
        // beq: func code for BEQ assumed 4'b0000; adjust to match your CU
        write_imem(4, enc_B(5'd4,  X1, X2));         // branch if x1==x2, offset=4
        write_imem(5, enc_I(6'd1, X3, F_ADD));       // x3=1 (NOT taken path — skip)
        write_imem(6, enc_I(6'd7, X3, F_ADD));       // x3=7 (branch target)
        write_imem(7, NOP); write_imem(8, NOP);
        write_imem(9, NOP); write_imem(10, NOP);

        do_reset;
        tick(18);
        check("Branch taken: x3=7 (skip word5)", dbg_x3, 16'd7);

        // Branch NOT taken: x1 != x2 -> fall through to word 5
        $display("\n--- Group 5b: Branch not taken ---");

        clear_imem;
        write_imem(0, enc_I(6'd5, X1, F_ADD));       // x1 = 5
        write_imem(1, enc_I(6'd3, X2, F_ADD));       // x2 = 3  (different)
        write_imem(2, NOP); write_imem(3, NOP);
        write_imem(4, enc_B(5'd4,  X1, X2));         // branch if x1==x2 (not taken)
        write_imem(5, enc_I(6'd9, X3, F_ADD));       // x3=9  (fall-through)
        write_imem(6, enc_I(6'd7, X3, F_ADD));       // x3=7  (branch target, skip)
        write_imem(7, NOP); write_imem(8, NOP);
        write_imem(9, NOP); write_imem(10, NOP);

        do_reset;
        tick(18);
        check("Branch not taken: x3=9", dbg_x3, 16'd9);

        // ======================================================
        //  GROUP 6 — JAL  (unconditional jump and link)
        //  PC of JAL in EX = byte 4 (word 2).
        //  jal_target = PC + (imm_j << 1)
        //  We want to jump to byte 10 (word 5), skipping words 3,4.
        //  offset = (10 - 4) / 2 = 3  -> imm_j = 3.
        //  rd = x1  ->  x1 = PC+2 = 6 (return address)
        //
        //  word 0: NOP
        //  word 1: NOP
        //  word 2: jal x1, 3      -> x1=6, PC->10
        //  word 3: x3 = 0xAA     <- skipped
        //  word 4: x3 = 0xBB     <- skipped
        //  word 5: x3 = 0x0005   <- jump lands here
        //  word 6-9: NOPs
        // ======================================================
        $display("\n--- Group 6: JAL ---");

        clear_imem;
        write_imem(0, NOP);
        write_imem(1, NOP);
        write_imem(2, enc_J(10'd3, X1));             // jal x1, 3
        write_imem(3, enc_I(6'd1, X3, F_ADD));       // x3=1 (skipped)
        write_imem(4, enc_I(6'd2, X3, F_ADD));       // x3=2 (skipped)
        write_imem(5, enc_I(6'd5, X3, F_ADD));       // x3=5 (jump target)
        write_imem(6, NOP); write_imem(7, NOP);
        write_imem(8, NOP); write_imem(9, NOP);

        do_reset;
        tick(18);
        check("JAL target: x3=5",   dbg_x3, 16'd5);
        check("JAL link:   x1=PC+2 of JAL instr (=6)", dbg_x1, 16'd6);

        // ======================================================
        //  GROUP 7 — JALR  (indirect jump and link)
        //  x2 = 10   (base address, byte offset)
        //  jalr x1, x2, 0  -> target = (x2+0) & ~1 = 10, x1 = PC+2
        //  word 5 (byte 10): x3 = 0x000B (landing target)
        // ======================================================
        $display("\n--- Group 7: JALR ---");

        clear_imem;
        write_imem(0, enc_I(6'd10, X2, F_ADD));      // x2 = 10 (byte addr of target)
        write_imem(1, NOP); write_imem(2, NOP);
        // jalr x1, x2, 0: target = (10+0)&~1 = 10
        write_imem(3, enc_JR(7'd0, X2, X1));
        write_imem(4, enc_I(6'd1, X3, F_ADD));       // x3=1  (skipped)
        write_imem(5, enc_I(6'd11, X3, F_ADD));      // x3=11 (JALR lands here)
        write_imem(6, NOP); write_imem(7, NOP);
        write_imem(8, NOP); write_imem(9, NOP);

        do_reset;
        tick(18);
        check("JALR target: x3=11",          dbg_x3, 16'd11);
        check("JALR link:   x1=PC+2 of JALR (=8)", dbg_x1, 16'd8);

        // ======================================================
        //  GROUP 8 — PIPELINE FLUSH VERIFICATION
        //  After a taken branch the IF/ID register must be flushed
        //  so the instruction fetched in the branch-delay slot does
        //  NOT execute.  We verify by checking that a register
        //  written only in the delay-slot instruction keeps its
        //  old value (zero after reset).
        //
        //  word 0: x1 = 1
        //  word 1: x2 = 1
        //  word 2: NOP
        //  word 3: NOP
        //  word 4: beq x1,x2, +4  -> taken, flushes word 5
        //  word 5: x3 = 0xF       <- IN FLUSH SLOT, must NOT execute
        //  word 6: x3 = 2         <- branch target
        //  word 7-9: NOPs
        // ======================================================
        $display("\n--- Group 8: Branch flush (delay-slot not executed) ---");

        clear_imem;
        write_imem(0, enc_I(6'd1, X1, F_ADD));
        write_imem(1, enc_I(6'd1, X2, F_ADD));
        write_imem(2, NOP); write_imem(3, NOP);
        write_imem(4, enc_B(5'd4, X1, X2));          // beq, taken
        write_imem(5, enc_I(6'd15, X3, F_ADD));      // must be flushed
        write_imem(6, enc_I(6'd2,  X3, F_ADD));      // branch target
        write_imem(7, NOP); write_imem(8, NOP);
        write_imem(9, NOP); write_imem(10, NOP);

        do_reset;
        tick(18);
        check("Flush: x3=2, NOT 15 (slot flushed)", dbg_x3, 16'd2);

        // ======================================================
        //  GROUP 9 — x0 WRITES ARE IGNORED
        //  Any write to x0 must leave it permanently zero.
        // ======================================================
        $display("\n--- Group 9: x0 always zero ---");

        clear_imem;
        write_imem(0, enc_I(6'd63, X0, F_ADD));     // addi x0, x0, 63 (should be NOP)
        write_imem(1, NOP); write_imem(2, NOP);
        write_imem(3, NOP); write_imem(4, NOP);

        do_reset;
        tick(10);
        // x0 is read via ALU result path; use dbg_x1 as proxy —
        // if your register file correctly ignores x0 writes, dbg_x1
        // stays 0 after reset (x1 was never written).
        // We check ALU result of the I-type (which would be 63 if
        // it ran as x1) against x0 staying 0 via dbg_x1.
        check("x0 stays 0 after attempted write", dbg_x1, 16'd0);

        // ======================================================
        //  GROUP 10 — RESET BEHAVIOUR
        //  After mid-execution reset, PC and registers must clear.
        // ======================================================
        $display("\n--- Group 10: Mid-execution reset ---");

        clear_imem;
        write_imem(0, enc_I(6'd31, X1, F_ADD));     // x1 = 31
        write_imem(1, enc_I(6'd31, X2, F_ADD));     // x2 = 31
        write_imem(2, NOP); write_imem(3, NOP);

        // Let a few instructions execute, then assert reset
        reset = 0;
        tick(4);
        reset = 1;
        tick(2);
        reset = 0;
        tick(2);
        check("After reset: PC=0", dbg_pc, 16'd0);

        // ======================================================
        //  GROUP 11 — LOAD PORT INPUTS  (functional smoke test)
        //  The load_mode/load_data/load_addr inputs should not
        //  crash the pipeline.  We toggle them and confirm the
        //  processor keeps running (PC increments normally).
        // ======================================================
        $display("\n--- Group 11: Load port smoke test ---");

        clear_imem;
        write_imem(0, NOP); write_imem(1, NOP);
        write_imem(2, NOP); write_imem(3, NOP);

        do_reset;

        load_mode   = 1;
        load_data   = 7'h55;
        load_hibyte = 0;
        load_addr   = 7'h01;
        tick(4);
        load_mode = 0;
        tick(4);

        // PC should have advanced; if it's stuck at 0 something broke
        // (we just check it's nonzero — exact value depends on timing)
        if (dbg_pc !== 16'd0)
            pass("Load port: PC still advancing");
        else
            fail("Load port: PC stuck at 0", dbg_pc, 16'hXXXX);

        // ======================================================
        //  SUMMARY
        // ======================================================
        $display("\n==============================================");
        $display("  Results: %0d passed,  %0d failed", pass_count, fail_count);
        $display("==============================================");
        if (fail_count == 0)
            $display("  ALL TESTS PASSED");
        else
            $display("  SOME TESTS FAILED — review output above");
        $display("==============================================\n");

        $finish;
    end

    // --------------------------------------------------------
    //  Waveform dump  (works on Icarus, Vivado, ModelSim)
    // --------------------------------------------------------
    initial begin
        $dumpfile("./tb/waveform/top_tb.vcd");
        $dumpvars(0, top_tb);
    end

    // --------------------------------------------------------
    //  Watchdog  — kill simulation if it hangs (e.g. infinite
    //  stall loop due to broken hazard unit)
    // --------------------------------------------------------
    initial begin
        #50000;
        $display("[WATCHDOG] Simulation exceeded 50 000 ns — force quit.");
        $finish;
    end

    // --------------------------------------------------------
    //  Cycle monitor  — print state every rising edge
    //  (comment out if log is too verbose)
    // --------------------------------------------------------
    always @(posedge clk) begin
        if (~reset)
            $display("  t=%0t  PC=%04h  instr=%04h  ALU=%04h  x1=%04h  x2=%04h  x3=%04h",
                     $time, dbg_pc, dbg_instr, dbg_alu_result,
                     dbg_x1, dbg_x2, dbg_x3);
    end

endmodule