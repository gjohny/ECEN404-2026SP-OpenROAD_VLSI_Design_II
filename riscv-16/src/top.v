`timescale 1ns / 1ps

module top (
    input  wire        clk,
    input  wire        reset,

    // Debug outputs
    output wire [15:0] dbg_pc,
    output wire [15:0] dbg_instr,
    output wire [15:0] dbg_alu_result,
    output wire [15:0] dbg_x1,
    output wire [15:0] dbg_x2,
    output wire [15:0] dbg_x3,

    // Load ports
    input  wire        load_mode,
    input  wire [6:0]  load_data,
    input  wire        load_hibyte,
    input  wire [6:0]  load_addr,
    output wire        load_ack
);

// ============================================================
//  OPCODE PARAMETERS
// ============================================================
localparam OPC_R  = 3'b000;
localparam OPC_I  = 3'b001;
localparam OPC_L  = 3'b010;
localparam OPC_S  = 3'b011;
localparam OPC_B  = 3'b100;
localparam OPC_U  = 3'b110;
localparam OPC_J  = 3'b101;
localparam OPC_JR = 3'b111;

// ============================================================
//  IF STAGE  —  Instruction Fetch
// ============================================================

wire [15:0] PC;
wire [15:0] PC_plus2_if = PC + 16'd2;
wire [15:0] instruction_if;

// Branch/jump resolution signals driven from EX stage
wire        PCSrc_ex;
wire        jal_taken_ex;
wire        jalr_taken_ex;
wire [15:0] branch_target_ex;
wire [15:0] jal_target_ex;
wire [15:0] jalr_target_ex;

// Hazard / flush
wire        stall;
wire        flush_ifid = PCSrc_ex | jal_taken_ex | jalr_taken_ex;

wire [15:0] PC_next =
    jalr_taken_ex  ? jalr_target_ex   :
    jal_taken_ex   ? jal_target_ex    :
    PCSrc_ex       ? branch_target_ex :
    PC_plus2_if;

pc_counter_16 PC_REG (
    .clk    (clk),
    .reset  (reset),
    .pc_en  (~stall),
    .pc_next(PC_next),
    .pc     (PC)
);

Instruction_memory #(
    .IMEM_WORDS(256),
    .MEMFILE("src/program16.mem")
) IMEM (
    .clk        (clk),
    .pc         (PC),
    .instruction(instruction_if)
);

// ============================================================
//  IF/ID PIPELINE REGISTER
// ============================================================
// Holds: PC, PC+2, raw instruction.
// flush_ifid  → inject NOP (kills wrongly-fetched instruction).
// stall       → freeze (hold current value, do NOT advance).

reg [15:0] IFID_PC;
reg [15:0] IFID_PC_plus2;
reg [15:0] IFID_instr;

always @(posedge clk or posedge reset) begin
    if (reset || flush_ifid) begin
        IFID_PC       <= 16'h0000;
        IFID_PC_plus2 <= 16'h0000;
        IFID_instr    <= 16'h0000;  // NOP
    end else if (~stall) begin
        IFID_PC       <= PC;
        IFID_PC_plus2 <= PC_plus2_if;
        IFID_instr    <= instruction_if;
    end
    // stall=1, no flush: registers hold implicitly
end

// ============================================================
//  ID STAGE  —  Instruction Decode
// ============================================================

wire [15:0] instr_id     = IFID_instr;
wire [2:0]  opcode_id    = instr_id[2:0];
wire [3:0]  func_id      = instr_id[6:3];

// --- Raw field extraction ---

// R-type
wire [2:0] rs1_r_id = instr_id[15:13];
wire [2:0] rs2_r_id = instr_id[12:10];
wire [2:0] rd_r_id  = instr_id[9:7];

// I-type
wire [5:0] imm_i_raw_id = instr_id[15:10];
wire [2:0] rs1_i_id     = instr_id[9:7];
wire [2:0] rd_i_id      = instr_id[9:7];

// S-type
wire [6:0] imm_s_raw_id = instr_id[15:9];
wire [2:0] rs1_s_id     = instr_id[8:6];
wire [2:0] rs2_s_id     = instr_id[5:3];

// L-type
wire [6:0] imm_l_raw_id = instr_id[15:9];
wire [2:0] rs1_l_id     = instr_id[8:6];
wire [2:0] rd_l_id      = instr_id[5:3];

// B-type
wire [4:0] imm_b_raw_id = instr_id[15:11];
wire [2:0] rs1_b_id     = instr_id[10:8];
wire [2:0] rs2_b_id     = instr_id[7:5];

// U-type
wire [9:0] imm_u_raw_id = instr_id[15:6];
wire [2:0] rd_u_id      = instr_id[5:3];

// J-type
wire [9:0] imm_j_raw_id = instr_id[15:6];
wire [2:0] rd_j_id      = instr_id[5:3];

// JR-type
wire [6:0] imm_jr_raw_id = instr_id[15:9];
wire [2:0] rs1_jr_id     = instr_id[7:5];
wire [2:0] rd_jr_id      = instr_id[5:3];

// --- Register address muxes ---
wire [2:0] rs1_id =
    (opcode_id == OPC_R)  ? rs1_r_id  :
    (opcode_id == OPC_I)  ? rs1_i_id  :
    (opcode_id == OPC_S)  ? rs1_s_id  :
    (opcode_id == OPC_B)  ? rs1_b_id  :
    (opcode_id == OPC_L)  ? rs1_l_id  :
    (opcode_id == OPC_JR) ? rs1_jr_id :
    3'b000;

wire [2:0] rs2_id =
    (opcode_id == OPC_R) ? rs2_r_id :
    (opcode_id == OPC_S) ? rs2_s_id :
    (opcode_id == OPC_B) ? rs2_b_id :
    3'b000;

wire [2:0] rd_id =
    (opcode_id == OPC_R)  ? rd_r_id  :
    (opcode_id == OPC_I)  ? rd_i_id  :
    (opcode_id == OPC_U)  ? rd_u_id  :
    (opcode_id == OPC_J)  ? rd_j_id  :
    (opcode_id == OPC_L)  ? rd_l_id  :
    (opcode_id == OPC_JR) ? rd_jr_id :
    3'b000;

// --- Control unit (ID instance — branch flags not yet known, pass zeros) ---
wire        PCSrc_id;
wire [1:0]  ResultSrc_id;
wire        MemWrite_id;
wire        MemRead_id;
wire        ALUSrc_id;
wire        RegWrite_id;
wire [2:0]  ImmSrc_id;
wire [3:0]  ALUControl_id;

Control_unit CU_ID (
    .opcode    (opcode_id),
    .func      (func_id),
    .zero      (1'b0),
    .negative  (1'b0),
    .PCSrc     (PCSrc_id),
    .ResultSrc (ResultSrc_id),
    .MemWrite  (MemWrite_id),
    .MemRead   (MemRead_id),
    .ALUControl(ALUControl_id),
    .ALUSrc    (ALUSrc_id),
    .ImmSrc    (ImmSrc_id),
    .RegWrite  (RegWrite_id)
);

// --- Register file (writeback from EX feeds back here) ---
wire [15:0] WD3_ex;
wire        RegWrite_ex_wb;
wire [2:0]  rd_ex_wb;
wire [15:0] RD1_id, RD2_id;
wire [15:0] rf_dbg_x1, rf_dbg_x2, rf_dbg_x3;

Register_file RF (
    .clk     (clk),
    .RegWrite(RegWrite_ex_wb),
    .A3      (rd_ex_wb),
    .WD3     (WD3_ex),
    .A1      (rs1_id),
    .RD1     (RD1_id),
    .A2      (rs2_id),
    .RD2     (RD2_id),
    .dbg_x1  (rf_dbg_x1),
    .dbg_x2  (rf_dbg_x2),
    .dbg_x3  (rf_dbg_x3)
);

// --- Sign extender ---
wire [15:0] imm_ext_id;

Sign_Extender SE (
    .instr  (instr_id),
    .ImmSrc (ImmSrc_id),
    .ImmExt (imm_ext_id)
);

// ============================================================
//  HAZARD DETECTION UNIT
// ============================================================
// Load-use hazard: if the ID/EX instruction is a load AND its
// destination matches a source register of the current ID
// instruction, stall for one cycle.

wire        IDEX_MemRead;   // forwarded from ID/EX register
wire [2:0]  IDEX_rd;        // forwarded from ID/EX register

assign stall = IDEX_MemRead &
               ((IDEX_rd == rs1_id) | (IDEX_rd == rs2_id)) &
               (IDEX_rd != 3'b000);

// ============================================================
//  ID/EX PIPELINE REGISTER
// ============================================================
// Holds everything EX needs.
// stall → insert bubble (zero all control signals).
// reset → clear.

reg [15:0] IDEX_PC;
reg [15:0] IDEX_PC_plus2;
reg [15:0] IDEX_RD1;
reg [15:0] IDEX_RD2;
reg [15:0] IDEX_imm_ext;
reg [2:0]  IDEX_rs1;
reg [2:0]  IDEX_rs2;
reg [2:0]  IDEX_rd_r;
reg [2:0]  IDEX_opcode;
reg [15:0] IDEX_instr;      // raw instruction (needed for func field in CU_EX)
// Control signals
reg        IDEX_RegWrite;
reg [1:0]  IDEX_ResultSrc;
reg        IDEX_MemWrite;
reg        IDEX_MemRead_r;
reg [3:0]  IDEX_ALUControl;
reg        IDEX_ALUSrc;

// Expose for hazard unit
assign IDEX_MemRead = IDEX_MemRead_r;
assign IDEX_rd      = IDEX_rd_r;

always @(posedge clk or posedge reset) begin
    if (reset || stall) begin
        // Bubble: neutralise all control signals
        IDEX_PC         <= 16'h0000;
        IDEX_PC_plus2   <= 16'h0000;
        IDEX_RD1        <= 16'h0000;
        IDEX_RD2        <= 16'h0000;
        IDEX_imm_ext    <= 16'h0000;
        IDEX_rs1        <= 3'b000;
        IDEX_rs2        <= 3'b000;
        IDEX_rd_r       <= 3'b000;
        IDEX_opcode     <= 3'b000;
        IDEX_instr      <= 16'h0000;
        IDEX_RegWrite   <= 1'b0;
        IDEX_ResultSrc  <= 2'b00;
        IDEX_MemWrite   <= 1'b0;
        IDEX_MemRead_r  <= 1'b0;
        IDEX_ALUControl <= 4'b0000;
        IDEX_ALUSrc     <= 1'b0;
    end else begin
        IDEX_PC         <= IFID_PC;
        IDEX_PC_plus2   <= IFID_PC_plus2;
        IDEX_RD1        <= RD1_id;
        IDEX_RD2        <= RD2_id;
        IDEX_imm_ext    <= imm_ext_id;
        IDEX_rs1        <= rs1_id;
        IDEX_rs2        <= rs2_id;
        IDEX_rd_r       <= rd_id;
        IDEX_opcode     <= opcode_id;
        IDEX_instr      <= instr_id;
        IDEX_RegWrite   <= RegWrite_id;
        IDEX_ResultSrc  <= ResultSrc_id;
        IDEX_MemWrite   <= MemWrite_id;
        IDEX_MemRead_r  <= MemRead_id;
        IDEX_ALUControl <= ALUControl_id;
        IDEX_ALUSrc     <= ALUSrc_id;
    end
end

// ============================================================
//  EX STAGE  —  Execute / Memory / Writeback
// ============================================================

// --- ALU input mux ---
wire [15:0] ALU_B_ex;

ALUSrc_mux RD_2 (
    .RD2   (IDEX_RD2),
    .ImmExt(IDEX_imm_ext),
    .ALUSrc(IDEX_ALUSrc),
    .SrcB  (ALU_B_ex)
);

// --- ALU ---
wire [15:0] ALUResult_ex;
wire        zero_ex;
wire        negative_ex;

ALU ALU_CORE (
    .SrcA       (IDEX_RD1),
    .SrcB       (ALU_B_ex),
    .ALU_control(IDEX_ALUControl),
    .ALU_result (ALUResult_ex),
    .zero       (zero_ex),
    .negative   (negative_ex)
);

// --- Re-evaluate control unit in EX with real ALU flags ---
// The ID instance used dummy zero/negative; this instance has the
// real flags so PCSrc (conditional branches) is correct.
wire        PCSrc_ex_raw;
wire [1:0]  ResultSrc_ex_raw;
wire        MemWrite_ex_raw;
wire        MemRead_ex_raw;
wire        ALUSrc_ex_raw;
wire        RegWrite_ex_raw;
wire [2:0]  ImmSrc_ex_raw;
wire [3:0]  ALUControl_ex_raw;

Control_unit CU_EX (
    .opcode    (IDEX_opcode),
    .func      (IDEX_instr[6:3]),
    .zero      (zero_ex),
    .negative  (negative_ex),
    .PCSrc     (PCSrc_ex_raw),
    .ResultSrc (ResultSrc_ex_raw),
    .MemWrite  (MemWrite_ex_raw),
    .MemRead   (MemRead_ex_raw),
    .ALUControl(ALUControl_ex_raw),
    .ALUSrc    (ALUSrc_ex_raw),
    .ImmSrc    (ImmSrc_ex_raw),
    .RegWrite  (RegWrite_ex_raw)
);

assign PCSrc_ex      = PCSrc_ex_raw;
assign jal_taken_ex  = (IDEX_opcode == OPC_J);
assign jalr_taken_ex = (IDEX_opcode == OPC_JR);

// --- Branch / jump targets ---
// branch_target uses imm directly (NO << 1), matching your updated single-cycle.
// jal_target keeps the << 1 shift from your original.
assign branch_target_ex = IDEX_PC + IDEX_imm_ext;
assign jal_target_ex    = IDEX_PC + (IDEX_imm_ext << 1);

wire [15:0] jalr_sum_ex = IDEX_RD1 + IDEX_imm_ext;
assign jalr_target_ex   = {jalr_sum_ex[15:1], 1'b0};

// --- Data memory ---
wire [15:0] ReadData_ex;

Data_Memory DMEM (
    .clk            (clk),
    .mem_access_addr(ALUResult_ex),
    .mem_write_data (IDEX_RD2),
    .mem_write_en   (IDEX_MemWrite),
    .mem_read       (IDEX_MemRead_r),
    .mem_read_data  (ReadData_ex)
);

// --- Writeback mux ---
Writeback_mux WB_MUX (
    .ALUResult(ALUResult_ex),
    .MemData  (ReadData_ex),
    .PcPlus2  (IDEX_PC_plus2),
    .MemtoReg (IDEX_ResultSrc),
    .WD3      (WD3_ex)
);

// Writeback signals fed back to ID-stage register file
assign RegWrite_ex_wb = IDEX_RegWrite;
assign rd_ex_wb       = IDEX_rd_r;

// ============================================================
//  LOAD PORT PASSTHROUGH
// ============================================================
// These signals are top-level I/O only — no pipeline interaction.
// Route load_ack as needed by your memory subsystem.
// If your Data_Memory or a loader module drives load_ack,
// connect it here. Placeholder tie-off shown below:
assign load_ack = 1'b0;  // replace with actual ack from your loader

// ============================================================
//  DEBUG OUTPUTS
// ============================================================
assign dbg_pc         = PC;
assign dbg_instr      = IFID_instr;
assign dbg_alu_result = ALUResult_ex;
assign dbg_x1         = rf_dbg_x1;
assign dbg_x2         = rf_dbg_x2;
assign dbg_x3         = rf_dbg_x3;

endmodule