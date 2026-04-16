`timescale 1ns / 1ps
`define STRLEN 32

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

    integer pass_count;
    integer fail_count;

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

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $dumpfile("./tb/waveform/tt_um_riscv16.vcd");
        $dumpvars(0, tt_um_riscv16_tb);
    end

    // ── passTest8 ─────────────────────────────────────────────────────
    task passTest8;
        input [7:0] actual;
        input [7:0] expected;
        input [`STRLEN*8:0] testName;
        begin
            if (actual === expected) begin
                $display("  PASS | %-40s | got 0x%02h", testName, actual);
                pass_count = pass_count + 1;
            end else begin
                $display("  FAIL | %-40s | expected 0x%02h got 0x%02h",
                         testName, expected, actual);
                fail_count = fail_count + 1;
            end
        end
    endtask

    // ── passTest16 ────────────────────────────────────────────────────
    task passTest16;
        input [15:0] actual;
        input [15:0] expected;
        input [`STRLEN*8:0] testName;
        begin
            if (actual === expected) begin
                $display("  PASS | %-40s | got 0x%04h", testName, actual);
                pass_count = pass_count + 1;
            end else begin
                $display("  FAIL | %-40s | expected 0x%04h got 0x%04h",
                         testName, expected, actual);
                fail_count = fail_count + 1;
            end
        end
    endtask

    initial begin
        pass_count = 0;
        fail_count = 0;
        ena        = 1;
        uio_in     = 8'h00;
        ui_in      = 8'b1_1_000000;  // LOAD mode, idle
        rst_n      = 0;

        repeat(4) @(posedge clk);
        rst_n = 1;
        repeat(2) @(posedge clk);

        // ══════════════════════════════════════════════════════════════
        // TEST 1: uio_oe switches based on ui_in[7]
        // This is purely combinational — no clock edge needed
        // ui_in[7]=1 → LOAD mode → uio_oe=0x00 (bidir=inputs)
        // ui_in[7]=0 → RUN  mode → uio_oe=0xFF (bidir=outputs)
        // ══════════════════════════════════════════════════════════════
        $display("\n═══════════════════════════════════════════════");
        $display("TEST 1: uio_oe combinational switching");
        $display("═══════════════════════════════════════════════");

        // LOAD mode
        ui_in = 8'b1_1_000000;
        #2;
        passTest8(uio_oe, 8'h00, "uio_oe=0x00 in LOAD mode");

        // RUN mode — should switch instantly, no clock needed
        ui_in = 8'b0_000_0000;
        #2;
        passTest8(uio_oe, 8'hFF, "uio_oe=0xFF in RUN mode (immediate)");

        // back to LOAD — should switch instantly again
        ui_in = 8'b1_1_000000;
        #2;
        passTest8(uio_oe, 8'h00, "uio_oe=0x00 back in LOAD mode (immediate)");

        // rapid toggling — verify immediate response each time
        ui_in = 8'b0_000_0000; #1;
        passTest8(uio_oe, 8'hFF, "uio_oe immediate after rapid toggle to RUN");
        ui_in = 8'b1_1_000000; #1;
        passTest8(uio_oe, 8'h00, "uio_oe immediate after rapid toggle to LOAD");
        ui_in = 8'b0_000_0000; #1;
        passTest8(uio_oe, 8'hFF, "uio_oe immediate after second rapid toggle");

        // ══════════════════════════════════════════════════════════════
        // TEST 2: LOAD mode output cleanliness
        // During LOAD mode:
        //   uo_out[7:1] must all be 0 — only bit 0 carries ACK
        //   uio_out     must be 0x00  — bidir pins are inputs
        // ══════════════════════════════════════════════════════════════
        $display("\n═══════════════════════════════════════════════");
        $display("TEST 2: LOAD mode output cleanliness");
        $display("═══════════════════════════════════════════════");

        ui_in  = 8'b1_1_000000;
        uio_in = 8'h00;
        repeat(2) @(posedge clk); #1;

        // uo_out[7:1] should all be 0
        if (uo_out[7:1] === 7'b0000000) begin
            $display("  PASS | %-40s | got 0x%02h", "uo_out[7:1]=0 in LOAD mode", uo_out);
            pass_count = pass_count + 1;
        end else begin
            $display("  FAIL | %-40s | uo_out=0x%02h bits[7:1] not zero",
                     "uo_out[7:1]=0 in LOAD mode", uo_out);
            fail_count = fail_count + 1;
        end

        // uio_out should be completely 0
        passTest8(uio_out, 8'h00, "uio_out=0x00 in LOAD mode");

        // walk all T1/T2 combinations and verify output stays clean
        begin : load_output_clean
            integer t;
            for (t = 0; t < 4; t = t + 1) begin
                ui_in = {1'b1, t[1], 6'b000000};  // vary transfer bit
                uio_in = 8'hFF;                    // drive non-zero on bidir
                #2;
                if (uio_out !== 8'h00) begin
                    $display("  FAIL | uio_out not 0 during LOAD transfer=%0b", t[0]);
                    fail_count = fail_count + 1;
                end else begin
                    pass_count = pass_count + 1;
                end
            end
            $display("  PASS | %-40s", "uio_out=0x00 for all LOAD combinations");
        end

        uio_in = 8'h00;

        // ══════════════════════════════════════════════════════════════
        // TEST 3: RUN mode — ACK never leaks through to output
        // In RUN mode uo_out carries debug word low byte
        // ACK should never appear — it is only valid in LOAD mode
        // We verify this by checking uo_out[0] never goes high
        // spuriously during normal RUN mode operation
        // ══════════════════════════════════════════════════════════════
        $display("\n═══════════════════════════════════════════════");
        $display("TEST 3: RUN mode ACK isolation");
        $display("═══════════════════════════════════════════════");

        ui_in  = 8'b0_000_0000;   // RUN mode channel 0
        uio_in = 8'h00;
        repeat(2) @(posedge clk); #1;

        // in RUN mode uo_out is driven by dbg_word not load_ack
        // verify the output assignment switches correctly
        // when run_mode=1, uo_out = dbg_word[7:0] not {7'b0, load_ack}
        // we verify by checking uo_out is NOT just a single bit signal
        // read channel 3 (x1) which should be 0 since no program loaded yet
        ui_in = {1'b0, 4'b0000, 3'd3};
        #2;
        // the point is uo_out is now driven by dbg_word not load_ack
        // if the mux was wrong uo_out would show load_ack (0 or 1 only)
        // instead of a full 8-bit debug value
        $display("  INFO | uo_out in RUN mode ch3 = 0x%02h (driven by dbg, not ACK)", uo_out);
        $display("  INFO | uio_out in RUN mode    = 0x%02h (driven by dbg high byte)", uio_out);

        // run for several cycles and confirm uo_out[0] does not
        // spuriously go high due to ACK leaking through
        begin : ack_isolation
            integer cycle;
            integer spurious;
            spurious = 0;
            ui_in = {1'b0, 4'b0000, 3'd5};  // channel 5 = x3
            for (cycle = 0; cycle < 20; cycle = cycle + 1) begin
                @(posedge clk); #1;
                // in RUN mode uo_out is dbg_word[7:0]
                // load_ack should never appear here
                // we cannot directly check load_ack in RUN mode
                // but we can verify uio_out is being driven (not 0x00)
                // or check internal load_ack is 0
                if (DUT.CPU.load_ack === 1'b1) begin
                    spurious = spurious + 1;
                end
            end
            if (spurious === 0) begin
                $display("  PASS | %-40s | 20 cycles checked", "no spurious ACK in RUN mode");
                pass_count = pass_count + 1;
            end else begin
                $display("  FAIL | spurious ACK appeared %0d times in RUN mode", spurious);
                fail_count = fail_count + 1;
            end
        end

        // ══════════════════════════════════════════════════════════════
        // TEST 4: Channel selector is purely combinational
        // Changing ui_in[2:0] should immediately change output
        // without waiting for a clock edge
        // ══════════════════════════════════════════════════════════════
        $display("\n═══════════════════════════════════════════════");
        $display("TEST 4: Channel selector is combinational");
        $display("═══════════════════════════════════════════════");

        ui_in  = 8'b0_000_0000;
        uio_in = 8'h00;
        #2;

        begin : combinational_mux
            reg [15:0] val_ch0, val_ch1, val_ch2;
            reg [15:0] val_ch3, val_ch4, val_ch5;

            // read all channels without any clock edges — purely #delay
            ui_in = {1'b0, 4'b0000, 3'd0}; #2; val_ch0 = {uio_out, uo_out};
            ui_in = {1'b0, 4'b0000, 3'd1}; #2; val_ch1 = {uio_out, uo_out};
            ui_in = {1'b0, 4'b0000, 3'd2}; #2; val_ch2 = {uio_out, uo_out};
            ui_in = {1'b0, 4'b0000, 3'd3}; #2; val_ch3 = {uio_out, uo_out};
            ui_in = {1'b0, 4'b0000, 3'd4}; #2; val_ch4 = {uio_out, uo_out};
            ui_in = {1'b0, 4'b0000, 3'd5}; #2; val_ch5 = {uio_out, uo_out};

            $display("  INFO | ch0=0x%04h ch1=0x%04h ch2=0x%04h", val_ch0, val_ch1, val_ch2);
            $display("  INFO | ch3=0x%04h ch4=0x%04h ch5=0x%04h", val_ch3, val_ch4, val_ch5);

            // verify output changed immediately on each channel switch
            // by checking outputs match internal wires directly
            ui_in = {1'b0, 4'b0000, 3'd0}; #2;
            passTest16({uio_out, uo_out}, DUT.dbg_pc,         "ch0 matches dbg_pc instantly");
            ui_in = {1'b0, 4'b0000, 3'd1}; #2;
            passTest16({uio_out, uo_out}, DUT.dbg_instr,      "ch1 matches dbg_instr instantly");
            ui_in = {1'b0, 4'b0000, 3'd2}; #2;
            passTest16({uio_out, uo_out}, DUT.dbg_alu_result, "ch2 matches dbg_alu instantly");
            ui_in = {1'b0, 4'b0000, 3'd3}; #2;
            passTest16({uio_out, uo_out}, DUT.dbg_x1,         "ch3 matches dbg_x1 instantly");
            ui_in = {1'b0, 4'b0000, 3'd4}; #2;
            passTest16({uio_out, uo_out}, DUT.dbg_x2,         "ch4 matches dbg_x2 instantly");
            ui_in = {1'b0, 4'b0000, 3'd5}; #2;
            passTest16({uio_out, uo_out}, DUT.dbg_x3,         "ch5 matches dbg_x3 instantly");
            ui_in = {1'b0, 4'b0000, 3'd6}; #2;
            passTest16({uio_out, uo_out}, DUT.dbg_x4,         "ch6 matches dbg_x4 instantly");
            ui_in = {1'b0, 4'b0000, 3'd7}; #2;
            passTest16({uio_out, uo_out}, DUT.dbg_x6,         "ch7 matches dbg_x6 instantly");
        end

        // ══════════════════════════════════════════════════════════════
        // TEST 5: uio_in completely ignored in RUN mode
        // Bidir pins are outputs in RUN mode so uio_in should have
        // zero effect on any output
        // ══════════════════════════════════════════════════════════════
        $display("\n═══════════════════════════════════════════════");
        $display("TEST 5: uio_in ignored in RUN mode");
        $display("═══════════════════════════════════════════════");

        ui_in = {1'b0, 4'b0000, 3'd3};  // RUN mode channel 3
        uio_in = 8'h00; #2;

        begin : uio_isolation
            reg [15:0] ref_val;
            reg [15:0] noisy_val;
            integer p;
            ref_val = {uio_out, uo_out};

            for (p = 0; p < 8; p = p + 1) begin
                uio_in = (8'h01 << p);
                #2;
                noisy_val = {uio_out, uo_out};
                if (noisy_val !== ref_val) begin
                    $display("  FAIL | uio_in bit %0d affected output | 0x%04h vs 0x%04h",
                             p, noisy_val, ref_val);
                    fail_count = fail_count + 1;
                end else begin
                    $display("  PASS | %-40s | bit %0d ok", "uio_in isolated in RUN mode", p);
                    pass_count = pass_count + 1;
                end
            end

            // test all ones
            uio_in = 8'hFF; #2;
            noisy_val = {uio_out, uo_out};
            if (noisy_val !== ref_val) begin
                $display("  FAIL | uio_in=0xFF affected output");
                fail_count = fail_count + 1;
            end else begin
                $display("  PASS | %-40s | 0xFF ok", "uio_in=0xFF isolated in RUN mode");
                pass_count = pass_count + 1;
            end
            uio_in = 8'h00;
        end

        // ══════════════════════════════════════════════════════════════
        // TEST 6: ui_in[6:3] unused bits ignored in RUN mode
        // In RUN mode only ui_in[7] (mode) and ui_in[2:0] (channel)
        // matter. Bits [6:3] should have zero effect on output.
        // ══════════════════════════════════════════════════════════════
        $display("\n═══════════════════════════════════════════════");
        $display("TEST 6: ui_in[6:3] noise immunity in RUN mode");
        $display("═══════════════════════════════════════════════");

        begin : noise_immunity
            reg [15:0] ref_val;
            reg [15:0] noisy_val;
            integer pattern;
            integer failures;
            failures = 0;

            // baseline — RUN mode channel 3, bits[6:3]=0000
            ui_in = {1'b0, 4'b0000, 3'b011};
            #2;
            ref_val = {uio_out, uo_out};

            for (pattern = 0; pattern < 16; pattern = pattern + 1) begin
                ui_in = {1'b0, pattern[3:0], 3'b011};
                #2;
                noisy_val = {uio_out, uo_out};
                if (noisy_val !== ref_val) begin
                    $display("  FAIL | ui_in[6:3]=%04b changed output | 0x%04h vs 0x%04h",
                             pattern[3:0], noisy_val, ref_val);
                    failures = failures + 1;
                    fail_count = fail_count + 1;
                end else begin
                    pass_count = pass_count + 1;
                end
            end

            if (failures === 0)
                $display("  PASS | %-40s | all 16 patterns ok", "ui_in[6:3] noise immunity");
        end

        // ══════════════════════════════════════════════════════════════
        // TEST 7: ena pin has no effect on any output
        // TinyTapeout provides ena but we tie it off as unused
        // Toggling ena should change nothing
        // ══════════════════════════════════════════════════════════════
        $display("\n═══════════════════════════════════════════════");
        $display("TEST 7: ena pin has no effect");
        $display("═══════════════════════════════════════════════");

        ui_in  = {1'b0, 4'b0000, 3'd3};
        uio_in = 8'h00;
        ena    = 1; #2;

        begin : ena_isolation
            reg [15:0] ref_val;
            reg [15:0] ena_val;
            reg [7:0]  ref_oe;

            ref_val = {uio_out, uo_out};
            ref_oe  = uio_oe;

            // toggle ena to 0
            ena = 0; #2;
            ena_val = {uio_out, uo_out};

            if (ena_val !== ref_val) begin
                $display("  FAIL | ena=0 changed output | 0x%04h vs 0x%04h", ena_val, ref_val);
                fail_count = fail_count + 1;
            end else begin
                $display("  PASS | %-40s", "ena=0 has no effect on output");
                pass_count = pass_count + 1;
            end

            if (uio_oe !== ref_oe) begin
                $display("  FAIL | ena=0 changed uio_oe");
                fail_count = fail_count + 1;
            end else begin
                $display("  PASS | %-40s", "ena=0 has no effect on uio_oe");
                pass_count = pass_count + 1;
            end

            // toggle ena back to 1
            ena = 1; #2;
            ena_val = {uio_out, uo_out};
            if (ena_val !== ref_val) begin
                $display("  FAIL | ena=1 changed output after toggle");
                fail_count = fail_count + 1;
            end else begin
                $display("  PASS | %-40s", "ena=1 restores correctly");
                pass_count = pass_count + 1;
            end
        end

        // ══════════════════════════════════════════════════════════════
        // TEST 8: uo_out assignment switches correctly
        // LOAD mode: uo_out = {7'b0, load_ack}
        // RUN  mode: uo_out = dbg_word[7:0]
        // Verify the mux switches the assignment correctly
        // ══════════════════════════════════════════════════════════════
        $display("\n═══════════════════════════════════════════════");
        $display("TEST 8: uo_out assignment mux correctness");
        $display("═══════════════════════════════════════════════");

        // in LOAD mode uo_out should only ever be 0x00 or 0x01
        // (since it is {7'b0, load_ack} and load_ack is 0 or 1)
        ui_in  = 8'b1_1_000000;
        uio_in = 8'h00;
        repeat(2) @(posedge clk); #1;

        // verify uo_out[7:1] are all 0 in LOAD mode
        if (uo_out[7:1] === 7'b0000000) begin
            $display("  PASS | %-40s | uo_out=0x%02h", "uo_out[7:1]=0 in LOAD mode", uo_out);
            pass_count = pass_count + 1;
        end else begin
            $display("  FAIL | uo_out[7:1] not zero in LOAD mode | uo_out=0x%02h", uo_out);
            fail_count = fail_count + 1;
        end

        // in RUN mode uo_out is dbg_word[7:0] — a full 8-bit value
        // verify it matches the internal debug word directly
        ui_in = {1'b0, 4'b0000, 3'd0};  // RUN mode channel 0 = PC
        #2;
        if (uo_out === DUT.dbg_word[7:0]) begin
            $display("  PASS | %-40s | uo_out=0x%02h", "uo_out=dbg_word[7:0] in RUN mode", uo_out);
            pass_count = pass_count + 1;
        end else begin
            $display("  FAIL | uo_out does not match dbg_word[7:0] in RUN mode");
            fail_count = fail_count + 1;
        end

        // verify uio_out = dbg_word[15:8] in RUN mode
        if (uio_out === DUT.dbg_word[15:8]) begin
            $display("  PASS | %-40s | uio_out=0x%02h", "uio_out=dbg_word[15:8] in RUN mode", uio_out);
            pass_count = pass_count + 1;
        end else begin
            $display("  FAIL | uio_out does not match dbg_word[15:8] in RUN mode");
            fail_count = fail_count + 1;
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
            $display("  ALL TESTS PASSED");
        else
            $display("  %0d TEST(S) FAILED", fail_count);
        $display("═══════════════════════════════════════════════\n");

        $finish;
    end

endmodule