`timescale 1ns / 1ps

module riscv16_top (
    input  wire       clk,
    input  wire       reset,

    // Debug outputs
    output wire [15:0] dbg_pc,
    output wire [15:0] dbg_instr,
    output wire [15:0] dbg_alu_result,
    output wire [15:0] dbg_x1
);

    /* =====================
       IF Stage
    ====================== */
    wire [15:0] PC, PC_next, PC_plus2, PC_target;
    wire [15:0] instruction;

    assign PC_plus2 = PC + 16'd2;

    // NOTE: pc_counter_16 from the report does not take PC_next as an input [1].
    // It computes next PC internally based on branch/jal/jalr signals.
    // For now we tie branch/jal/jalr inactive so it behaves like PC := PC+2.
    pc_counter_16 PC_REG (
        .clk(clk),
        .reset(reset),
        .pc_en(1'b1),

        .branch_taken(1'b0),
        .branch_imm(7'sd0),

        .jal_taken(1'b0),
        .jal_imm(10'sd0),

        .jalr_taken(1'b0),
        .jalr_target(16'h0000),

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
       Instruction Fields
    ====================== */
    wire [2:0] opcode = instruction[2:0];
    wire [3:0] func   = instruction[6:3];
    wire [2:0] rs1    = instruction[15:13];
    wire [2:0] rs2    = instruction[12:10];
    wire [2:0] rd     = instruction[9:7];

    /* =====================
       Control Unit
    ====================== */
    wire        PCSrc;
    wire        ResultSrc;
    wire        MemWrite;
    wire        ALUSrc;
    wire        RegWrite;
    wire [1:0]  ImmSrc;
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
        .dbg_x1(rf_dbg_x1)   // this is your added debug port
    );

    /* =====================
       Immediate Generation
    ====================== */
    wire [15:0] imm_ext;

    // Sign_Extender in the report expects ImmSrc[2:0], not [1:0] [1]
    wire [2:0] ImmSrc_ext = {1'b0, ImmSrc};

    Sign_Extender SE (
        .instr(instruction),
        .ImmSrc(ImmSrc_ext),
        .ImmExt(imm_ext)
    );

    /* =====================
       Execute Stage
    ====================== */
    wire [15:0] ALU_B;
    wire [15:0] ALUResult;

    // Replace EX_MUX module with a simple assign so it works now
    assign ALU_B = (ALUSrc) ? imm_ext : RD2;

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
    // Replace WB_MUX module with a simple assign so it works now
    assign WD3 = (ResultSrc) ? ReadData : ALUResult;

    /* =====================
       PC Update Logic
    ====================== */
    // Keep these signals for naming consistency with your skeleton,
    // but they are not currently feeding pc_counter_16 (see note above).
    assign PC_target = PC + imm_ext;
    assign PC_next   = (PCSrc) ? PC_target : PC_plus2;

    /* =====================
       Debug
    ====================== */
    assign dbg_pc         = PC;
    assign dbg_instr      = instruction;
    assign dbg_alu_result = ALUResult;
    assign dbg_x1         = rf_dbg_x1;

endmodule