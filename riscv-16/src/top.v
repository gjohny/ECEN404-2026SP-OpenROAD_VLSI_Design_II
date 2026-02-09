`timescale 1ns / 1ps

module top (
    input  wire       clk,
    input  wire       reset,

    // Debug outputs
    output wire [15:0] dbg_pc,
    output wire [15:0] dbg_instr,
    output wire [15:0] dbg_alu_result,
    output wire [15:0] dbg_x1
);
    // IF stage
    wire [15:0] PC;
    wire [15:0] instruction;

    pc_counter_16 PC_REG (
        .clk(clk),
        .reset(reset),
        .pc_en(1'b1),        // no stalls for now
        .branch_taken(1'b0), // simple core, no branches wired yet
        .branch_imm(7'd0),
        .jal_taken(1'b0),
        .jal_imm(10'd0),
        .jalr_taken(1'b0),
        .jalr_target(16'd0),
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

    // Decode fields (ISA layout) [2]
    wire [2:0] opcode = instruction[2:0];
    wire [3:0] func   = instruction[6:3];
    wire [2:0] rd     = instruction[9:7];
    wire [2:0] rs2    = instruction[12:10];
    wire [2:0] rs1    = instruction[15:13];

    // Control unit
    wire        PCSrc;
    wire        ResultSrc;
    wire        MemWrite;
    wire        ALUSrc;
    wire        RegWrite;
    wire [1:0]  ImmSrc;
    wire [3:0]  ALUControl;
    wire        zero;

    Control_Unit CU (
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

    // Register file
    wire [15:0] RD1, RD2, WD3;
    wire [15:0] rf_dbg_x1;

    Register_file RF (
        .clk(clk),
        .RegWrite(RegWrite),
        .A3(rd),
        .WD3(WD3),
        .A1(rs1),
        .RD1(RD1),
        .A2(rs2),
        .RD2(RD2),
        .dbg_x1(rf_dbg_x1)
    );

    // Immediate generation
    wire [15:0] imm_ext;
    wire [2:0]  ImmSrc_ext = {1'b0, ImmSrc}; // Sign_Extender expects 3 bits [1]

    Sign_Extender SE (
        .instr(instruction),
        .ImmSrc(ImmSrc_ext),
        .ImmExt(imm_ext)
    );

    // Execute
    wire [15:0] ALU_B;
    wire [15:0] ALUResult;

    // Simple ALUSrc mux (reg vs imm)
    assign ALU_B = (ALUSrc) ? imm_ext : RD2;

    ALU ALU_CORE (
        .SrcA(RD1),
        .SrcB(ALU_B),
        .ALU_control(ALUControl),
        .ALU_result(ALUResult),
        .zero(zero)
    );

    // Data memory
    wire [15:0] ReadData;

    Data_Memory DMEM (
        .clk(clk),
        .mem_access_addr(ALUResult),
        .mem_write_data(RD2),
        .mem_write_en(MemWrite),
        .mem_read(ResultSrc),
        .mem_read_data(ReadData)
    );

    // Writeback
    assign WD3 = (ResultSrc) ? ReadData : ALUResult;

    // For now, ignore PCSrc and just do sequential PC+2
    // (since pc_counter_16 is handling PC increment and we aren't wiring branches yet)
    // Later you can replace with full PC control.

    // Debug outputs
    assign dbg_pc         = PC;
    assign dbg_instr      = instruction;
    assign dbg_alu_result = ALUResult;
    assign dbg_x1         = rf_dbg_x1;

endmodule