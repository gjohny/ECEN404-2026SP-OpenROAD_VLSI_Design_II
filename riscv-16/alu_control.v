//Talha Ibrahim; ECEN403; UIN: 232008082
`timescale 1ns / 1ps
module alu_control(ALU_Cnt, ALUOp, func);
    output reg [3:0] ALU_Cnt; // 4-bit for more ops
    input [1:0] ALUOp;        // From main control (type of instruction)
    input [3:0] func;         // R/I type operation or func field

    wire [5:0] ALUControlIn;
    assign ALUControlIn = {ALUOp, func};

    always @(ALUControlIn) begin
        casex(ALUControlIn)
            // R-type instructions (ALUOp = 2'b00)
            6'b00_0000: ALU_Cnt = 4'b0000; // ADD
            6'b00_0001: ALU_Cnt = 4'b0001; // SUB
            6'b00_0010: ALU_Cnt = 4'b0010; // XOR
            6'b00_0011: ALU_Cnt = 4'b0011; // OR
            6'b00_0100: ALU_Cnt = 4'b0100; // AND
            6'b00_0101: ALU_Cnt = 4'b0101; // SLL
            6'b00_0110: ALU_Cnt = 4'b0110; // SRL
            6'b00_0111: ALU_Cnt = 4'b0111; // SRA
            6'b00_1000: ALU_Cnt = 4'b1000; // SLT
            6'b00_1001: ALU_Cnt = 4'b1001; // SLTU

            // I-type arithmetic (ALUOp = 2'b01)
            6'b01_0000: ALU_Cnt = 4'b0000; // ADDI
            6'b01_0001: ALU_Cnt = 4'b0010; // XORI
            6'b01_0010: ALU_Cnt = 4'b0011; // ORI
            6'b01_0011: ALU_Cnt = 4'b0100; // ANDI
            6'b01_0100: ALU_Cnt = 4'b0101; // SLLI
            6'b01_0101: ALU_Cnt = 4'b0110; // SRLI
            6'b01_0110: ALU_Cnt = 4'b0111; // SRAI
            6'b01_0111: ALU_Cnt = 4'b1000; // SLTI
            6'b01_1000: ALU_Cnt = 4'b1001; // SLTIU

            // Load/Store address calc (ALUOp = 2'b10) → ADD
            6'b10_xxxx: ALU_Cnt = 4'b0000; // ADD for lb/lh/lbu/lhu/sb/sh

            // Branches (ALUOp = 2'b11) → SUB for comparison
            6'b11_xxxx: ALU_Cnt = 4'b0001; // SUB for beq/bne/blt/bge etc.

            default: ALU_Cnt = 4'b0000; // Default ADD
        endcase
    end
endmodule
