`timescale 1ns / 1ps
// =============================================================================
//  riscv16_pipeline_top.v  –  3-Stage Pipelined RISC-V16 CPU
// =============================================================================

module top (
    input  wire       clk,
    input  wire       reset,
    output wire [15:0] dbg_pc,
    output wire [15:0] dbg_instr,
    output wire [15:0] dbg_alu_result,
    output wire [15:0] dbg_x1,
    output wire [15:0] dbg_x2,
    output wire [15:0] dbg_x3,
    input  wire [7:0]  load_ui,
    input  wire [7:0]  load_uio,
    output wire        load_ack
);

    localparam OPC_R  = 3'b000;
    localparam OPC_I  = 3'b001;
    localparam OPC_L  = 3'b010;
    localparam OPC_S  = 3'b011;
    localparam OPC_B  = 3'b100;
    localparam OPC_J  = 3'b101;
    localparam OPC_U  = 3'b110;
    localparam OPC_JR = 3'b111;

    // =========================================================================
    //  IF STAGE
    // =========================================================================
    reg  [15:0] IF_PC;
    wire [15:0] IF_PC_plus2 = IF_PC + 16'd2;
    wire [15:0] IF_instr;

    Instruction_memory #(
        .IMEM_WORDS(256)
    ) IMEM (
        .clk          (clk),
        .pc           (IF_PC),
        .instruction  (IF_instr),
        .load_mode    (load_ui[7]),   // extract mode from bit 7
        .load_transfer(load_ui[6]),   // extract transfer ID from bit 6
        .load_ui      (load_ui[5:0]), // data is bits 5:0
        .load_uio     (load_uio),
        .load_ack     (load_ack)
    );

    // =========================================================================
    //  IF/EX Pipeline Register
    // =========================================================================
    reg [15:0] IFEX_pc;
    reg [15:0] IFEX_pc_plus2;
    reg [15:0] IFEX_instr;

    // =========================================================================
    //  EX STAGE
    // =========================================================================
    wire [2:0] EX_opcode = IFEX_instr[2:0];
    wire [3:0] EX_func   = IFEX_instr[6:3];

    wire [2:0] EX_rs1_r = IFEX_instr[15:13];
    wire [2:0] EX_rs2_r = IFEX_instr[12:10];
    wire [2:0] EX_rd_r  = IFEX_instr[9:7];
    wire [2:0] EX_rs1_i = IFEX_instr[9:7];
    wire [2:0] EX_rd_i  = IFEX_instr[9:7];
    wire [2:0] EX_rs1_s = IFEX_instr[8:6];
    wire [2:0] EX_rs2_s = IFEX_instr[5:3];
    wire [2:0] EX_rs1_l = IFEX_instr[8:6];
    wire [2:0] EX_rd_l  = IFEX_instr[5:3];
    wire [2:0] EX_rs1_b = IFEX_instr[10:8];
    wire [2:0] EX_rs2_b = IFEX_instr[7:5];
    wire [2:0] EX_rd_u  = IFEX_instr[5:3];
    wire [2:0] EX_rd_j  = IFEX_instr[5:3];
    wire [2:0] EX_rs1_jr = IFEX_instr[7:5];
    wire [2:0] EX_rd_jr  = IFEX_instr[5:3];

    wire [2:0] EX_rs1 =
        (EX_opcode == OPC_R)  ? EX_rs1_r  :
        (EX_opcode == OPC_I)  ? EX_rs1_i  :
        (EX_opcode == OPC_S)  ? EX_rs1_s  :
        (EX_opcode == OPC_B)  ? EX_rs1_b  :
        (EX_opcode == OPC_L)  ? EX_rs1_l  :
        (EX_opcode == OPC_JR) ? EX_rs1_jr :
        3'b000;

    wire [2:0] EX_rs2 =
        (EX_opcode == OPC_R) ? EX_rs2_r :
        (EX_opcode == OPC_S) ? EX_rs2_s :
        (EX_opcode == OPC_B) ? EX_rs2_b :
        3'b000;

    wire [2:0] EX_rd =
        (EX_opcode == OPC_R)  ? EX_rd_r  :
        (EX_opcode == OPC_I)  ? EX_rd_i  :
        (EX_opcode == OPC_U)  ? EX_rd_u  :
        (EX_opcode == OPC_J)  ? EX_rd_j  :
        (EX_opcode == OPC_L)  ? EX_rd_l  :
        (EX_opcode == OPC_JR) ? EX_rd_jr :
        3'b000;

    wire [15:0] EX_imm_ext;
    Sign_Extender SE (
        .instr  (IFEX_instr),
        .ImmSrc (EX_ImmSrc),
        .ImmExt (EX_imm_ext)
    );

    wire        EX_PCSrc;
    wire [1:0]  EX_ResultSrc;
    wire        EX_MemWrite;
    wire        EX_MemRead;
    wire        EX_ALUSrc;
    wire        EX_RegWrite;
    wire [2:0]  EX_ImmSrc;
    wire [3:0]  EX_ALUControl;
    wire        EX_zero;
    wire        EX_negative;

    Control_unit CU (
        .opcode    (EX_opcode),
        .func      (EX_func),
        .zero      (EX_zero),
        .negative  (EX_negative),
        .PCSrc     (EX_PCSrc),
        .ResultSrc (EX_ResultSrc),
        .MemWrite  (EX_MemWrite),
        .MemRead   (EX_MemRead),
        .ALUControl(EX_ALUControl),
        .ALUSrc    (EX_ALUSrc),
        .ImmSrc    (EX_ImmSrc),
        .RegWrite  (EX_RegWrite)
    );

    wire        WB_RegWrite;
    wire [2:0]  WB_rd;
    wire [15:0] WB_WD3;

    wire [15:0] EX_RD1_raw, EX_RD2_raw;
    wire [15:0] rf_dbg_x1, rf_dbg_x2, rf_dbg_x3;

    Register_file RF (
        .clk     (clk),
        .reset   (reset),
        .RegWrite(WB_RegWrite),
        .A3      (WB_rd),
        .WD3     (WB_WD3),
        .A1      (EX_rs1),
        .RD1     (EX_RD1_raw),
        .A2      (EX_rs2),
        .RD2     (EX_RD2_raw),
        .dbg_x1  (rf_dbg_x1),
        .dbg_x2  (rf_dbg_x2),
        .dbg_x3  (rf_dbg_x3)
    );

    // =========================================================================
    //  Hazard Detection & Forwarding
    // =========================================================================
    reg        MEWB_RegWrite;
    reg [2:0]  MEWB_rd;
    reg [15:0] MEWB_WD3;
    reg        MEWB_MemRead;

    reg        EXME_RegWrite;
    reg [2:0]  EXME_rd;
    reg [15:0] EXME_ALUResult;
    reg        EXME_MemRead;

    wire fwd_a_exme = EXME_RegWrite && (EXME_rd != 3'b000) && (EXME_rd == EX_rs1);
    wire fwd_a_mewb = MEWB_RegWrite && (MEWB_rd != 3'b000) && (MEWB_rd == EX_rs1) && !fwd_a_exme;
    wire fwd_b_exme = EXME_RegWrite && (EXME_rd != 3'b000) && (EXME_rd == EX_rs2);
    wire fwd_b_mewb = MEWB_RegWrite && (MEWB_rd != 3'b000) && (MEWB_rd == EX_rs2) && !fwd_b_exme;

    wire [15:0] EX_RD1 = fwd_a_exme ? EXME_ALUResult :
                         fwd_a_mewb ? MEWB_WD3       : EX_RD1_raw;

    wire [15:0] EX_RD2 = fwd_b_exme ? EXME_ALUResult :
                         fwd_b_mewb ? MEWB_WD3       : EX_RD2_raw;

    wire load_use_stall = EXME_MemRead &&
                          (EXME_rd != 3'b000) &&
                          ((EXME_rd == EX_rs1) || (EXME_rd == EX_rs2));

    // ctrl_taken: used only to flush IF/EX (kill wrongly-fetched instruction)
    wire ctrl_taken = EX_PCSrc || (EX_opcode == OPC_J) || (EX_opcode == OPC_JR);

    wire pc_stall   = load_use_stall;
    wire ifex_stall = load_use_stall;
    // NOTE: ex_flush now only fires on load_use_stall, NOT ctrl_taken.
    // ctrl_taken flushes the IF/EX register below, but must NOT flush the
    // EX/ME register — that would erase the JAL/JALR/branch write-back.
    wire ex_flush   = load_use_stall;

    // =========================================================================
    //  PC Next
    // =========================================================================
    wire [15:0] EX_branch_target = IFEX_pc + EX_imm_ext;
    wire [15:0] EX_jal_target    = IFEX_pc + (EX_imm_ext << 1);
    wire [15:0] EX_jalr_sum      = EX_RD1 + EX_imm_ext;
    wire [15:0] EX_jalr_target   = {EX_jalr_sum[15:1], 1'b0};

    wire [15:0] PC_next =
        (EX_opcode == OPC_JR) ? EX_jalr_target  :
        (EX_opcode == OPC_J)  ? EX_jal_target   :
        EX_PCSrc              ? EX_branch_target :
        IF_PC_plus2;

    // =========================================================================
    //  ALU
    // =========================================================================
    wire [15:0] EX_ALU_B;
    ALUSrc_mux RD2_MUX (
        .RD2   (EX_RD2),
        .ImmExt(EX_imm_ext),
        .ALUSrc(EX_ALUSrc),
        .SrcB  (EX_ALU_B)
    );

    wire [15:0] EX_ALUResult;
    ALU ALU_CORE (
        .SrcA       (EX_RD1),
        .SrcB       (EX_ALU_B),
        .ALU_control(EX_ALUControl),
        .ALU_result (EX_ALUResult),
        .zero       (EX_zero),
        .negative   (EX_negative)
    );

    // =========================================================================
    //  EX → MEM/WB Pipeline Register (EXME)
    //  IMPORTANT: only bubble on load_use_stall. ctrl_taken (branch/jump) must
    //  NOT bubble here — the jump instruction's own RegWrite/ResultSrc must
    //  propagate so its link register write-back completes correctly.
    // =========================================================================
    reg [15:0] EXME_RD2;
    reg [1:0]  EXME_ResultSrc;
    reg        EXME_MemWrite;
    reg [15:0] EXME_pc_plus2;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            EXME_RegWrite  <= 1'b0;
            EXME_MemWrite  <= 1'b0;
            EXME_MemRead   <= 1'b0;
            EXME_ResultSrc <= 2'b00;
            EXME_rd        <= 3'b000;
            EXME_ALUResult <= 16'h0000;
            EXME_RD2       <= 16'h0000;
            EXME_pc_plus2  <= 16'h0000;
        end else if (ex_flush) begin
            // Load-use stall: insert bubble
            EXME_RegWrite  <= 1'b0;
            EXME_MemWrite  <= 1'b0;
            EXME_MemRead   <= 1'b0;
            EXME_ResultSrc <= 2'b00;
            EXME_rd        <= 3'b000;
            EXME_ALUResult <= 16'h0000;
            EXME_RD2       <= 16'h0000;
            EXME_pc_plus2  <= 16'h0000;
        end else begin
            // Normal latch — JAL/JALR/branch results flow through here
            EXME_RegWrite  <= EX_RegWrite;
            EXME_MemWrite  <= EX_MemWrite;
            EXME_MemRead   <= EX_MemRead;
            EXME_ResultSrc <= EX_ResultSrc;
            EXME_rd        <= EX_rd;
            EXME_ALUResult <= EX_ALUResult;
            EXME_RD2       <= EX_RD2;
            EXME_pc_plus2  <= IFEX_pc_plus2;
        end
    end

    // =========================================================================
    //  MEM/WB STAGE
    // =========================================================================
    wire [15:0] MEM_ReadData;
    Data_Memory DMEM (
        .clk            (clk),
        .mem_access_addr(EXME_ALUResult),
        .mem_write_data (EXME_RD2),
        .mem_write_en   (EXME_MemWrite),
        .mem_read       (EXME_MemRead),
        .mem_read_data  (MEM_ReadData)
    );

    wire [15:0] MEM_WB_result;
    Writeback_mux WB_MUX (
        .ALUResult(EXME_ALUResult),
        .MemData  (MEM_ReadData),
        .PcPlus2  (EXME_pc_plus2),
        .MemtoReg (EXME_ResultSrc),
        .WD3      (MEM_WB_result)
    );

    // =========================================================================
    //  MEM/WB Pipeline Register (MEWB)
    // =========================================================================
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            MEWB_RegWrite <= 1'b0;
            MEWB_rd       <= 3'b000;
            MEWB_WD3      <= 16'h0000;
            MEWB_MemRead  <= 1'b0;
        end else begin
            MEWB_RegWrite <= EXME_RegWrite;
            MEWB_rd       <= EXME_rd;
            MEWB_WD3      <= MEM_WB_result;
            MEWB_MemRead  <= EXME_MemRead;
        end
    end

    assign WB_RegWrite = MEWB_RegWrite;
    assign WB_rd       = MEWB_rd;
    assign WB_WD3      = MEWB_WD3;

    // =========================================================================
    //  IF/EX Register + PC Update
    //  ctrl_taken flushes IFEX only (kills the wrongly-fetched instruction).
    // =========================================================================
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            IF_PC        <= 16'h0000;
            IFEX_pc      <= 16'h0000;
            IFEX_pc_plus2<= 16'h0002;
            IFEX_instr   <= 16'h0000;
        end else begin
            if (!pc_stall)
                IF_PC <= PC_next;

            if (ctrl_taken) begin
                // Flush: kill the instruction that was fetched after the jump/branch
                IFEX_instr    <= 16'h0000;
                IFEX_pc       <= 16'h0000;
                IFEX_pc_plus2 <= 16'h0000;
            end else if (!ifex_stall) begin
                IFEX_instr    <= IF_instr;
                IFEX_pc       <= IF_PC;
                IFEX_pc_plus2 <= IF_PC_plus2;
            end
            // else: hold on load-use stall
        end
    end

    // =========================================================================
    //  Debug outputs
    // =========================================================================
    assign dbg_pc         = IFEX_pc;
    assign dbg_instr      = IFEX_instr;
    assign dbg_alu_result = EX_ALUResult;
    assign dbg_x1         = rf_dbg_x1;
    assign dbg_x2         = rf_dbg_x2;
    assign dbg_x3         = rf_dbg_x3;

endmodule