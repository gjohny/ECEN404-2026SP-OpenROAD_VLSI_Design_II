`timescale 1ns / 1ps

module riscv16_top (
    input  wire       clk,
    input  wire       reset,

    // Debug outputs
    output wire [15:0] dbg_pc,
    output wire [15:0] dbg_instr,
    output wire [15:0] dbg_alu_result,
    output wire [15:0] dbg_x1,
    output wire [15:0] dbg_x2,
    output wire [15:0] dbg_x3,
    output wire [15:0] dbg_x4,
    output wire [15:0] dbg_x5,
    output wire [15:0] dbg_x6,
    output wire [15:0] dbg_x7
);

    /* =====================
       IF Stage
    ====================== */
    wire [15:0] PC, PC_next, PC_plus2, PC_target;
    wire [15:0] instruction;

    assign PC_plus2 = PC + 16'd2;


    /* =====================
    Instruction Fields
    ===================== */

    wire [2:0] opcode = instruction[2:0];

    localparam OPC_R = 3'b000;
    localparam OPC_I = 3'b001;
    localparam OPC_L = 3'b010;
    localparam OPC_S = 3'b011;
    localparam OPC_B = 3'b100;
    localparam OPC_U = 3'b110;
    localparam OPC_J = 3'b101;

    wire jal_taken  = (opcode == OPC_J);
    wire jalr_taken = (opcode == OPC_I) && (func == 4'b1101);   


    wire [3:0] func = instruction[6:3];

    /* =====================
    Raw Field Extraction
    ===================== */

    // ---------- R-Type ----------
    wire [2:0] rs1_r = instruction[15:13];
    wire [2:0] rs2_r = instruction[12:10];
    wire [2:0] rd_r  = instruction[9:7];

    // ---------- I-Type ----------
    wire [5:0] imm_i_raw = instruction[15:10];   // imm[2:0]
    wire [2:0] rd_i      = instruction[9:7];

    // ---------- S-Type ----------
    wire [6:0] imm_s_raw = instruction[15:9];    // imm[6:0]
    wire [2:0] rs1_s     = instruction[8:6];
    wire [2:0] rs2_s     = instruction[5:3];

    // ---------- L-Type ----------
    wire [6:0] imm_l_raw = instruction[15:9];    // imm[6:0]
    wire [2:0] rs1_l     = instruction[8:6];
    wire [2:0] rd_l     = instruction[5:3];

    // ---------- B-Type ----------
    wire [2:0] imm_b_hi  = instruction[15:13];   // imm[6:4]
    wire [3:0] imm_b_lo  = instruction[12:9];    // imm[3:0]
    wire [2:0] rs1_b     = instruction[8:6];
    wire [2:0] rs2_b     = instruction[5:3];

    // ---------- U-Type ----------
    wire [9:0] imm_u_raw = instruction[15:6];    // imm[12:3]
    wire [2:0] rd_u      = instruction[5:3];

    // ---------- J-Type ----------
    wire [9:0] imm_j_raw = instruction[15:6];    // imm[15:6]
    wire [2:0] rd_j      = instruction[5:3];


    /* =====================
    Register Selection
    ===================== */

    wire [2:0] rs1 =
        (opcode == OPC_R) ? rs1_r :
        (opcode == OPC_I) ? rd_i :
        (opcode == OPC_S) ? rs1_s :
        (opcode == OPC_B) ? rs1_b :
        (opcode == OPC_L) ? rs1_l :
        3'b000;

    wire [2:0] rs2 =
        (opcode == OPC_R) ? rs2_r :
        (opcode == OPC_S) ? rs2_s :
        (opcode == OPC_B) ? rs2_b :
        3'b000;

    wire [2:0] rd =
        (opcode == OPC_R) ? rd_r :
        (opcode == OPC_I) ? rd_i :
        (opcode == OPC_U) ? rd_u :
        (opcode == OPC_J) ? rd_j :
        (opcode == OPC_L) ? rd_l :
        3'b000;


    /* =====================
    Immediate Construction
    ===================== */

    // Sign-extend immediates to 16 bits

    wire [15:0] imm_i = {{10{imm_i_raw[5]}}, imm_i_raw};              // 3-bit signed
    wire [15:0] imm_s = {{9{imm_s_raw[6]}}, imm_s_raw};               // 7-bit signed
    wire [15:0] imm_b = {{9{imm_b_hi[2]}}, imm_b_hi, imm_b_lo};       // 7-bit signed
    wire [15:0] imm_u = {imm_u_raw, 6'b000000};                       // upper immediate
    wire [15:0] imm_j = {{6{imm_j_raw[9]}}, imm_j_raw};               // 10-bit signed

        wire signed [6:0] branch_imm_raw = {imm_b_hi, imm_b_lo};

    /* =====================
    Unified Immediate Output
    ===================== */

    wire [15:0] imm =
        (opcode == OPC_I) ? imm_i :
        (opcode == OPC_S) ? imm_s :
        (opcode == OPC_B) ? imm_b :
        (opcode == OPC_U) ? imm_u :
        (opcode == OPC_J) ? imm_j :
        16'h0000;

    wire [15:0] branch_target = PC + (imm_b << 1);
    wire [15:0] jal_target    = PC + (imm_j << 1);
    wire [15:0] jalr_sum = RD1 + imm_i;
    wire [15:0] jalr_target = {jalr_sum[15:1], 1'b0};

    /* =====================
       PC Update Logic
    ====================== */
    // Keep these signals for naming consistency with your skeleton,
    // but they are not currently feeding pc_counter_16 (see note above).
    assign PC_target = PC + imm_ext;
    assign PC_next = jalr_taken  ? jalr_target  :
                     jal_taken   ? jal_target   :
                     PCSrc       ? branch_target:
                     PC_plus2;
        

    pc_counter_16 PC_REG (
    .clk(clk),
    .reset(reset),
    .pc_en(1'b1),
    .pc_next(PC_next),
    .pc(PC)
    );

    Instruction_memory #(
        .IMEM_WORDS(256),
        .MEMFILE("src/program16.mem")
    ) IMEM (
        .clk(clk),
        .pc(PC),
        .instruction(instruction)
    );


    /* =====================
       Control Unit
    ====================== */
    wire        PCSrc;
    wire        ResultSrc;
    wire        MemWrite;
    wire        ALUSrc;
    wire        RegWrite;
    wire [2:0]  ImmSrc;
    wire [3:0]  ALUControl;
    wire        zero;

    // Use the actual module name Control_Unit from the report [1]
    Control_unit CU (
        .opcode(opcode),
        .func(func),
        .zero(zero),
        .PCSrc(PCSrc),
        .ResultSrc(ResultSrc),
        .MemWrite(MemWrite),
        .ALUControl(ALUControl),
        .ALUSrc(ALUSrc),
        .ImmSrc(ImmSrc),
        .RegWrite(RegWrite)
    );

    /* =====================
       Register File
    ====================== */
    wire [15:0] RD1, RD2, WD3;
    wire [15:0] rf_dbg_x1;
    wire [15:0] rf_dbg_x2;
    wire [15:0] rf_dbg_x3;
    wire [15:0] rf_dbg_x4;
    wire [15:0] rf_dbg_x5;
    wire [15:0] rf_dbg_x6;
    wire [15:0] rf_dbg_x7;

    // Match your Register_file port names from the report [1]
    Register_file RF (
        .clk(clk),
        .RegWrite(RegWrite),
        .A3(rd),
        .WD3(WD3),
        .A1(rs1),
        .RD1(RD1),
        .A2(rs2),
        .RD2(RD2),
        .dbg_x1(rf_dbg_x1),   // this is your added debug port
        .dbg_x2(rf_dbg_x2),
        .dbg_x3(rf_dbg_x3),
        .dbg_x4(rf_dbg_x4),
        .dbg_x5(rf_dbg_x5),
        .dbg_x6(rf_dbg_x6),
        .dbg_x7(rf_dbg_x7)
    );

    /* =====================
       Immediate Generation
    ====================== */
    wire [15:0] imm_ext;

    Sign_Extender SE (
        .instr(instruction),
        .ImmSrc(ImmSrc),
        .ImmExt(imm_ext)
    );

    /* =====================
       Execute Stage
    ====================== */
    wire [15:0] ALU_B;
    wire [15:0] ALUResult;

    ALUSrc_mux RD_2 (
        .RD2(RD2),
        .ImmExt(imm_ext),
        .ALUSrc(ALUSrc),
        .SrcB(ALU_B)
    );


    ALU ALU_CORE (
        .SrcA(RD1),
        .SrcB(ALU_B),
        .ALU_control(ALUControl),
        .ALU_result(ALUResult),
        .zero(zero)
    );

    /* =====================
       Data Memory
    ====================== */
    wire [15:0] ReadData;

    Data_Memory DMEM (
        .clk(clk),
        .mem_access_addr(ALUResult),
        .mem_write_data(RD2),
        .mem_write_en(MemWrite),
        .mem_read(ResultSrc),
        .mem_read_data(ReadData)
    );

    /* =====================
       Writeback
    ====================== */
    assign WD3 = (ResultSrc) ? ReadData : ALUResult;



    /* =====================
       Debug
    ====================== */
    assign dbg_pc         = PC;
    assign dbg_instr      = instruction;
    assign dbg_alu_result = ALUResult;
    assign dbg_x1         = rf_dbg_x1;
    assign dbg_x2         = rf_dbg_x2;
    assign dbg_x3         = rf_dbg_x3;
    assign dbg_x4         = rf_dbg_x4;
    assign dbg_x5         = rf_dbg_x5;
    assign dbg_x6         = rf_dbg_x6;
    assign dbg_x7         = rf_dbg_x7;

endmodule