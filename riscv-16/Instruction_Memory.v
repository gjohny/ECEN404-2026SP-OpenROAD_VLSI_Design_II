`timescale 1ns/1ps

module Instruction_Memory_16 #(
    parameter IMEM_WORDS = 256,
    parameter MEMFILE    = "program16.mem"
)(
    input      [15:0] pc,
    output reg [15:0] instruction
);
    reg [15:0] memory [0:IMEM_WORDS-1];
    integer i;

    initial begin
        // Initialize all memory to zero first
        for (i = 0; i < IMEM_WORDS; i = i + 1)
            memory[i] = 16'h0000;
        
        // Load program file if specified (overwrites zeros)
        if (MEMFILE != "")
            $readmemh(MEMFILE, memory);
    end

    // Bounds-checked read
    wire [15:0] word_index = pc[15:1];
    
    always @(*) begin
        if (word_index < IMEM_WORDS)
            instruction = memory[word_index];
        else
            instruction = 16'h0000;  // Return 0 for out-of-bounds
    end
endmodule