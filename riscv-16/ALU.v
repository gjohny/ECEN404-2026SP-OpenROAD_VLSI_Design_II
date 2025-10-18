// // ===========================================================
// // 16-bit ALU for custom RISC-V 16-bit ISA
// // Supports R, I, B, J instruction classes
// // ===========================================================
// module ALU (
//     input  [15:0] a,          // Operand 1 (rs1 or PC)
//     input  [15:0] b,          // Operand 2 (rs2 or immediate)
//     input  [2:0]  opcode,     // 3-bit main opcode
//     input  [3:0]  funct,      // 4-bit subfunction code (funct field)
//     output reg [15:0] result, // Computed result
//     output reg        branch_taken, // For branch compare
//     output            zero          // Zero flag
// );

// always @(*) begin
//     // Default outputs
//     result = 16'h0000;
//     branch_taken = 1'b0;

//     case (opcode)
//         // ----------------------------
//         // R-TYPE: opcode = 000
//         // ----------------------------
//         3'b000: begin
//             case (funct)
//                 4'b0000: result = a + b;                     // ADD
//                 4'b0001: result = a - b;                     // SUB
//                 4'b0010: result = a ^ b;                     // XOR
//                 4'b0011: result = a | b;                     // OR
//                 4'b0100: result = a & b;                     // AND
//                 4'b0101: result = a << b[3:0];               // SLL
//                 4'b0110: result = a >> b[3:0];               // SRL
//                 4'b0111: result = $signed(a) >>> b[3:0];     // SRA
//                 default: result = 16'h0000;
//             endcase
//         end

//         // ----------------------------
//         // I-TYPE Arithmetic: opcode = 001
//         // ----------------------------
//         3'b001: begin
//             case (funct)
//                 4'b0000: result = a + b;                     // ADDI
//                 4'b0001: result = a ^ b;                     // XORI
//                 4'b0010: result = a | b;                     // ORI
//                 4'b0011: result = a & b;                     // ANDI
//                 4'b1101: result = a + b;                     // JALR: ALU computes PC = rs1 + imm
//                 default: result = 16'h0000;
//             endcase
//         end

//         // ----------------------------
//         // I-TYPE Load: opcode = 010
//         // S-TYPE Store: opcode = 011
//         // Address = base (a) + offset (b)
//         // ----------------------------
//         3'b010,
//         3'b011: begin
//             result = a + b;                                 // Address calculation
//         end

//         // ----------------------------
//         // B-TYPE Branches: opcode = 100
//         // funct[1:0]: 00 = BEQ, 01 = BNE
//         // ----------------------------
//         3'b100: begin
//             case (funct[1:0])
//                 2'b00: branch_taken = (a == b);             // BEQ
//                 2'b01: branch_taken = (a != b);             // BNE
//                 default: branch_taken = 1'b0;
//             endcase
//             result = 16'h0000; // ALU not used for branch result
//         end

//         // ----------------------------
//         // J-TYPE Jump and Link: opcode = 101
//         // result = PC + 2 (next PC)
//         // ----------------------------
//         3'b101: begin
//             result = a + 16'd2;                             // Typically a = PC input
//         end

//         default: result = 16'h0000;
//     endcase
// end

// assign zero = (result == 16'd0);

// endmodule



module ALU (
    input  [15:0] SrcA,
    input  [15:0] SrcB,
    input  [3:0]  ALU_control,
    output reg [15:0] ALU_result,
    output           zero
);

always @(*) begin
    case (ALU_control)
        4'b0000: ALU_result = SrcA + SrcB;                 // ADD / ADDI / Load / Store / JALR
        4'b0001: ALU_result = SrcA - SrcB;                 // SUB
        4'b0010: ALU_result = SrcA ^ SrcB;                 // XOR / XORI
        4'b0011: ALU_result = SrcA | SrcB;                 // OR / ORI
        4'b0100: ALU_result = SrcA & SrcB;                 // AND / ANDI
        4'b0101: ALU_result = SrcA << SrcB[3:0];           // SLL
        4'b0110: ALU_result = SrcA >> SrcB[3:0];           // SRL
        4'b0111: ALU_result = $signed(SrcA) >>> SrcB[3:0]; // SRA
        4'b1000: ALU_result = SrcA + 16'd2;               // JAL (PC + 2)
        default: ALU_result = 16'h0000;
    endcase
end

assign zero = (ALU_result == 16'd0);

endmodule
