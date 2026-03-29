// `timescale 1ns/1ps
// module Instruction_memory_tb;
// reg clk;
// reg [15:0] pc;
// wire [15:0] instruction;
// integer pass_count, fail_count;

// // DUT with MEMFILE override (expects src/program16.mem to exist)
// Instruction_memory #(
// .IMEM_WORDS(256),
// .MEMFILE("src/program16.mem")
// ) dut (
// .clk(clk),
// .pc(pc),
// .instruction(instruction)
// );

// // 100 MHz clock
// initial begin
// clk = 0;
// forever #5 clk = ~clk;
// end

// initial begin
// $dumpfile("tb/waveform/rtl.vcd");
// $dumpvars(0, Instruction_memory_tb);
// pass_count = 0;
// fail_count = 0;

// $display("\n========================================");
// $display(" Instruction Memory RTL Testbench");
// $display("========================================\n");

// // TEST 1: Sequential Memory Read (first 16 words)
// $display("TEST 1: Sequential Memory Read");
// $display("+----------+----------+--------------+--------+");
// $display("| PC (hex) | Word Idx | Instruction | Status |");
// $display("+----------+----------+--------------+--------+");
// pc = 16'h0000;
// repeat(16) begin
// #10;
// $display("| %04h | %04h | %04h | OK |", pc, pc[15:1], instruction);
// pass_count = pass_count + 1;
// pc = pc + 16'd2; // word-aligned
// end
// $display("+----------+----------+--------------+--------+");
// $display("RESULT: PASS (16/16 reads successful)\n");

// // TEST 2: Random Access (index 16 => PC = 0x0020; mem file has 0x0001 at index 16)
// $display("TEST 2: Random Access");
// $display("+----------+----------+--------------+--------+");
// $display("| PC (hex) | Word Idx | Instruction | Status |");
// $display("+----------+----------+--------------+--------+");
// pc = 16'h0020; #10; // index 16
// if (instruction === 16'h0001) begin
// $display("| %04h | %04h | %04h | PASS |", pc, pc[15:1], instruction);
// pass_count = pass_count + 1;
// end else begin
// $display("| %04h | %04h | %04h | FAIL |", pc, pc[15:1], instruction);
// fail_count = fail_count + 1;
// end

// pc = 16'h0050; #10; // index 0x28 -> out of your defined range, expect 0x0000
// if (instruction === 16'h0000) begin
// $display("| %04h | %04h | %04h | PASS |", pc, pc[15:1], instruction);
// pass_count = pass_count + 1;
// end else begin
// $display("| %04h | %04h | %04h | FAIL |", pc, pc[15:1], instruction);
// fail_count = fail_count + 1;
// end

// pc = 16'h00F0; #10; // index 0x78 -> expect 0x0000
// if (instruction === 16'h0000) begin
// $display("| %04h | %04h | %04h | PASS |", pc, pc[15:1], instruction);
// pass_count = pass_count + 1;
// end else begin
// $display("| %04h | %04h | %04h | FAIL |", pc, pc[15:1], instruction);
// fail_count = fail_count + 1;
// end
// $display("+----------+----------+--------------+--------+");
// $display("RESULT: PASS (3/3 random accesses)\n");

// // TEST 3: Boundary conditions
// $display("TEST 3: Boundary Conditions");
// pc = 16'h0000; #10;
// if (instruction === 16'h1234) begin
// $display(" [PASS] First location: PC=0x%04h -> Instr=0x%04h", pc, instruction);
// pass_count = pass_count + 1;
// end else begin
// $display(" [FAIL] First location: PC=0x%04h -> Instr=0x%04h (expected 0x1234)", pc, instruction);
// fail_count = fail_count + 1;
// end

// pc = 16'h01FE; #10;
// if (instruction === 16'h0000) begin
// $display(" [PASS] Last location: PC=0x%04h -> Instr=0x%04h", pc, instruction);
// pass_count = pass_count + 1;
// end else begin
// $display(" [FAIL] Last location: PC=0x%04h -> Instr=0x%04h (expected 0x0000)", pc, instruction);
// fail_count = fail_count + 1;
// end
// $display("RESULT: PASS (2/2 boundary checks)\n");

// // Final summary
// #50;
// $display("========================================");
// $display(" FINAL TEST SUMMARY");
// $display("========================================");
// $display(" Total Tests: %0d", pass_count + fail_count);
// $display(" Passed: %0d", pass_count);
// $display(" Failed: %0d", fail_count);
// $display("========================================\n");
// $finish;
// end

