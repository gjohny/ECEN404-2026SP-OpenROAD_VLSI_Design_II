<<<<<<< HEAD
`timescale 1ns / 1ps

module Instruction_Memory_16 #(
    parameter IMEM_WORDS = 256,           // number of 16-bit instruction words
    parameter MEMFILE    = "program16.mem" // ← YOUR FILE NAME HERE
)(
    input      [15:0] pc,                 // byte address from PC counter
    output     [15:0] instruction         // 16-bit instruction output
);
    // Memory array: 256 words × 16 bits
    reg [15:0] memory [0:IMEM_WORDS-1];

    // ← FILE IS LOADED HERE (at time 0, before simulation starts)
    initial begin
        if (MEMFILE != "") begin
            $readmemh(MEMFILE, memory);   // ← READS program16.mem
        end else begin
            // If no file, initialize to zeros (NOPs)
            integer i;
            for (i = 0; i < IMEM_WORDS; i = i + 1) begin
                memory[i] = 16'h0000;
            end
        end
    end

    // Asynchronous read: use pc[15:1] for word index (2-byte aligned) [2]
    assign instruction = memory[pc[15:1]];
endmodule
=======
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
>>>>>>> ddc28fd087b1ed09f9f8d411d5d7cc6f0d6b752d
