`timescale 1ns / 1ps

module Writeback_mux(
    input [15:0] ALUResult,  // Result from ALU
    input [15:0] MemData,    // Data read from memory
    input [15:0] PcPlus2,   // PC + 2 for JAL/JALR
    input [1:0]  MemtoReg,          // Control signal from Control Unit
    output [15:0] WD3        // Data to write back to register file
);

    assign WD3 =
        (MemtoReg == 2'b00) ? ALUResult :
        (MemtoReg == 2'b01) ? MemData  :
        (MemtoReg == 2'b10) ? PcPlus2   :
                            ALUResult; // Default case (should not happen)

endmodule