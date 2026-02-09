`timescale 1ns/1ps

module ALUSrc_mux(
    input [31:0] RD2,       // Data from register file
    input [31:0] ImmExt,    // Sign-extended immediate
    input ALUSrc,           // Control signal from Control Unit
    output [31:0] SrcB   // Output to ALU
);

    assign SrcB = (ALUSrc) ? ImmExt : RD2;

endmodule