// // Safety timeout
// initial begin
// #5000;
// $display("\n[ERROR] Testbench timeout!");
// $finish;
// end
// endmodule

`timescale 1ns/1ps
module Instruction_memory_tb;
    // ── DUT ports ─────────────────────────────────────────────────────
    reg         clk;
    reg  [15:0] pc;
    wire [15:0] instruction;
    reg         load_mode;
    reg         load_transfer;
    reg  [5:0]  load_ui;
    reg  [7:0]  load_uio;
    wire        load_ack;
    
    integer pass_count;
    integer fail_count;
    
    Instruction_memory #(
        .IMEM_WORDS(256)
    ) DUT (
        .clk          (clk),
        .pc           (pc),
        .instruction  (instruction),
        .load_mode    (load_mode),
        .load_transfer(load_transfer),
        .load_ui      (load_ui),
        .load_uio     (load_uio),
        .load_ack     (load_ack)
    );
    
    initial clk = 0;
    always #5 clk = ~clk;
    
    task check;
        input [15:0] actual;
        input [15:0] expected;
        input [127:0] test_name;
        begin
            if (actual === expected) begin
                $display("   PASS | %-35s | got 0x%04h", test_name, actual);
                pass_count = pass_count + 1;
            end else begin
                $display("   FAIL | %-35s | expected 0x%04h got 0x%04h",
                         test_name, expected, actual);
                fail_count = fail_count + 1;
            end
        end
    endtask
    
    task check_bit;
        input actual;
        input expected;
        input [127:0] test_name;
        begin
            if (actual === expected) begin
                $display("   PASS | %-35s | got %0b", test_name, actual);
                pass_count = pass_count + 1;
            end else begin
                $display("   FAIL | %-35s | expected %0b got %0b",
                         test_name, expected, actual);
                fail_count = fail_count + 1;
            end
        end
    endtask
    
    task load_instruction;
        input [15:0] instr;
        begin
            load_mode     = 1;
            load_transfer = 0;
            load_ui       = instr[5:0];
            load_uio      = instr[13:6];
            @(posedge clk); #1;
            
            load_transfer = 1;
            load_ui[5:4]  = instr[15:14];
            load_ui[3:0]  = 4'b0000;
            load_uio      = 8'h00;
            @(posedge clk); #1;
            
            wait(load_ack == 1);
            #1;
            check_bit(load_ack, 1, "load_ack pulsed after write");
            
            @(posedge clk); #1;
            repeat(1) @(posedge clk);
        end
    endtask
    
    reg [15:0] test_instrs [0:4];
    
    initial begin
        $dumpfile("./tb/waveform/Instruction_memory.vcd");
        $dumpvars(0, Instruction_memory_tb);
        
        pass_count    = 0;
        fail_count    = 0;
        pc            = 16'h0000;
        load_mode     = 0;
        load_transfer = 0;
        load_ui       = 6'h00;
        load_uio      = 8'h00;
        
        test_instrs[0] = 16'h0000;
        test_instrs[1] = 16'h0055;
        test_instrs[2] = 16'h00AA;
        test_instrs[3] = 16'h0123;
        test_instrs[4] = 16'h1234;
        
        $display("\n═══════════════════════════════════════════════");
        $display("TEST 1: RAM initialised to zero");
        $display("═══════════════════════════════════════════════");
        begin : zero_check
            integer addr;
            for (addr = 0; addr < 8; addr = addr + 1) begin
                pc = addr * 2;
                #2;
                check(instruction, 16'h0000, "RAM init = 0x0000");
            end
        end
        
        $display("\n═══════════════════════════════════════════════");
        $display("TEST 2: FSM stays IDLE without load_mode");
        $display("═══════════════════════════════════════════════");
        load_mode = 0;
        repeat(5) @(posedge clk);
        #1;
        check_bit(load_ack, 0, "load_ack stays low in IDLE");
        check(DUT.state, 3'd0, "FSM stays in IDLE state");
        
        $display("\n═══════════════════════════════════════════════");
        $display("TEST 3: Load single instruction at address 0");
        $display("═══════════════════════════════════════════════");
        load_mode = 0;
        repeat(3) @(posedge clk);
        
        load_instruction(16'b1001000110100011);
        pc = 16'h0000; #2;
        check(instruction, 16'b1001000110100011, "instr at addr 0 correct");
        
        $display("\n═══════════════════════════════════════════════");
        $display("TEST 4: Load instruction at address 1");
        $display("═══════════════════════════════════════════════");
        load_instruction(16'b1111111000000101);
        pc = 16'd2; #2;
        check(instruction, 16'b1111111000000101, "instr at addr 1 correct");
        
        $display("\n═══════════════════════════════════════════════");
        $display("TEST 5: Load 5 instructions back to back");
        $display("═══════════════════════════════════════════════");
        load_mode = 0;
        repeat(3) @(posedge clk);
        
        begin : multi_load
            integer idx;
            for (idx = 0; idx < 5; idx = idx + 1)
                load_instruction(test_instrs[idx]);
            
            for (idx = 0; idx < 5; idx = idx + 1) begin
                pc = idx * 2; #2;
                check(instruction, test_instrs[idx], "sequential instr correct");
            end
        end
        
        $display("\n═══════════════════════════════════════════════");
        $display("TEST 6: load_mode drops mid-transfer");
        $display("═══════════════════════════════════════════════");
        load_mode     = 0;
        load_transfer = 0;
        @(posedge clk); #1;
        
        load_mode     = 1;
        load_transfer = 0;
        load_ui       = 6'h3F;
        load_uio      = 8'hAA;
        @(posedge clk); #1;
        
        load_mode = 0;
        repeat(3) @(posedge clk); #1;
        
        check(DUT.state, 3'd0, "FSM reset to IDLE after load_mode drop");
        check_bit(load_ack, 0, "load_ack low after abort");
        
        pc = 16'd10; #2;
        check(instruction, 16'h0000, "incomplete write not committed");
        
        $display("\n═══════════════════════════════════════════════");
        $display("TEST 7: ACK pulses for exactly one cycle");
        $display("═══════════════════════════════════════════════");

        load_mode = 0;
        repeat(3) @(posedge clk);

        load_mode     = 1;
        load_transfer = 0;
        load_ui       = 6'h01;
        load_uio      = 8'h02;
        @(posedge clk);

        load_transfer = 1;
        load_ui[5:4]  = 2'b11;
        load_ui[3:0]  = 4'b0000;
        load_uio      = 8'h00;
        @(posedge clk);

        // Check ACK low before pulse
        #1;
        check_bit(load_ack, 0, "ACK low before pulse");

        // Wait 3 cycles: GOT_T2 → WRITE → ACK
        @(posedge clk);  // GOT_T2 → WRITE
        @(posedge clk);  // WRITE → ACK
        @(posedge clk);  // Now in ACK state
        #1;
        check_bit(load_ack, 1, "ACK high during ACK state");

        // Check it drops
        @(posedge clk);  // ACK → IDLE
        #1;
        check_bit(load_ack, 0, "ACK low after ACK state");

        // ══════════════════════════════════════════════════════════════
        // RELOAD DATA for TEST 8 (since TEST 7 overwrote address 0)
        // ══════════════════════════════════════════════════════════════
        load_mode = 0;
        repeat(3) @(posedge clk);

        begin : reload_test5
            integer idx;
            for (idx = 0; idx < 5; idx = idx + 1)
                load_instruction(test_instrs[idx]);
        end

        $display("\n═══════════════════════════════════════════════");
        $display("TEST 8: RUN mode reads loaded instructions");
        $display("═══════════════════════════════════════════════");
        load_mode = 0;
        repeat(3) @(posedge clk);

        begin : run_check
            integer idx;
            for (idx = 0; idx < 5; idx = idx + 1) begin
                pc = idx * 2; #2;
                check(instruction, test_instrs[idx], "RUN mode reads correct instr");
            end
        end
        
        $display("\n═══════════════════════════════════════════════");
        $display("TEST 9: Address counter reset");
        $display("═══════════════════════════════════════════════");
        load_instruction(16'hCAFE);
        
        load_mode = 0;
        pc = 16'h0000; #2;
        check(instruction, 16'hCAFE, "addr 0 overwritten after reset");
        
        $display("\n═══════════════════════════════════════════════");
        $display("FINAL REPORT");
        $display("═══════════════════════════════════════════════");
        $display("  Total PASS: %0d", pass_count);
        $display("  Total FAIL: %0d", fail_count);
        if (fail_count == 0)
            $display("  ✅ ALL TESTS PASSED");
        else
            $display("  ❌ %0d TEST(S) FAILED", fail_count);
        $display("═══════════════════════════════════════════════\n");
        
        $finish;
    end
endmodule
