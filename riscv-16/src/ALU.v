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
