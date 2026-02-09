<<<<<<< HEAD
module riscv16_top (
    input  wire       clk,
    input  wire       reset,
=======
module top (
    input clk,
    input reset
);
>>>>>>> 7a982f7780ad9e83046568c19e77c5bc9c8d07a2

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

    pc_counter_16 PC_REG (
        .clk(clk),
        .reset(reset),
        .PC_next(PC_next),
        .PC(PC)
    );

    Instruction_memory IMEM (
        .addr(PC),           // or .pc(PC) if your module calls it 'pc'
        .instruction(instruction)
    );

    /* =====================
       Instruction Fields
       (match ISA / Sign_Extender)
    ====================== */
    wire [2:0] opcode = instruction[2:0];
    wire [3:0] func   = instruction[6:3];
    wire [2:0] rd     = instruction[9:7];
    wire [2:0] rs2    = instruction[12:10];
    wire [2:0] rs1    = instruction[15:13];

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

    /* =====================
       Register File
    ====================== */
    wire [15:0] RD1, RD2, WD3;
    wire [15:0] rf_dbg_x1;

    Register_file RF (
        .clk(clk),
        .RegWrite(RegWrite),   // use your real port name
        .A3(rd),
        .WD3(WD3),
        .A1(rs1),
        .RD1(RD1),
        .A2(rs2),
        .RD2(RD2),
        .dbg_x1(rf_dbg_x1)     // new debug port
    );

    /* =====================
       Immediate Generation
    ====================== */
    wire [15:0] imm_ext;
    wire [2:0] ImmSrc_ext = {1'b0, ImmSrc}; // if Sign_Extender expects 3 bits

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

    ALUSrc_mux EX_MUX (
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
    Memory_mux WB_MUX (
        .ALUResult(ALUResult),
        .MemData(ReadData),
        .ResultSrc(ResultSrc),
        .Result(WD3)
    );

    /* =====================
       PC Update Logic
    ====================== */
    PCTarget PC_ADD (
        .PC(PC),
        .imm_ext(imm_ext),
        .PC_target(PC_target)
    );

    assign PC_next = PCSrc ? PC_target : PC_plus2;

    /* =====================
       Debug outputs
    ====================== */
    assign dbg_pc         = PC;
    assign dbg_instr      = instruction;
    assign dbg_alu_result = ALUResult;
    assign dbg_x1         = rf_dbg_x1;

endmodule