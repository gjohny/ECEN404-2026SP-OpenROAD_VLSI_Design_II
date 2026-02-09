`timescale 1ns/1ps

module Memory_mux (
    input  wire [15:0] ALUResult,
    input  wire [15:0] MemData,
    input  wire        ResultSrc,
    output wire [15:0] Result
);
    // ResultSrc = 0 -> write back ALU result
    // ResultSrc = 1 -> write back memory load data
    assign Result = ResultSrc ? MemData : ALUResult;

endmodule
