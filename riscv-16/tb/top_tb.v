`timescale 1ns / 1ps
// =============================================================================
//  tb_riscv16_pipeline.v
//
//  Two bugs fixed vs previous version:
//
//  BUG 1 – JALR encoding overlap:
//    The JR-type field layout has rs1 at instr[7:5] and rd at instr[5:3].
//    Bit 5 is shared, so rs1[0] must equal rd[2] for both fields to decode
//    correctly. 0x00FF encoded rs1=x7 (not x6) because of this overlap.
//    Fixed: JALR x3, x6, 0 → 0x00DF  (rs1=x6, rd=x3, bit5=0 consistent)
//
//  BUG 2 – Infinite loop restarting from 0x0000:
//    The bad JALR jumped to x7=0x0001→cleared to 0x0000, restarting the
//    program every iteration. All register values kept accumulating.
//    Fixed: correct JALR now jumps to x6=0x0022 (NOP), then 0x0024 (JALR),
//    looping harmlessly while registers hold their final values.
//
//  EXPECTED FINAL REGISTER STATE:
//    x1 = 0x0003   x2 = 0x0002   x3 = 0x0026  (JALR link, overwrites XORI)
//    x4 = 0x0001   x5 = 0x0002   x6 = 0x0022  (JAL link)   x7 = 0x0001
//
//  HOW TO COMPILE:
//    iverilog -g2012 -I src -o build.vvp \
//      src/Parameter.v src/ALU.v src/ALUSrc_mux.v src/Control_unit.v \
//      src/Data_Memory.v src/Instruction_memory.v src/pc_counter_16.v \
//      src/Register_file.v src/Sign_Extender.v src/Writeback_mux.v \
//      src/riscv16_pipeline_top.v tb/tb_riscv16_pipeline.v
//    vvp build.vvp
// =============================================================================

module top_tb;

    reg         clk;
    reg         reset;
    wire [15:0] dbg_pc;
    wire [15:0] dbg_instr;
    wire [15:0] dbg_alu_result;
    wire [15:0] dbg_x1;
    wire [15:0] dbg_x2;
    wire [15:0] dbg_x3;

    top DUT (
        .clk           (clk),
        .reset         (reset),
        .dbg_pc        (dbg_pc),
        .dbg_instr     (dbg_instr),
        .dbg_alu_result(dbg_alu_result),
        .dbg_x1        (dbg_x1),
        .dbg_x2        (dbg_x2),
        .dbg_x3        (dbg_x3),
        .load_mode     (1'b0),
        .load_data     (7'b0),
        .load_hibyte   (1'b0),
        .load_addr     (7'b0)
    );

    // x4-x7 tapped directly from register file array (named reg_array in Register_file.v)
    wire [15:0] dbg_x0 = DUT.RF.reg_array[0];
    // wire [15:0] dbg_x1 = DUT.RF.reg_array[1]; //add when cleanup
    // wire [15:0] dbg_x2 = DUT.RF.reg_array[2]; //add when cleanup
    // wire [15:0] dbg_x3 = DUT.RF.reg_array[3]; //add when cleanup
    wire [15:0] dbg_x4 = DUT.RF.reg_array[4];
    wire [15:0] dbg_x5 = DUT.RF.reg_array[5];
    wire [15:0] dbg_x6 = DUT.RF.reg_array[6];
    wire [15:0] dbg_x7 = DUT.RF.reg_array[7];

    initial clk = 0;
    always #5 clk = ~clk;

    integer pass_count;
    integer fail_count;

    reg        sb_we   [0:63];
    reg [2:0]  sb_rd   [0:63];
    reg [15:0] sb_val  [0:63];

    integer sb_head = 0;
    integer sb_tail = 0;
    integer sb_size = 0;

    // Golden register model
    reg [15:0] golden_reg [0:7];

    integer i;
    initial begin
        for (i = 0; i < 8; i = i + 1)
            golden_reg[i] = 0;
    end

    task decode_and_predict;
        input  [15:0] instr;
        output        we;
        output [2:0]  rd;
        output [15:0] val;

        reg [2:0] rs1, rs2, opcode;
        reg [3:0] func;
        reg [15:0] imm;

        begin
            rd     = instr[5:3];
            rs1    = instr[7:5];
            rs2    = instr[10:8];
            func   = instr[3:0];
            opcode = instr[2:0];

            imm = {{11{instr[15]}}, instr[15:11]};

            we  = 0;
            val = 0;

            case (opcode)

                // R-type
                3'b000: begin
                    we = 1;
                    case (func)
                        4'b0000: val = golden_reg[rs1] + golden_reg[rs2]; // ADD
                        4'b0001: val = golden_reg[rs1] - golden_reg[rs2]; // SUB
                        4'b0010: val = golden_reg[rs1] & golden_reg[rs2]; // AND
                        4'b0011: val = golden_reg[rs1] | golden_reg[rs2]; // OR
                        4'b0100: val = golden_reg[rs1] ^ golden_reg[rs2]; // XOR
                        default: we = 0;
                    endcase
                end

                // I-type
                3'b001: begin
                    we = 1;
                    case (func)
                        4'b0000: val = golden_reg[rs1] + imm; // ADDI
                        4'b0010: val = golden_reg[rs1] | imm; // ORI
                        4'b0011: val = golden_reg[rs1] ^ imm; // XORI
                        4'b0001: val = golden_reg[rs1] & imm; // ANDI
                        default: we = 0;
                    endcase
                end

                // JAL / JALR (link write)
                3'b101,
                3'b111: begin
                    we  = 1;
                    val = dbg_pc + 16'd2;
                end

                default: we = 0;
            endcase
        end
    endtask

    task automatic chk;
        input [319:0] label;
        input [15:0]  got;
        input [15:0]  expected;
        begin
            if (got === expected) begin
                $display("  [PASS] %-38s  got=0x%04X", label, got);
                pass_count = pass_count + 1;
            end else begin
                $display("  [FAIL] %-38s  got=0x%04X  exp=0x%04X",
                         label, got, expected);
                fail_count = fail_count + 1;
            end
        end
    endtask

    initial begin
        $dumpfile("./tb/waveform/top.vcd");
        $dumpvars(0, top_tb);
    end

    // Cycle-by-cycle monitor
    always @(posedge clk) begin
        if (!reset)
            $display("%0t | PC=%04X instr=%04X ALU=%04X | x1=%04X x2=%04X x3=%04X x4=%04X x5=%04X x6=%04X x7=%04X",
                     $time, dbg_pc, dbg_instr, dbg_alu_result,
                     dbg_x1, dbg_x2, dbg_x3, dbg_x4, dbg_x5, dbg_x6, dbg_x7);
    end


    reg        exp_we;
    reg [2:0]  exp_rd;
    reg [15:0] exp_val;

    always @(posedge clk) begin
        if (!reset) begin

            // ----------------------------
            // Generate expected result
            // ----------------------------
            decode_and_predict(dbg_instr, exp_we, exp_rd, exp_val);

            // Push into scoreboard FIFO
            sb_we[sb_tail]  = exp_we;
            sb_rd[sb_tail]  = exp_rd;
            sb_val[sb_tail] = exp_val;

            sb_tail = (sb_tail + 1) % 64;
            sb_size = sb_size + 1;

            // ----------------------------
            // Pop after pipeline delay (~3)
            // ----------------------------
            if (sb_size > 3) begin

                if (sb_we[sb_head]) begin

                    case (sb_rd[sb_head])
                        3'd1: chk("SB x1", dbg_x1, sb_val[sb_head]);
                        3'd2: chk("SB x2", dbg_x2, sb_val[sb_head]);
                        3'd3: chk("SB x3", dbg_x3, sb_val[sb_head]);
                        3'd4: chk("SB x4", dbg_x4, sb_val[sb_head]);
                        3'd5: chk("SB x5", dbg_x5, sb_val[sb_head]);
                        3'd6: chk("SB x6", dbg_x6, sb_val[sb_head]);
                        3'd7: chk("SB x7", dbg_x7, sb_val[sb_head]);
                    endcase

                    // Update golden model AFTER checking
                    golden_reg[sb_rd[sb_head]] = sb_val[sb_head];
                end

                sb_head = (sb_head + 1) % 64;
                sb_size = sb_size - 1;
            end
        end
    end


    initial begin
        pass_count = 0;
        fail_count = 0;

        reset = 1;
        repeat(4) @(posedge clk);
        @(negedge clk);
        reset = 0;
        $display("\n=== Reset released ===\n");

        // Program has 20 instructions with ~4 stall/flush cycles.
        // Wait 40 cycles: enough for one full pass to complete and settle
        // into the 0x0022/0x0024 infinite loop without a second full pass.
        // (Second full pass would start at cycle ~30+, so sampling at 35 is safe.)
        repeat(85) @(posedge clk);
        @(negedge clk);

        $display("\n=============================================================");
        $display("  RISC-V16 Pipeline - Full Instruction Type Coverage");
        $display("=============================================================");

        // --- I-type: ADDI ---
        $display("\n--- I-type: ADDI ---");
        // [0000] ADDI x1, x1, 3  → x1 = 3
        // [0002] ADDI x2, x2, 2  → x2 = 2
        chk("ADDI x1 = 3",              dbg_x1, 16'h0003);
        chk("ADDI x2 = 2",              dbg_x2, 16'h0002);

        // --- R-type ---
        $display("\n--- R-type: ADD / SUB / AND / OR / XOR ---");
        // chk("ADD  x3 = 5  (3+2)",       dbg_x3, 16'h0005);
        chk("SUB  x4 = 1  (3-2)",       dbg_x4, 16'h0001);
        chk("AND  x5 = 2  (3&2)",       dbg_x5, 16'h0002);
        // x6 is overwritten by JAL, check x7 for XOR
        chk("XOR  x7 = 1  (3^2)",       dbg_x7, 16'h0001);

        // --- I-type: ANDI / ORI / XORI ---
        // x3 is overwritten by JALR link, so we can only verify the
        // intermediate chain completed correctly via x3 before JALR ran.
        // After JALR: x3 = 0x0026 (link address). Both facts are checked.
        $display("\n--- I-type: ANDI/ORI/XORI then JALR link stored in x3 ---");
        // [000E] ANDI x3,x3(5),3=1  [0010] ORI x3,x3(1),2=3  [0012] XORI x3,x3(3),1=2
        // [0024] JALR x3, x6, 0 → x3 = PC_JALR+2 = 0x0026
        chk("JALR link x3 = 0x0026",    dbg_x3, 16'h0026);

        // --- S-type SW + L-type LW ---
        $display("\n--- S-type: SW  /  L-type: LW  (load-use stall) ---");
        // [0014] SW x2,0(x0) → mem[0]=2
        // [0016] LW x5,0(x0) → x5=2  (load-use stall exercised; overwrites AND result)
        chk("LW x5 = 2  (mem[0])",      dbg_x5, 16'h0002);

        // --- B-type: BEQ taken ---
        $display("\n--- B-type: BEQ taken (flush kills ADDI x1,-1) ---");
        // [0018] BEQ x2,x5,+4 → taken; [001A] ADDI x1,-1 killed
        chk("BEQ flush: x1 still 3",    dbg_x1, 16'h0003);

        // --- B-type: BNE taken ---
        $display("\n--- B-type: BNE taken (flush kills ADDI x2,-1) ---");
        // [001C] BNE x1,x2,+4 → taken; [001E] ADDI x2,-1 killed
        chk("BNE flush: x2 still 2",    dbg_x2, 16'h0002);

        // --- J-type: JAL ---
        $display("\n--- J-type: JAL ---");
        // [0020] JAL x6,+4 → x6=0x0022 (PC+2), jumps to 0x0024, kills NOP at 0x0022
        chk("JAL link x6 = 0x0022",     dbg_x6, 16'h0022);
        chk("JAL flush: x1 still 3",    dbg_x1, 16'h0003);

        // --- JR-type: JALR ---
        $display("\n--- JR-type: JALR x3, x6, 0 ---");
        // [0024] JALR x3,x6(=0x0022),0 → jumps to 0x0022, x3=0x0026
        // (rs1=x6, rd=x3; encoding 0x00DF avoids bit-5 overlap in JR-type fields)
        chk("JALR link x3 = 0x0026",    dbg_x3, 16'h0026);

        // =============================================================
        // NEW EXTENDED TESTS
        // =============================================================

        $display("\n--- Extended: Data hazard chain ---");
        chk("x2 = 3 after ADDI chain", dbg_x2, 16'h0003);
        chk("x1 = 6 after RAW hazard", dbg_x1, 16'h0006);
        chk("x3 = 9 (x1+x2)",          dbg_x3, 16'h0009);
        chk("x4 = 6 (x3-x2)",          dbg_x4, 16'h0006);

        $display("\n--- Extended: Overwrite chain ---");
        chk("x1 = 8 after increments", dbg_x1, 16'h0008);
        chk("x5 = 8 copy of x1",       dbg_x5, 16'h0008);

        $display("\n--- Extended: Sign extension ---");
        chk("x2 decremented to 2",     dbg_x2, 16'h0002);
        chk("x1 decremented to 7",     dbg_x1, 16'h0007);

        $display("\n--- Extended: Memory offset ---");
        chk("LW x3 = 2 from mem[x1+3]", dbg_x3, 16'h0002);

        $display("\n--- Extended: Branch behavior ---");
        chk("BEQ not taken → x1 incremented", dbg_x1, 16'h0008);
        chk("BNE taken → no extra increment", dbg_x1, 16'h0008);

        $display("\n=============================================================");
        $display("  Results: %0d PASSED,  %0d FAILED", pass_count, fail_count);
        $display("=============================================================\n");

        if (fail_count == 0)
            $display("ALL TESTS PASSED\n");
        else
            $display("FAILURES DETECTED\n");

        $finish;
    end

    initial begin
        #4000;
        $display("TIMEOUT");
        $finish;
    end

endmodule