`timescale 1ns/1ps
module Instruction_memory_tb;

    // ── DUT ports ──────────────────────────────────────────────────────
    reg         clk;
    reg  [15:0] pc;
    wire [15:0] instruction;
    reg         load_mode;
    reg  [6:0]  load_data;
    reg         load_hibyte;
    reg  [6:0]  load_addr;
    wire        load_ack;

    // ── pass/fail tracking ─────────────────────────────────────────────
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

    // ── clock gen ─────────────────────────────────────────────────────
    initial clk = 0;
    always #5 clk = ~clk;

    // ── check task ────────────────────────────────────────────────────
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

    // ── load one full 16-bit instruction task ─────────────────────────
    // sends low byte first then high byte
    task load_instruction;
        input [6:0]  addr;
        input [13:0] instr; // 14 bits total (7 lo + 7 hi)
        begin
            // send low byte
            load_mode    = 1;
            load_hibyte  = 0;
            load_addr    = addr;
            load_data    = instr[6:0];
            @(posedge clk); #1;

            // wait for FSM to move to RECV_LO
            // send high byte
            load_hibyte  = 1;
            load_addr    = addr;
            load_data    = instr[13:7];
            @(posedge clk); #1;

            // wait for WRITE then ACK
            @(posedge clk); #1; // WRITE state
            @(posedge clk); #1; // ACK state - ack pulses here

            // confirm ack pulsed
            check_bit(load_ack, 1, "load_ack pulsed after write");

            @(posedge clk); #1; // back to IDLE
        end
    endtask

    // ══════════════════════════════════════════════════════════════════
    // MAIN TEST
    // ══════════════════════════════════════════════════════════════════
    initial begin
        $dumpfile("./tb/waveform/Instruction_memory.vcd");
        $dumpvars(0, Instruction_memory_tb);

        pass_count = 0;
        fail_count = 0;

        // initialise
        pc          = 16'h0000;
        load_mode   = 0;
        load_data   = 7'h00;
        load_hibyte = 0;
        load_addr   = 7'h00;

        // ══════════════════════════════════════════════════════════════
        // TEST 1: RAM initialised to zero
        // ══════════════════════════════════════════════════════════════
        $display("\n═══════════════════════════════════════════════");
        $display("TEST 1: RAM initialised to zero");
        $display("═══════════════════════════════════════════════");

        begin : zero_check
            integer addr;
            for (addr = 0; addr < 8; addr = addr + 1) begin
                pc = addr * 2; // word aligned
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
        check(DUT.state, 3'd0,  "FSM stays in IDLE state");

        // ══════════════════════════════════════════════════════════════
        // TEST 3: Load single instruction at address 0
        // ══════════════════════════════════════════════════════════════
        $display("\n═══════════════════════════════════════════════");
        $display("TEST 3: Load single instruction at address 0");
        $display("═══════════════════════════════════════════════");

        // load 0x1234 at address 0
        // 0x1234 = 14'b10010001101 00 → split into hi=7'b0100100, lo=7'b0110100
        load_instruction(7'd0, 14'b10010001101000);

        // read it back via PC
        pc = 16'h0000; #2;
        check(instruction, {7'b1001000, 7'b1101000}, "instr at addr 0 correct");

        // ══════════════════════════════════════════════════════════════
        // TEST 4: Load instruction at different address
        // ══════════════════════════════════════════════════════════════
        $display("\n═══════════════════════════════════════════════");
        $display("TEST 4: Load instruction at address 5");
        $display("═══════════════════════════════════════════════");

        load_instruction(7'd5, 14'b11111110000001);

        pc = 16'd10; #2; // address 5 = PC 10 (word aligned)
        check(instruction, {7'b1111111, 7'b0000001}, "instr at addr 5 correct");

        // ══════════════════════════════════════════════════════════════
        // TEST 5: Load multiple instructions back to back
        // ══════════════════════════════════════════════════════════════
        $display("\n═══════════════════════════════════════════════");
        $display("TEST 5: Load 5 instructions back to back");
        $display("═══════════════════════════════════════════════");

        begin : multi_load
            integer idx;
            reg [13:0] test_instr;
            for (idx = 0; idx < 5; idx = idx + 1) begin
                test_instr = idx * 14'h0101; // unique value per address
                load_instruction(idx, test_instr);
            end

            // verify all 5
            for (idx = 0; idx < 5; idx = idx + 1) begin
                pc = idx * 2;
                #2;
                check(instruction, idx * 14'h0101, "sequential instr correct");
            end
        end

        // ══════════════════════════════════════════════════════════════
        // TEST 6: load_mode drops mid transfer — FSM resets
        // ══════════════════════════════════════════════════════════════
        $display("\n═══════════════════════════════════════════════");
        $display("TEST 6: load_mode drops mid-transfer");
        $display("═══════════════════════════════════════════════");

        // start a transfer
        load_mode   = 1;
        load_hibyte = 0;
        load_addr   = 7'd10;
        load_data   = 7'h55;
        @(posedge clk); #1;

        // drop load_mode before sending high byte
        load_mode = 0;
        @(posedge clk); #1;

        // FSM should be back in IDLE
        check(DUT.state, 3'd0, "FSM reset to IDLE after load_mode drop");
        check_bit(load_ack, 0, "load_ack low after abort");

        // address 10 should still be 0x0000 — nothing was written
        pc = 16'd20; #2;
        check(instruction, 16'h0000, "incomplete write not committed");

        // ══════════════════════════════════════════════════════════════
        // TEST 7: ACK pulses for exactly one cycle
        // ══════════════════════════════════════════════════════════════
        $display("\n═══════════════════════════════════════════════");
        $display("TEST 7: ACK pulses for exactly one cycle");
        $display("═══════════════════════════════════════════════");

        load_mode   = 1;
        load_hibyte = 0;
        load_addr   = 7'd20;
        load_data   = 7'h01;
        @(posedge clk); #1;

        load_hibyte = 1;
        load_data   = 7'h02;
        @(posedge clk); #1; // RECV_LO → WRITE
        @(posedge clk); #1; // WRITE   → ACK

        check_bit(load_ack, 1, "ACK high on ACK cycle");

        @(posedge clk); #1; // ACK → IDLE
        check_bit(load_ack, 0, "ACK low after ACK cycle");

        // ══════════════════════════════════════════════════════════════
        // TEST 8: RUN mode — loaded program reads correctly via PC
        // ══════════════════════════════════════════════════════════════
        $display("\n═══════════════════════════════════════════════");
        $display("TEST 8: RUN mode reads loaded instructions");
        $display("═══════════════════════════════════════════════");

        // switch to RUN mode
        load_mode = 0;

        // walk through addresses and confirm values loaded in TEST 5
        begin : run_check
            integer idx;
            for (idx = 0; idx < 5; idx = idx + 1) begin
                pc = idx * 2;
                #2;
                check(instruction, idx * 14'h0101, "RUN mode reads correct instr");
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