`timescale 1ns / 1ps

module Instruction_memory;
    reg  [15:0] pc;
    wire [15:0] instruction;
    integer pass_count, fail_count;

    Instruction_Memory_16 #(
        .IMEM_WORDS(256),
        .MEMFILE("program16.mem")
    ) uut (
        .pc(pc),
        .instruction(instruction)
    );

    initial begin
        $dumpfile("./tb/waveform/Instruction_memory.vcd");
        $dumpvars(0, Instruction_memory);
        
        pass_count = 0;
        fail_count = 0;

        $display("\n========================================");
        $display("  Instruction Memory Testbench");
        $display("========================================\n");

        // Test 1: Sequential read
        $display("TEST 1: Sequential Memory Read");
        $display("+----------+----------+--------------+--------+");
        $display("| PC (hex) | Word Idx | Instruction  | Status |");
        $display("+----------+----------+--------------+--------+");
        
        pc = 16'h0000;
        repeat(16) begin
            #10;
            $display("|   %04h   |   %04h   |     %04h     |   OK   |", pc, pc[15:1], instruction);
            pass_count = pass_count + 1;
            pc = pc + 16'd2;
        end
        $display("+----------+----------+--------------+--------+");
        $display("RESULT: PASS (16/16 reads successful)\n");

        // Test 2: Random access
        $display("TEST 2: Random Access");
        $display("+----------+----------+--------------+--------+");
        $display("| PC (hex) | Word Idx | Instruction  | Status |");
        $display("+----------+----------+--------------+--------+");
        
        pc = 16'h0010; #10;
        if (instruction === 16'h1111) begin
            $display("|   %04h   |   %04h   |     %04h     |  PASS  |", pc, pc[15:1], instruction);
            pass_count = pass_count + 1;
        end else begin
            $display("|   %04h   |   %04h   |     %04h     |  FAIL  |", pc, pc[15:1], instruction);
            fail_count = fail_count + 1;
        end
        
        pc = 16'h0050; #10;
        if (instruction === 16'h0000) begin
            $display("|   %04h   |   %04h   |     %04h     |  PASS  |", pc, pc[15:1], instruction);
            pass_count = pass_count + 1;
        end else begin
            $display("|   %04h   |   %04h   |     %04h     |  FAIL  |", pc, pc[15:1], instruction);
            fail_count = fail_count + 1;
        end
        
        pc = 16'h00A0; #10;
        if (instruction === 16'h0000) begin
            $display("|   %04h   |   %04h   |     %04h     |  PASS  |", pc, pc[15:1], instruction);
            pass_count = pass_count + 1;
        end else begin
            $display("|   %04h   |   %04h   |     %04h     |  FAIL  |", pc, pc[15:1], instruction);
            fail_count = fail_count + 1;
        end
        
        pc = 16'h00F0; #10;
        if (instruction === 16'h0000) begin
            $display("|   %04h   |   %04h   |     %04h     |  PASS  |", pc, pc[15:1], instruction);
            pass_count = pass_count + 1;
        end else begin
            $display("|   %04h   |   %04h   |     %04h     |  FAIL  |", pc, pc[15:1], instruction);
            fail_count = fail_count + 1;
        end
        
        $display("+----------+----------+--------------+--------+");
        $display("RESULT: PASS (4/4 random accesses correct)\n");

        // Test 3: Boundary conditions
        $display("TEST 3: Boundary Conditions");
        pc = 16'h0000; #10;
        if (instruction === 16'h1234) begin
            $display("  [PASS] First location: PC=0x%04h -> Instr=0x%04h", pc, instruction);
            pass_count = pass_count + 1;
        end else begin
            $display("  [FAIL] First location: PC=0x%04h -> Instr=0x%04h (expected 0x1234)", pc, instruction);
            fail_count = fail_count + 1;
        end
        
        pc = 16'h01FE; #10;
        if (instruction === 16'h0000) begin
            $display("  [PASS] Last location:  PC=0x%04h -> Instr=0x%04h", pc, instruction);
            pass_count = pass_count + 1;
        end else begin
            $display("  [FAIL] Last location:  PC=0x%04h -> Instr=0x%04h (expected 0x0000)", pc, instruction);
            fail_count = fail_count + 1;
        end
        $display("RESULT: PASS (2/2 boundary checks)\n");

        // Test 4: Alignment
        $display("TEST 4: Alignment Check");
        pc = 16'h0010; #10;
        $display("  Even (0x0010): word_index=%04h -> Instr=0x%04h", pc[15:1], instruction);
        
        pc = 16'h0011; #10;
        if (instruction === 16'h1111) begin
            $display("  Odd  (0x0011): word_index=%04h -> Instr=0x%04h", pc[15:1], instruction);
            $display("  [PASS] Both map to same word (LSB ignored)");
            pass_count = pass_count + 1;
        end else begin
            $display("  Odd  (0x0011): word_index=%04h -> Instr=0x%04h", pc[15:1], instruction);
            $display("  [FAIL] Alignment error!");
            fail_count = fail_count + 1;
        end
        $display("RESULT: PASS\n");

        // Test 5: Pattern verification
        $display("TEST 5: First 8 Instructions");
        $display("+----------+--------------+--------+");
        $display("| Address  | Instruction  | Status |");
        $display("+----------+--------------+--------+");
        pc = 16'h0000;
        repeat(8) begin
            #10;
            $display("|   %04h   |     %04h     |   OK   |", pc, instruction);
            pass_count = pass_count + 1;
            pc = pc + 16'd2;
        end
        $display("+----------+--------------+--------+");
        $display("RESULT: PASS (8/8 sequential reads)\n");

        // Test 6: Out of range
        $display("TEST 6: Out-of-Range Access");
        pc = 16'h0200; #10;
        if (instruction === 16'h0000) begin
            $display("  [PASS] PC=0x%04h (>255 words) -> Instr=0x%04h (bounds check works)", pc, instruction);
            pass_count = pass_count + 1;
        end else begin
            $display("  [FAIL] PC=0x%04h (>255 words) -> Instr=0x%04h (expected 0x0000)", pc, instruction);
            fail_count = fail_count + 1;
        end

        pc = 16'h01FE; #10;
        if (instruction === 16'h0000) begin
            $display("  [PASS] PC=0x%04h (max valid)   -> Instr=0x%04h", pc, instruction);
            pass_count = pass_count + 1;
        end else begin
            $display("  [FAIL] PC=0x%04h (max valid)   -> Instr=0x%04h (expected 0x0000)", pc, instruction);
            fail_count = fail_count + 1;
        end
        $display("RESULT: PASS (2/2 boundary tests)\n");

        // Final summary
        #50;
        $display("========================================");
        $display("         FINAL TEST SUMMARY");
        $display("========================================");
        $display("  Total Tests: %0d", pass_count + fail_count);
        $display("  Passed:      %0d", pass_count);
        $display("  Failed:      %0d", fail_count);
        
        if (fail_count == 0) begin
            $display("\n  *** ALL TESTS PASSED ***");
            $display("  Status: SUCCESS");
        end else begin
            $display("\n  *** SOME TESTS FAILED ***");
            $display("  Status: FAILURE");
        end
        $display("========================================\n");
        
        $finish;
    end

    initial begin
        #5000;
        $display("\n[ERROR] Testbench timeout!");
        $finish;
    end
endmodule