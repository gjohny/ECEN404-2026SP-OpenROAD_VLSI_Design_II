`timescale 1ns/1ps
module Instruction_memory #(
    parameter IMEM_WORDS = 256,
    parameter MEMFILE = "src/program16.mem"
)(
    input      clk,
    input      [15:0] pc,
    output reg [15:0] instruction
);
    // Memory array
    reg [15:0] memory [0:IMEM_WORDS-1];
    integer i;

    // Initialize memory
    initial begin
        for (i = 0; i < IMEM_WORDS; i = i + 1)
            memory[i] = 16'h0000;
        // Always load memfile16
        $readmemh("src/program16.mem", memory);  // or "memfile16.mem"
    end

    // Word-aligned index
    wire [15:0] word_index = pc[15:1];

    // Read memory on every clock
    always @(posedge clk) begin
        if (word_index < IMEM_WORDS)
            instruction <= memory[word_index];
        else
            instruction <= 16'h0000; // Return 0 if out-of-bounds
    end
endmodule