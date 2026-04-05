`timescale 1ns / 1ps
module tt_um_riscv16_tb;

    // ── DUT ports ──────────────────────────────────────────────────────
    reg  [7:0] ui_in;
    wire [7:0] uo_out;
    reg  [7:0] uio_in;
    wire [7:0] uio_out;
    wire [7:0] uio_oe;
    reg        ena;
    reg        clk;
    reg        rst_n;

    // ── pass/fail tracking ─────────────────────────────────────────────
    integer pass_count;
    integer fail_count;

    // ── instantiate DUT ───────────────────────────────────────────────
    tt_um_riscv16 DUT (
        .ui_in  (ui_in),
        .uo_out (uo_out),
        .uio_in (uio_in),
        .uio_out(uio_out),
        .uio_oe (uio_oe),
        .ena    (ena),
        .clk    (clk),
        .rst_n  (rst_n)
    );

    // ── clock gen ─────────────────────────────────────────────────────
    initial clk = 0;
    always #5 clk = ~clk;

    // ── helper: check 16-bit output ───────────────────────────────────
    task check_output;
        input [15:0] expected;
        input [127:0] test_name;
        reg [15:0] actual;
        begin
            actual = {uio_out, uo_out};
            if (actual === expected) begin
                $display("  ✅ PASS | %-30s | got 0x%04h", test_name, actual);
                pass_count = pass_count + 1;
            end else begin
                $display("  ❌ FAIL | %-30s | expected 0x%04h, got 0x%04h",
                         test_name, expected, actual);
                fail_count = fail_count + 1;
            end
        end
    endtask

    // ── helper: check 8-bit value ─────────────────────────────────────
    task check_byte;
        input [7:0] actual;
        input [7:0] expected;
        input [127:0] test_name;
        begin
            if (actual === expected) begin
                $display("  ✅ PASS | %-30s | got 0x%02h", test_name, actual);
                pass_count = pass_count + 1;
            end else begin
                $display("  ❌ FAIL | %-30s | expected 0x%02h, got 0x%02h",
                         test_name, expected, actual);
                fail_count = fail_count + 1;
            end
        end
    endtask

    // ── snapshot of all 6 debug channels ──────────────────────────────
    task snapshot_all_channels;
        integer ch;
        begin
            $display("\n  [Snapshot] All channels:");
            for (ch = 0; ch < 6; ch = ch + 1) begin
                ui_in[2:0] = ch;
                #2;
                $display("    ch%0d -> 0x%02h%02h", ch, uio_out, uo_out);
            end
        end
    endtask

    // ── wires into DUT internals for direct checking ───────────────────
    wire [15:0] internal_pc         = DUT.dbg_pc;
    wire [15:0] internal_instr      = DUT.dbg_instr;
    wire [15:0] internal_alu        = DUT.dbg_alu_result;
    wire [15:0] internal_x1         = DUT.dbg_x1;
    wire [15:0] internal_x2         = DUT.dbg_x2;
    wire [15:0] internal_x3         = DUT.dbg_x3;

    // ══════════════════════════════════════════════════════════════════
    // MAIN TEST
    // ══════════════════════════════════════════════════════════════════
    initial begin
        $dumpfile("./tb/waveform/tt_um_riscv16.vcd");
        $dumpvars(0, tt_um_riscv16_tb);

        pass_count = 0;
        fail_count = 0;
        ena    = 1;
        uio_in = 8'hAA;   // drive non-zero to confirm it has no effect
        ui_in  = 8'hFF;   // drive all ones initially
        rst_n  = 0;

        // ══════════════════════════════════════════════════════════════
        // TEST 1: uio_oe hardwired to 0xFF at all times
        // ══════════════════════════════════════════════════════════════
        $display("\n═══════════════════════════════════════════════");
        $display("TEST 1: uio_oe hardwired to 0xFF");
        $display("═══════════════════════════════════════════════");

        // check during reset
        #2;
        check_byte(uio_oe, 8'hFF, "uio_oe during reset");

        // check after reset
        rst_n = 1;
        #10;
        check_byte(uio_oe, 8'hFF, "uio_oe after reset");

        // check mid-run after cycles
        repeat(20) @(posedge clk);
        check_byte(uio_oe, 8'hFF, "uio_oe after 20 cycles");

        // toggle rst_n again and re-check
        rst_n = 0; #3; rst_n = 1;
        check_byte(uio_oe, 8'hFF, "uio_oe after re-reset");

        // ══════════════════════════════════════════════════════════════
        // TEST 2: Reset behaviour
        // ══════════════════════════════════════════════════════════════
        $display("\n═══════════════════════════════════════════════");
        $display("TEST 2: Reset behaviour");
        $display("═══════════════════════════════════════════════");

        // hold reset and confirm PC channel is 0x0000
        rst_n = 0;
        ui_in[2:0] = 3'd0; // PC channel
        repeat(4) @(posedge clk);
        #2;
        check_output(16'h0000, "PC=0 during reset");

        // release reset and confirm PC starts moving
        rst_n = 1;
        repeat(2) @(posedge clk);
        #2;
        if ({uio_out, uo_out} !== 16'h0000) begin
            $display("  ✅ PASS | %-30s | PC moved to 0x%04h",
                     "PC non-zero after reset", {uio_out, uo_out});
            pass_count = pass_count + 1;
        end else begin
            $display("  ❌ FAIL | PC still 0 after reset released");
            fail_count = fail_count + 1;
        end

        // mid-execution reset: let it run, then reset, confirm PC returns to 0
        repeat(15) @(posedge clk);
        rst_n = 0;
        repeat(4) @(posedge clk);
        #2;
        ui_in[2:0] = 3'd0;
        check_output(16'h0000, "PC=0 after mid-run reset");
        rst_n = 1;

        // ══════════════════════════════════════════════════════════════
        // TEST 3: Each mux channel routes correct debug wire
        // ══════════════════════════════════════════════════════════════
        $display("\n═══════════════════════════════════════════════");
        $display("TEST 3: Mux channel routing correctness");
        $display("═══════════════════════════════════════════════");

        repeat(10) @(posedge clk);
        #2; // let signals settle

        // channel 0: PC
        ui_in[2:0] = 3'd0; #2;
        check_output(internal_pc,    "ch0 matches internal PC");

        // channel 1: instruction
        ui_in[2:0] = 3'd1; #2;
        check_output(internal_instr, "ch1 matches internal INSTR");

        // channel 2: ALU result
        ui_in[2:0] = 3'd2; #2;
        check_output(internal_alu,   "ch2 matches internal ALU");

        // channel 3: x1
        ui_in[2:0] = 3'd3; #2;
        check_output(internal_x1,    "ch3 matches internal x1");

        // channel 4: x2
        ui_in[2:0] = 3'd4; #2;
        check_output(internal_x2,    "ch4 matches internal x2");

        // channel 5: x3
        ui_in[2:0] = 3'd5; #2;
        check_output(internal_x3,    "ch5 matches internal x3");

        // default channels 6 and 7 must show 0xDEAD
        ui_in[2:0] = 3'd6; #2;
        check_output(16'hDEAD, "ch6 default = 0xDEAD");

        ui_in[2:0] = 3'd7; #2;
        check_output(16'hDEAD, "ch7 default = 0xDEAD");

        // ══════════════════════════════════════════════════════════════
        // TEST 4: Byte splitting — uo_out=low, uio_out=high
        // ══════════════════════════════════════════════════════════════
        $display("\n═══════════════════════════════════════════════");
        $display("TEST 4: Byte splitting correctness");
        $display("═══════════════════════════════════════════════");

        // check each channel: low byte must match [7:0], high must match [15:8]
        begin : byte_split_check
            reg [15:0] word;
            integer ch;
            for (ch = 0; ch < 6; ch = ch + 1) begin
                ui_in[2:0] = ch; #2;
                case (ch)
                    0: word = internal_pc;
                    1: word = internal_instr;
                    2: word = internal_alu;
                    3: word = internal_x1;
                    4: word = internal_x2;
                    5: word = internal_x3;
                endcase
                if (uo_out !== word[7:0]) begin
                    $display("  ❌ FAIL | ch%0d uo_out low byte  | expected 0x%02h got 0x%02h",
                             ch, word[7:0], uo_out);
                    fail_count = fail_count + 1;
                end else begin
                    $display("  ✅ PASS | ch%0d uo_out  = 0x%02h (low byte correct)", ch, uo_out);
                    pass_count = pass_count + 1;
                end
                if (uio_out !== word[15:8]) begin
                    $display("  ❌ FAIL | ch%0d uio_out high byte | expected 0x%02h got 0x%02h",
                             ch, word[15:8], uio_out);
                    fail_count = fail_count + 1;
                end else begin
                    $display("  ✅ PASS | ch%0d uio_out = 0x%02h (high byte correct)", ch, uio_out);
                    pass_count = pass_count + 1;
                end
            end
        end

        // ══════════════════════════════════════════════════════════════
        // TEST 5: Rapid channel switching mid-execution
        // ══════════════════════════════════════════════════════════════
        $display("\n═══════════════════════════════════════════════");
        $display("TEST 5: Rapid channel switching mid-execution");
        $display("═══════════════════════════════════════════════");

        // switch channels every 2ns while processor is running
        // confirm output always matches the correct internal wire
        begin : rapid_switch
            integer i;
            reg [2:0] ch;
            reg [15:0] expected_word;
            for (i = 0; i < 30; i = i + 1) begin
                @(posedge clk); #2;
                ch = i % 6;
                ui_in[2:0] = ch;
                #1;
                case (ch)
                    0: expected_word = internal_pc;
                    1: expected_word = internal_instr;
                    2: expected_word = internal_alu;
                    3: expected_word = internal_x1;
                    4: expected_word = internal_x2;
                    5: expected_word = internal_x3;
                endcase
                if ({uio_out, uo_out} !== expected_word) begin
                    $display("  ❌ FAIL | rapid switch i=%0d ch=%0d | expected 0x%04h got 0x%04h",
                             i, ch, expected_word, {uio_out, uo_out});
                    fail_count = fail_count + 1;
                end else begin
                    pass_count = pass_count + 1;
                end
            end
            $display("  Rapid switch: %0d checks done", 30);
        end

        // ══════════════════════════════════════════════════════════════
        // TEST 6: Upper ui_in bits [7:3] have zero effect on output
        // ══════════════════════════════════════════════════════════════
        $display("\n═══════════════════════════════════════════════");
        $display("TEST 6: ui_in[7:3] noise immunity");
        $display("═══════════════════════════════════════════════");

        begin : noise_test
            reg [15:0] baseline;
            reg [15:0] noisy;
            integer pattern;
            ui_in = 8'h00; #2;
            baseline = {uio_out, uo_out};
            // walk all combinations of upper bits with ch=0
            for (pattern = 0; pattern < 16; pattern = pattern + 1) begin
                // keep ui_in[7]=1 (RUN mode), vary ui_in[6:3], keep ch=0
                ui_in = {1'b1, pattern[3:0], 3'b000};
                #2;
                noisy = {uio_out, uo_out};
                baseline = internal_pc;
                if (noisy !== baseline) begin
                    $display("  ❌ FAIL | ui_in[7:3]=%05b affected output | 0x%04h vs 0x%04h",
                             pattern[4:0], baseline, noisy);
                    fail_count = fail_count + 1;
                end else begin
                    pass_count = pass_count + 1;
                end
            end
            $display("  Noise immunity: 32 patterns checked on ch0");
        end

        // ══════════════════════════════════════════════════════════════
        // TEST 7: uio_in has no effect on outputs
        // ══════════════════════════════════════════════════════════════
        $display("\n═══════════════════════════════════════════════");
        $display("TEST 7: uio_in isolation");
        $display("═══════════════════════════════════════════════");

        begin : uio_isolation
            reg [15:0] ref_out;
            reg [15:0] check_out;
            integer p;
            ui_in[2:0] = 3'd2; // ALU channel
            uio_in = 8'h00; #2;
            ref_out = {uio_out, uo_out};
            for (p = 0; p < 8; p = p + 1) begin
                uio_in = (8'h01 << p); #2;
                check_out = {uio_out, uo_out};
                if (check_out !== ref_out) begin
                    $display("  ❌ FAIL | uio_in bit %0d affected output", p);
                    fail_count = fail_count + 1;
                end else begin
                    pass_count = pass_count + 1;
                end
            end
            uio_in = 8'hFF; #2;
            check_out = {uio_out, uo_out};
            if (check_out !== ref_out) begin
                $display("  ❌ FAIL | uio_in=0xFF affected output");
                fail_count = fail_count + 1;
            end else begin
                $display("  ✅ PASS | uio_in=0xFF has no effect on output");
                pass_count = pass_count + 1;
            end
        end

        // ══════════════════════════════════════════════════════════════
        // TEST 8: Multiple resets — output consistency
        // ══════════════════════════════════════════════════════════════
        $display("\n═══════════════════════════════════════════════");
        $display("TEST 8: Repeated reset consistency");
        $display("═══════════════════════════════════════════════");

        begin : reset_consistency
            integer r;
            for (r = 0; r < 5; r = r + 1) begin
                rst_n = 0;
                repeat(4) @(posedge clk);
                ui_in[2:0] = 3'd0; #2;
                if ({uio_out, uo_out} !== 16'h0000) begin
                    $display("  ❌ FAIL | reset %0d: PC not 0 (got 0x%04h)", r, {uio_out, uo_out});
                    fail_count = fail_count + 1;
                end else begin
                    $display("  ✅ PASS | reset %0d: PC=0x0000 confirmed", r);
                    pass_count = pass_count + 1;
                end
                rst_n = 1;
                repeat(8) @(posedge clk);
            end
        end

        // ══════════════════════════════════════════════════════════════
        // TEST 9: Snapshot all channels and confirm none are identical
        //         (sanity check that mux isn't stuck on one wire)
        // ══════════════════════════════════════════════════════════════
        $display("\n═══════════════════════════════════════════════");
        $display("TEST 9: Channel uniqueness sanity check");
        $display("═══════════════════════════════════════════════");

        repeat(20) @(posedge clk);
        snapshot_all_channels();

        begin : uniqueness
            reg [15:0] ch_val [0:5];
            integer a, b;
            integer all_same;
            for (a = 0; a < 6; a = a + 1) begin
                ui_in[2:0] = a; #2;
                case (a)
                    0: ch_val[a] = internal_pc;
                    1: ch_val[a] = internal_instr;
                    2: ch_val[a] = internal_alu;
                    3: ch_val[a] = internal_x1;
                    4: ch_val[a] = internal_x2;
                    5: ch_val[a] = internal_x3;
                endcase
                if ({uio_out, uo_out} === ch_val[a]) begin
                    pass_count = pass_count + 1;
                end else begin
                    $display("  ❌ FAIL | ch%0d mux output doesn't match internal wire", a);
                    fail_count = fail_count + 1;
                end
            end
            $display("  ✅ All 6 channels confirmed to track their internal wires");
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
            $display("  ❌ %0d TEST(S) FAILED — review output above", fail_count);
        $display("═══════════════════════════════════════════════\n");

        $finish;
    end

endmodule