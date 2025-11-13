`timescale 1ns / 1ps
module Sign_Extender(
    input  wire [15:0] instr,
    input  wire [1:0] ImmSrc,   // select immediate type
    output reg  [15:0] ImmExt
);

always @(*) begin
    case (ImmSrc)
        2'b00: ImmExt = {{13{instr[15]}}, instr[15:13]};                // I-type
        2'b01: ImmExt = {{9{instr[15]}}, {instr[15:13], instr[12:9]}}; // B-type
        2'b10: ImmExt = {instr[15:6], 6'b000000};                       // J-type
        2'b11: ImmExt = {{9{instr[15]}}, instr[15:9]};                  // S-type
        default: ImmExt = 16'b0;                                        // fallback
    endcase
end

endmodule
