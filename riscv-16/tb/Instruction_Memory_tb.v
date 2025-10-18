`timescale 1ns / 1ps

module tb_instruction_memory;

    // Inputs
    reg [15:0] pc;
    
    // Output
    wire [15:0] instruction;

    // Instantiate instruction memory
    Instruction_Memory_16 #(
        .IMEM_WORDS(256),
        .MEMFILE("program16.mem")  // Create this file or use empty string for zeros
    ) uut (
        .pc(pc),
        .instruction(instruction)
    );

    // Test sequence
    initial begin
        // Waveform dump
        $dumpfile("tb_instruction_memory.vcd");
        $dumpvars(0, tb_instruction_memory);

        // Display header
        $display("\n========================================");
        $display("  Instruction Memory Testbench");
        $display("========================================\n");
        $display("PC (byte)\tPC (word)\tInstruction");
        $display("---------\t---------\t-----------");

        // Initialize
        pc = 16'h0000;
        #10;

        // Test 1: Sequential read through memory
        $display("\n--- Test 1: Sequential Memory Read ---");
        repeat(16) begin
            #10;
            $display("%h\t\t%h\t\t%h", pc, pc[15:1], instruction);
            pc = pc + 16'd2;  // increment by 2 (16-bit instructions)
        end

        // Test 2: Random access
        $display("\n--- Test 2: Random Access ---");
        pc = 16'h0010; #10;
        $display("%h\t\t%h\t\t%h", pc, pc[15:1], instruction);
        
        pc = 16'h0050; #10;
        $display("%h\t\t%h\t\t%h", pc, pc[15:1], instruction);
        
        pc = 16'h00A0; #10;
        $display("%h\t\t%h\t\t%h", pc, pc[15:1], instruction);
        
        pc = 16'h00F0; #10;
        $display("%h\t\t%h\t\t%h", pc, pc[15:1], instruction);

        // Test 3: Boundary conditions
        $display("\n--- Test 3: Boundary Conditions ---");
        pc = 16'h0000; #10;
        $display("First location:  PC=%h Instr=%h", pc, instruction);
        
        pc = 16'h01FE; #10;  // last word in 256-word memory
        $display("Last location:   PC=%h Instr=%h", pc, instruction);

        // Test 4: Alignment check (odd addresses)
        $display("\n--- Test 4: Alignment Check ---");
        $display("Even address (0x0010):");
        pc = 16'h0010; #10;
        $display("  PC=%h word_index=%h Instr=%h", pc, pc[15:1], instruction);
        
        $display("Odd address (0x0011) - should read same as 0x0010:");
        pc = 16'h0011; #10;
        $display("  PC=%h word_index=%h Instr=%h", pc, pc[15:1], instruction);
        $display("  (Note: pc[15:1] ignores LSB, so odd/even map to same word)");

        // Test 5: Read pattern verification
        $display("\n--- Test 5: Pattern Verification ---");
        $display("Reading addresses 0x0000 through 0x000E:");
        pc = 16'h0000;
        repeat(8) begin
            #10;
            $display("  PC=%h -> Instr=%h", pc, instruction);
            pc = pc + 16'd2;
        end

        // Test 6: Wrap-around / out-of-range
        $display("\n--- Test 6: Out-of-Range Access ---");
        pc = 16'h0200; #10;  // beyond 256 words (0x1FF is max byte address)
        $display("PC=%h (out of range) -> Instr=%h", pc, instruction);
        $display("(Behavior depends on MEMFILE parameter - may return 0000 or X)");

        // End
        #50;
        $display("\n========================================");
        $display("  Instruction Memory Test Complete");
        $display("========================================\n");
        $finish;
    end

    // Timeout watchdog
    initial begin
        #2000;
        $display("\nERROR: Testbench timeout!");
        $finish;
    end

endmodule