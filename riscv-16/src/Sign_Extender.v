`timescale 1ns / 1ps
module Sign_Extender(
    input  wire [15:0] instr,
    input  wire [2:0]  ImmSrc,   
    output reg  [15:0] ImmExt
);

always @(*) begin
    case (ImmSrc)
        3'b000: ImmExt = 16'b0;                                         // R-type: no immediate
        3'b001: ImmExt = {{13{instr[15]}}, instr[15:13]};                // I-type (ALU immediate)
        3'b010: ImmExt = {{9{instr[15]}}, instr[15:9]};                  // S-type (stores)
        3'b011: ImmExt = {{9{instr[15]}}, {instr[15:13], instr[12:9]}} << 1; // B-type (branches)
        3'b100: ImmExt = {instr[15:6], 6'b000000};                          // U-type (upper bits)
        3'b101: ImmExt = {{6{instr[15]}}, instr[15:6]};             // J-type (jump and link)
        default: ImmExt = 16'b0;                                         // fallback
    endcase
end

endmodule
