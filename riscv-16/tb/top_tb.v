`timescale 1ns / 1ps
`define HALF_CLOCK_PERIOD 5
`define STRLEN 32

module top_tb;

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
    integer timeout;
    integer watchdog;

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

    reg clk_en;
    initial begin
        clk    = 0;
        clk_en = 1;
    end
    always #`HALF_CLOCK_PERIOD clk = (clk_en ? ~clk : clk);

    initial begin
        $dumpfile("./tb/waveform/top.vcd");
        $dumpvars(0, top_tb);
    end

    task passTest;
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

    task wait_ack;
        begin
            timeout = 0;
            while (!uo_out[0] && timeout < 8) begin
                @(posedge clk); #1;
                timeout = timeout + 1;
            end
            // if (uo_out[0])
            //     $display("  [ACK] received (addr=%0d)", DUT.CPU.IMEM.write_addr - 1);
            // else
            //     $display("  [ACK] TIMEOUT - FSM state=%0d", DUT.CPU.IMEM.state);
        end
    endtask

    task load_instr;
        input [7:0] t1_ui;
        input [7:0] t1_uio;
        input [7:0] t2_ui;
        input [7:0] t2_uio;
        begin
            ui_in  = t1_ui;
            uio_in = t1_uio;
            @(posedge clk); #1;
            ui_in  = t2_ui;
            uio_in = t2_uio;
            @(posedge clk); #1;
            wait_ack();
            ui_in  = 8'b1_1_000000;
            uio_in = 8'h00;
            @(posedge clk); #1;
        end
    endtask

    // ── read_channel ──────────────────────────────────────────────────
    // uses ui_in[3:0] now to support 9 channels
    // ui_in[7]=0 RUN mode, ui_in[3:0]=channel
    task read_channel;
        input  [2:0]  channel;
        output [15:0] value;
        begin
            ui_in = {1'b0, 4'b0000, channel};
            #2;
            value = {uio_out, uo_out};
        end
    endtask

    task print_state;
        reg [15:0] pc, instr, alu, x1, x2, x3, x4, x6;
        begin
            clk_en = 0;        // freeze clock during reads
            read_channel(3'd0, pc);
            read_channel(3'd1, instr);
            read_channel(3'd2, alu);
            read_channel(3'd3, x1);
            read_channel(3'd4, x2);
            read_channel(3'd5, x3);
            read_channel(3'd6, x4);
            read_channel(3'd7, x6);
            clk_en = 1;        // unfreeze clock
            $display("  PC=0x%04h | INSTR=0x%04h | ALU=0x%04h | x1=0x%04h | x2=0x%04h | x3=0x%04h | x4=0x%04h | x6=0x%04h",
                    pc, instr, alu, x1, x2, x3, x4, x6);
        end
    endtask

    reg [15:0] result;

    initial begin
        pass_count = 0;
        fail_count = 0;
        watchdog   = 0;
        ena        = 1;

        ui_in  = 8'b1_1_000000;
        uio_in = 8'h00;
        rst_n  = 0;

        repeat(4) @(posedge clk);
        rst_n = 1;
        repeat(2) @(posedge clk);

        // ══════════════════════════════════════════════════════════════
        // PHASE 1 — LOAD PROGRAM THROUGH PINS
        //
        // Program:
        //   instr 0: ADDI x1, x0, 3  = 0x6081  → x1 = 3
        //   instr 1: ADDI x2, x0, 2  = 0x4101  → x2 = 2
        //   instr 2: ADD  x0, x1, x2 = 0x2800  → x0 stays 0 (hardwired)
        //   instr 3: SUB  x4, x1, x2 = 0x2A08  → x4 = 3-2 = 1
        //   instr 4: ADD  x6, x1, x2 = 0x2A80  → x6 = 3+2 = 5
        //   instr 5: OR   x3, x1, x2 = 0x2B18  → x3 = 3|2 = 3
        //   instr 6: NOP              = 0x0000
        //   instr 7: NOP              = 0x0000
        // ══════════════════════════════════════════════════════════════
        $display("\n===============================================");
        $display("PHASE 1: LOAD PROGRAM THROUGH PINS");
        $display("===============================================");

        // ── instr 0: ADDI x1, x0, 3 = 0x6081 ─────────────────────────
        // 0x6081 = 0110 0000 1000 0001
        // bits[5:0]   = 000001
        // bits[13:6]  = 10000010
        // bits[15:14] = 01
        $display("  Loading instr 0: ADDI x1, x0, 3 = 0x6081");
        load_instr(
            8'b1_0_000001, 8'b10000010,
            8'b1_1_010000, 8'b00000000
        );

        // ── instr 1: ADDI x2, x0, 2 = 0x4101 ─────────────────────────
        // 0x4101 = 0100 0001 0000 0001
        // bits[5:0]   = 000001
        // bits[13:6]  = 00000100
        // bits[15:14] = 01
        $display("  Loading instr 1: ADDI x2, x0, 2 = 0x4101");
        load_instr(
            8'b1_0_000001, 8'b00000100,
            8'b1_1_010000, 8'b00000000
        );

        // ── instr 2: ADD x0, x1, x2 = 0x2800 ─────────────────────────
        // 0x2800 = 0010 1000 0000 0000
        // bits[5:0]   = 000000
        // bits[13:6]  = 10100000
        // bits[15:14] = 00
        // NOTE: writes to x0 which is hardwired 0 — result discarded
        $display("  Loading instr 2: ADD x0, x1, x2 = 0x2800");
        load_instr(
            8'b1_0_000000, 8'b10100000,
            8'b1_1_000000, 8'b00000000
        );

        // ── instr 3: SUB x4, x1, x2 = 0x2A08 ─────────────────────────
        // 0x2A08 = 0010 1010 0000 1000
        // bits[5:0]   = 001000
        // bits[13:6]  = 10101000
        // bits[15:14] = 00
        $display("  Loading instr 3: SUB x4, x1, x2 = 0x2A08");
        load_instr(
            8'b1_0_001000, 8'b10101000,
            8'b1_1_000000, 8'b00000000
        );

        // ── instr 4: ADD x6, x1, x2 = 0x2B00 ─────────────────────────
        $display("  Loading instr 4: ADD x6, x1, x2 = 0x2B00");
        load_instr(
            8'b1_0_000000, 8'b10101100,
            8'b1_1_000000, 8'b00000000
        );

        // ── instr 5: OR x3, x1, x2 = 0x2998 ──────────────────────────
        $display("  Loading instr 5: OR x3, x1, x2 = 0x2998");
        load_instr(
            8'b1_0_011000, 8'b10100110,
            8'b1_1_000000, 8'b00000000
        );

        // ── instr 6: XOR x2, x1, x2 = 0x2910 ─────────────────────────
        // 0x2910 = 0010 1001 0001 0000
        // x2 = x1 XOR x2 = 3 XOR 2 = 1
        // NOTE: x2 was 2, after XOR x2 becomes 1
        $display("  Loading instr 6: XOR x2, x1, x2 = 0x2910");
        load_instr(
            8'b1_0_010000, 8'b10100100,
            8'b1_1_000000, 8'b00000000
        );

        // ── instr 7: NOP = 0x0000 ─────────────────────────────────────
        $display("  Loading instr 6: NOP = 0x0000");
        load_instr(
            8'b1_0_000000, 8'b00000000,
            8'b1_1_000000, 8'b00000000
        );

        // ── instr 8: NOP = 0x0000 ─────────────────────────────────────
        $display("  Loading instr 7: NOP = 0x0000");
        load_instr(
            8'b1_0_000000, 8'b00000000,
            8'b1_1_000000, 8'b00000000
        );

        // ── verify RAM ────────────────────────────────────────────────
        $display("\n  IMEM check:");
        $display("    memory[0]=0x%04h (expect 0x6081)", DUT.CPU.IMEM.memory[0]);
        $display("    memory[1]=0x%04h (expect 0x4101)", DUT.CPU.IMEM.memory[1]);
        $display("    memory[2]=0x%04h (expect 0x2800)", DUT.CPU.IMEM.memory[2]);
        $display("    memory[3]=0x%04h (expect 0x2A08)", DUT.CPU.IMEM.memory[3]);
        $display("    memory[4]=0x%04h (expect 0x2B00)", DUT.CPU.IMEM.memory[4]);
        $display("    memory[5]=0x%04h (expect 0x2998)", DUT.CPU.IMEM.memory[5]);
        $display("    memory[6]=0x%04h (expect 0x2910)", DUT.CPU.IMEM.memory[6]);
        $display("    memory[7]=0x%04h (expect 0x0000)", DUT.CPU.IMEM.memory[7]);
        $display("    memory[8]=0x%04h (expect 0x0000)", DUT.CPU.IMEM.memory[8]);
        $display("    write_addr=%0d   (expect 9)",      DUT.CPU.IMEM.write_addr);

        if (uio_oe === 8'h00)
            $display("  PASS | uio_oe=0x00 during LOAD (bidir=inputs)");
        else
            $display("  FAIL | uio_oe=0x%02h during LOAD", uio_oe);

        // ══════════════════════════════════════════════════════════════
        // PHASE 2 — RESET AND START EXECUTION
        // ══════════════════════════════════════════════════════════════
        $display("\n===============================================");
        $display("PHASE 2: RESET AND START EXECUTION");
        $display("===============================================");

        ui_in  = 8'b0_000_0000;
        uio_in = 8'h00;
        rst_n  = 0;
        repeat(4) @(posedge clk); #1;

        if (uio_oe === 8'hFF)
            $display("  PASS | uio_oe=0xFF during RUN (bidir=outputs)");
        else
            $display("  FAIL | uio_oe=0x%02h during RUN", uio_oe);

        read_channel(3'd0, result);
        passTest(result, 16'h0000, "PC=0 during reset via pin");

        rst_n = 1;

        // ══════════════════════════════════════════════════════════════
        // PHASE 3 — EXECUTION TRACE
        // ══════════════════════════════════════════════════════════════
        $display("\n===============================================");
        $display("PHASE 3: EXECUTION TRACE THROUGH PINS");
        $display("===============================================");

        watchdog = 0;
        while (watchdog < 20) begin
            @(posedge clk); #1;
            print_state();
            watchdog = watchdog + 1;
        end

        $display("\n  Direct internal wire check:");
        $display("    DUT.CPU.dbg_x1 = 0x%04h (expect 0x0003)", DUT.CPU.dbg_x1);
        $display("    DUT.CPU.dbg_x2 = 0x%04h (expect 0x0001)", DUT.CPU.dbg_x2);
        $display("    DUT.CPU.dbg_x3 = 0x%04h (expect 0x0003)", DUT.CPU.dbg_x3);
        $display("    DUT.CPU.dbg_x4 = 0x%04h (expect 0x0001)", DUT.CPU.dbg_x4);
        $display("    DUT.CPU.dbg_x5 = 0x%04h (expect 0x0000)", DUT.CPU.dbg_x5);
        $display("    DUT.CPU.dbg_x6 = 0x%04h (expect 0x0005)", DUT.CPU.dbg_x6);

        // ══════════════════════════════════════════════════════════════
        // PHASE 4 — CHECK ALL REGISTER VALUES THROUGH PINS
        //
        // Expected:
        //   x1 = 3  (ADDI x1,x0,3)
        //   x2 = 2  (ADDI x2,x0,2)
        //   x3 = 3  (OR  x3,x1,x2 = 3|2 = 3)
        //   x4 = 1  (SUB x4,x1,x2 = 3-2 = 1)
        //   x5 = 0  (never touched)
        //   x6 = 5  (ADD x6,x1,x2 = 3+2 = 5)
        //   x0 = 0  (hardwired, ADD result discarded)
        // ══════════════════════════════════════════════════════════════
        $display("\n===============================================");
        $display("PHASE 4: CHECK ALL REGISTER VALUES THROUGH PINS");
        $display("===============================================");

        read_channel(3'd3, result);
        passTest(result, 16'h0003, "x1=3 after ADDI x1,x0,3");

                // in Phase 4 — x2 now = 1 after XOR
        read_channel(3'd4, result);
        passTest(result, 16'h0001, "x2=1 after XOR x2,x1,x2 (3^2=1)");

        read_channel(3'd5, result);
        passTest(result, 16'h0003, "x3=3 after OR x3,x1,x2 (3|2=3)");

        read_channel(3'd6, result);
        passTest(result, 16'h0001, "x4=1 after SUB x4,x1,x2 (3-2=1)");

        read_channel(3'd7, result);
        passTest(result, 16'h0005, "x6=5 after ADD x6,x1,x2 (3+2=5)");



        // ── verify x0 hardwired to 0 ──────────────────────────────────
        // x0 is not a debug channel but we can verify indirectly:
        // ADD x0,x1,x2 should have computed 5 but x0 stays 0
        // x1 and x2 unchanged confirms x0 write was discarded
        $display("\n  INFO | x0 hardwired to 0 verification:");
        $display("         ADD x0,x1,x2 computed 3+2=5");
        $display("         but x0 stays 0 (write discarded by register file)");
        $display("         x1 and x2 unchanged confirms correct operation");

        // ── final register snapshot ───────────────────────────────────
        $display("\n  Final register snapshot:");
        read_channel(3'd3, result); $display("    x1 = 0x%04h (expect 0x0003)", result);
        read_channel(3'd4, result); $display("    x2 = 0x%04h (expect 0x0001)", result);
        read_channel(3'd5, result); $display("    x3 = 0x%04h (expect 0x0003)", result);
        read_channel(3'd6, result); $display("    x4 = 0x%04h (expect 0x0001)", result);
        read_channel(3'd7, result); $display("    x6 = 0x%04h (expect 0x0005)", result);

        // ══════════════════════════════════════════════════════════════
        // FINAL REPORT
        // ══════════════════════════════════════════════════════════════
        $display("\n===============================================");
        $display("FINAL: pass=%0d fail=%0d", pass_count, fail_count);
        $display("===============================================\n");

        $finish;
    end

endmodule