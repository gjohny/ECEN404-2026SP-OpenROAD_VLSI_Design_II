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
    reg  [6:0]  load_data;
    reg         load_hibyte;
    reg  [6:0]  load_addr;
    wire        load_ack;

    // ── pass/fail tracking ────────────────────────────────────────────
    integer pass_count;
    integer fail_count;

    // ── instantiate DUT ───────────────────────────────────────────────
    Instruction_memory #(
        .IMEM_WORDS(256)
    ) DUT (
        .clk        (clk),
        .pc         (pc),
        .instruction(instruction),
        .load_mode  (load_mode),
        .load_data  (load_data),
        .load_hibyte(load_hibyte),
        .load_addr  (load_addr),
        .load_ack   (load_ack)
    );

    // ── clock ─────────────────────────────────────────────────────────
    initial clk = 0;
    always #5 clk = ~clk;

    // ── check tasks ───────────────────────────────────────────────────
    task check;
        input [15:0] actual;
        input [15:0] expected;
        input [127:0] test_name;
        begin
            if (actual === expected) begin
                $display("  ✅ PASS | %-35s | got 0x%04h", test_name, actual);
                pass_count = pass_count + 1;
            end else begin
                $display("  ❌ FAIL | %-35s | expected 0x%04h got 0x%04h",
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
                $display("  ✅ PASS | %-35s | got %0b", test_name, actual);
                pass_count = pass_count + 1;
            end else begin
                $display("  ❌ FAIL | %-35s | expected %0b got %0b",
                         test_name, expected, actual);
                fail_count = fail_count + 1;
            end
        end
    endtask

    // ── load one full 16-bit instruction ──────────────────────────────
    task load_instruction;
        input [6:0]  addr;
        input [13:0] instr;
        begin
            // reset to clean state first
            load_mode   = 0;
            load_hibyte = 0;
            load_data   = 7'h00;
            @(posedge clk); #1;

            // send low byte
            load_mode   = 1;
            load_hibyte = 0;
            load_addr   = addr;
            load_data   = instr[6:0];
            @(posedge clk); #1;

            // send high byte
            load_hibyte = 1;
            load_addr   = addr;
            load_data   = instr[13:7];
            @(posedge clk); #1; // RECV_LO → WRITE
            @(posedge clk); #1; // WRITE   → ACK
            @(posedge clk); #1; // now in ACK state

            check_bit(load_ack, 1, "load_ack pulsed after write");

            @(posedge clk); #1; // ACK → IDLE
        end
    endtask

    // ── known test instructions ───────────────────────────────────────
    reg [13:0] test_instrs [0:4];

    // ══════════════════════════════════════════════════════════════════
    // MAIN TEST
    // ══════════════════════════════════════════════════════════════════
    initial begin
        $dumpfile("./tb/waveform/Instruction_memory.vcd");
        $dumpvars(0, Instruction_memory_tb);

        pass_count  = 0;
        fail_count  = 0;
        pc          = 16'h0000;
        load_mode   = 0;
        load_data   = 7'h00;
        load_hibyte = 0;
        load_addr   = 7'h00;

        // known hardcoded values — no arithmetic ambiguity
        test_instrs[0] = 14'h0000;
        test_instrs[1] = 14'h0055;
        test_instrs[2] = 14'h00AA;
        test_instrs[3] = 14'h0123;
        test_instrs[4] = 14'h1234;

        // ══════════════════════════════════════════════════════════════
        // TEST 1: RAM initialised to zero
        // ══════════════════════════════════════════════════════════════
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

        // ══════════════════════════════════════════════════════════════
        // TEST 2: FSM stays IDLE without load_mode
        // ══════════════════════════════════════════════════════════════
        $display("\n═══════════════════════════════════════════════");
        $display("TEST 2: FSM stays IDLE without load_mode");
        $display("═══════════════════════════════════════════════");

        load_mode = 0;
        repeat(5) @(posedge clk);
        #1;
        check_bit(load_ack, 0, "load_ack stays low in IDLE");
        check(DUT.state, 3'd0, "FSM stays in IDLE state");

        // ══════════════════════════════════════════════════════════════
        // TEST 3: Load single instruction at address 0
        // ══════════════════════════════════════════════════════════════
        $display("\n═══════════════════════════════════════════════");
        $display("TEST 3: Load single instruction at address 0");
        $display("═══════════════════════════════════════════════");

        load_instruction(7'd0, 14'b10010001101000);
        pc = 16'h0000; #2;
        check(instruction, {7'b1001000, 7'b1101000}, "instr at addr 0 correct");

        // ══════════════════════════════════════════════════════════════
        // TEST 4: Load instruction at address 5
        // ══════════════════════════════════════════════════════════════
        $display("\n═══════════════════════════════════════════════");
        $display("TEST 4: Load instruction at address 5");
        $display("═══════════════════════════════════════════════");

        load_instruction(7'd5, 14'b11111110000001);
        pc = 16'd10; #2;
        check(instruction, {7'b1111111, 7'b0000001}, "instr at addr 5 correct");

        // ══════════════════════════════════════════════════════════════
        // TEST 5: Load 5 instructions back to back
        // ══════════════════════════════════════════════════════════════
        $display("\n═══════════════════════════════════════════════");
        $display("TEST 5: Load 5 instructions back to back");
        $display("═══════════════════════════════════════════════");

        begin : multi_load
            integer idx;
            for (idx = 0; idx < 5; idx = idx + 1)
                load_instruction(idx, test_instrs[idx]);

            for (idx = 0; idx < 5; idx = idx + 1) begin
                pc = idx * 2; #2;
                check(instruction,
                      {test_instrs[idx][13:7], test_instrs[idx][6:0]},
                      "sequential instr correct");
            end
        end

        // ══════════════════════════════════════════════════════════════
        // TEST 6: load_mode drops mid-transfer
        // ══════════════════════════════════════════════════════════════
        $display("\n═══════════════════════════════════════════════");
        $display("TEST 6: load_mode drops mid-transfer");
        $display("═══════════════════════════════════════════════");

        load_mode   = 0;
        load_hibyte = 0;
        @(posedge clk); #1;

        load_mode   = 1;
        load_hibyte = 0;
        load_addr   = 7'd10;
        load_data   = 7'h55;
        @(posedge clk); #1;

        // drop load_mode before sending high byte
        load_mode = 0;
        @(posedge clk); #1;

        check(DUT.state, 3'd0, "FSM reset to IDLE after load_mode drop");
        check_bit(load_ack, 0, "load_ack low after abort");
        pc = 16'd20; #2;
        check(instruction, 16'h0000, "incomplete write not committed");

        // ══════════════════════════════════════════════════════════════
        // TEST 7: ACK pulses for exactly one cycle
        // ══════════════════════════════════════════════════════════════
        $display("\n═══════════════════════════════════════════════");
        $display("TEST 7: ACK pulses for exactly one cycle");
        $display("═══════════════════════════════════════════════");

        load_mode   = 0;
        load_hibyte = 0;
        @(posedge clk); #1;

        load_mode   = 1;
        load_hibyte = 0;
        load_addr   = 7'd20;
        load_data   = 7'h01;
        @(posedge clk); #1;

        load_hibyte = 1;
        load_data   = 7'h02;
        @(posedge clk); #1; // RECV_LO → WRITE
        @(posedge clk); #1; // WRITE   → ACK
        @(posedge clk); #1; // now in ACK state

        check_bit(load_ack, 1, "ACK high on ACK cycle");

        @(posedge clk); #1; // ACK → IDLE
        check_bit(load_ack, 0, "ACK low after ACK cycle");

        // ══════════════════════════════════════════════════════════════
        // TEST 8: RUN mode reads loaded instructions
        // ══════════════════════════════════════════════════════════════
        $display("\n═══════════════════════════════════════════════");
        $display("TEST 8: RUN mode reads loaded instructions");
        $display("═══════════════════════════════════════════════");

        load_mode = 0;

        begin : run_check
            integer idx;
            for (idx = 0; idx < 5; idx = idx + 1) begin
                pc = idx * 2; #2;
                check(instruction,
                      {test_instrs[idx][13:7], test_instrs[idx][6:0]},
                      "RUN mode reads correct instr");
            end
        end

        // ══════════════════════════════════════════════════════════════
        // FINAL REPORT
        // ══════════════════════════════════════════════════════════════
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