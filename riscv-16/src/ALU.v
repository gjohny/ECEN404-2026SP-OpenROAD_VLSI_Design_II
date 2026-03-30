`timescale 1ns / 1ps

module ALU (
    input  [15:0] SrcA,
    input  [15:0] SrcB,
    input  [3:0]  ALU_control,
    output reg [15:0] ALU_result,
    output            zero,
    output            negative
);

// ALU_control encoding (must match ALUControl values from Control_unit):
//   0000 → ADD
//   0001 → SUB
//   0010 → XOR
//   0011 → OR
//   0100 → AND
//   0101 → SLL  (shift left logical)
//   0110 → SRL  (shift right logical)
//   0111 → SRA  (shift right arithmetic)
//   1000 → SLT  (set less than, signed)  FIX: was "SrcA + 2" (wrong)
//   1001 → SLTU (set less than, unsigned)
//   default → pass SrcB through

always @(*) begin
    case (ALU_control)
        4'b0000: ALU_result = SrcA + SrcB;
        4'b0001: ALU_result = SrcA - SrcB;
        4'b0010: ALU_result = SrcA ^ SrcB;
        4'b0011: ALU_result = SrcA | SrcB;
        4'b0100: ALU_result = SrcA & SrcB;
        4'b0101: ALU_result = SrcA << SrcB[3:0];
        4'b0110: ALU_result = SrcA >> SrcB[3:0];
        4'b0111: ALU_result = $signed(SrcA) >>> SrcB[3:0];
        // FIX: func=8 used to do "SrcA + 2" (the JAL PC+2 path, wrong here).
        // Now correctly implements signed set-less-than.
        4'b1000: ALU_result = ($signed(SrcA) < $signed(SrcB)) ? 16'd1 : 16'd0;
        4'b1001: ALU_result = (SrcA < SrcB) ? 16'd1 : 16'd0;
        default: ALU_result = SrcB;
    endcase
end

assign zero     = (ALU_result == 16'd0);
assign negative =  ALU_result[15];

endmodule