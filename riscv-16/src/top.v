module riscv16_top (
    input clk,
    input reset
);

    /* =====================
       IF Stage
    ====================== */
    wire [15:0] PC, PC_next, PC_plus2, PC_target;
    wire [15:0] instruction;

    assign PC_plus2 = PC + 16'd2;

    pc_counter_16 PC_REG (
        .clk(clk),
        .reset(reset),
        .PC_next(PC_next),
        .PC(PC)
    );

    Instruction_memory IMEM (
        .addr(PC),
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

    wire zero;

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

    Register_file RF (
        .clk(clk),
        .we3(RegWrite),
        .ra1(rs1),
        .ra2(rs2),
        .wa3(rd),
        .wd3(WD3),
        .rd1(RD1),
        .rd2(RD2)
    );

    /* =====================
       Immediate Generation
    ====================== */
    wire [15:0] imm_ext;

    Sign_Extender SE (
        .instr(instruction),
        .ImmSrc(ImmSrc),
        .imm_ext(imm_ext)
    );

    /* =====================
       Execute Stage
    ====================== */
    wire [15:0] ALU_B;
    wire [15:0] ALUResult;

    ALUSrc_mux EX_MUX ( //need to create mux
        .reg_data(RD2),
        .imm_data(imm_ext),
        .ALUSrc(ALUSrc),
        .ALU_B(ALU_B)
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
    Memory_mux WB_MUX ( //need to create mux
        .ALUResult(ALUResult),
        .MemData(ReadData),
        .ResultSrc(ResultSrc),
        .Result(WD3)
    );

    /* =====================
       PC Update Logic
    ====================== */
    PCTarget PC_ADD ( //need to create target
        .PC(PC),
        .imm_ext(imm_ext),
        .PC_target(PC_target)
    );

    assign PC_next = PCSrc ? PC_target : PC_plus2;

endmodule
