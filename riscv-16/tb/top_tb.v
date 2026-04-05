`timescale 1ns / 1ps
`define HALF_CLOCK_PERIOD 5
`define STRLEN 32

module top_tb;
    reg        clk;
    reg        reset;
    wire [15:0] dbg_pc;
    wire [15:0] dbg_instr;
    wire [15:0] dbg_alu_result;
    wire [15:0] dbg_x1;
    wire [15:0] dbg_x2;
    wire [15:0] dbg_x3;
    reg  [7:0]  load_ui;    // bit[7]=mode, bit[6]=transfer, bits[5:0]=data
    reg  [7:0]  load_uio;
    wire        load_ack;

    integer pass_count;
    integer fail_count;
    integer timeout;
    integer watchdog;

    top DUT (
        .clk           (clk),
        .reset         (reset),
        .dbg_pc        (dbg_pc),
        .dbg_instr     (dbg_instr),
        .dbg_alu_result(dbg_alu_result),
        .dbg_x1        (dbg_x1),
        .dbg_x2        (dbg_x2),
        .dbg_x3        (dbg_x3),
        .load_ui       (load_ui),
        .load_uio      (load_uio),
        .load_ack      (load_ack)
    );

    initial clk = 0;
    always #`HALF_CLOCK_PERIOD clk = ~clk;

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
                $display("  PASS | %-35s | got 0x%04h", testName, actual);
                pass_count = pass_count + 1;
            end else begin
                $display("  FAIL | %-35s | expected 0x%04h, got 0x%04h",
                         testName, expected, actual);
                fail_count = fail_count + 1;
            end
        end
    endtask

    task wait_ack;
        begin
            timeout = 0;
            while (!load_ack && timeout < 8) begin
                @(posedge clk); #1;
                timeout = timeout + 1;
            end
            if (load_ack)
                $display("  [ACK] received (addr=%0d)", DUT.IMEM.write_addr - 1);
            else
                $display("  [ACK] TIMEOUT - FSM state=%0d", DUT.IMEM.state);
        end
    endtask

    task print_state;
        begin
            $display("  PC=0x%04h | INSTR=0x%04h | ALU=0x%04h | x1=0x%04h | x2=0x%04h | x3=0x%04h",
                     dbg_pc, dbg_instr, dbg_alu_result, dbg_x1, dbg_x2, dbg_x3);
        end
    endtask

    initial begin
        pass_count = 0;
        fail_count = 0;
        watchdog   = 0;

        // bit[7]=1 LOAD, bit[6]=1 T2 (idle), bits[5:0]=0
        load_ui    = 8'b1_1_000000;
        load_uio   = 8'h00;
        reset      = 1;

        repeat(4) @(posedge clk);
        reset = 0;
        repeat(2) @(posedge clk);

        // ══════════════════════════════════════════════════════════════
        // PHASE 1 — LOAD MODE
        // Pin layout — all 16 bits per cycle:
        //   load_ui[7]   = 1     → LOAD mode
        //   load_ui[6]   = 0/1  → transfer ID (T1=0, T2=1)
        //   load_ui[5:0] = data → instruction bits
        //   load_uio     = data → instruction bits
        //
        // Instruction 0x2901 = 0010 1001 0000 0001
        //   T1: load_ui=8'b1_0_000001  load_uio=8'b10100100
        //   T2: load_ui=8'b1_1_000000  load_uio=8'b00000000
        // ══════════════════════════════════════════════════════════════
        $display("\n===============================================");
        $display("PHASE 1: LOAD MODE");
        $display("===============================================");

        // ── instruction 1: 0x2901 ─────────────────────────────────────
        $display("  [LOAD] 0x2901 — cycle 1 of 2");
        load_ui  = 8'b1_0_000001;   // mode=1 T1=0 data=instr[5:0]
        load_uio = 8'b10100100;     // instr[13:6]
        @(posedge clk); #1;

        $display("  [LOAD] 0x2901 — cycle 2 of 2");
        load_ui  = 8'b1_1_000000;   // mode=1 T2=1 data=instr[15:14]=00
        load_uio = 8'b00000000;     // unused
        @(posedge clk); #1;

        wait_ack();
        load_ui  = 8'b1_1_000000;   // idle
        load_uio = 8'h00;
        @(posedge clk); #1;

        // ── instruction 2: 0x2901 ─────────────────────────────────────
        $display("  [LOAD] 0x2901 — cycle 1 of 2");
        load_ui  = 8'b1_0_000001;
        load_uio = 8'b10100100;
        @(posedge clk); #1;

        $display("  [LOAD] 0x2901 — cycle 2 of 2");
        load_ui  = 8'b1_1_000000;
        load_uio = 8'b00000000;
        @(posedge clk); #1;

        wait_ack();
        load_ui  = 8'b1_1_000000;
        load_uio = 8'h00;
        @(posedge clk); #1;

        // ── instruction 3: 0x2901 ─────────────────────────────────────
        $display("  [LOAD] 0x2901 — cycle 1 of 2");
        load_ui  = 8'b1_0_000001;
        load_uio = 8'b10100100;
        @(posedge clk); #1;

        $display("  [LOAD] 0x2901 — cycle 2 of 2");
        load_ui  = 8'b1_1_000000;
        load_uio = 8'b00000000;
        @(posedge clk); #1;

        wait_ack();
        load_ui  = 8'b1_1_000000;
        load_uio = 8'h00;
        @(posedge clk); #1;

        // ── instruction 4: 0x3101 ─────────────────────────────────────
        // 0x3101 = 0011 0001 0000 0001
        // T1: load_ui=8'b1_0_000001  load_uio=8'b11000100
        // T2: load_ui=8'b1_1_000000  load_uio=8'b00000000
        $display("  [LOAD] 0x3101 — cycle 1 of 2");
        load_ui  = 8'b1_0_000001;   // mode=1 T1=0 instr[5:0]=000001
        load_uio = 8'b11000100;     // instr[13:6]
        @(posedge clk); #1;

        $display("  [LOAD] 0x3101 — cycle 2 of 2");
        load_ui  = 8'b1_1_000000;   // mode=1 T2=1 instr[15:14]=00
        load_uio = 8'b00000000;
        @(posedge clk); #1;

        wait_ack();
        load_ui  = 8'b1_1_000000;
        load_uio = 8'h00;
        @(posedge clk); #1;

        // ── instruction 5: 0x0000 NOP ─────────────────────────────────
        $display("  [LOAD] 0x0000 — cycle 1 of 2");
        load_ui  = 8'b1_0_000000;   // mode=1 T1=0 instr[5:0]=000000
        load_uio = 8'b00000000;     // instr[13:6]=00000000
        @(posedge clk); #1;

        $display("  [LOAD] 0x0000 — cycle 2 of 2");
        load_ui  = 8'b1_1_000000;   // mode=1 T2=1 instr[15:14]=00
        load_uio = 8'b00000000;
        @(posedge clk); #1;

        wait_ack();
        load_ui  = 8'b1_1_000000;
        load_uio = 8'h00;
        @(posedge clk); #1;

        // ── instruction 6: 0x0000 NOP ─────────────────────────────────
        $display("  [LOAD] 0x0000 — cycle 1 of 2");
        load_ui  = 8'b1_0_000000;
        load_uio = 8'b00000000;
        @(posedge clk); #1;

        $display("  [LOAD] 0x0000 — cycle 2 of 2");
        load_ui  = 8'b1_1_000000;
        load_uio = 8'b00000000;
        @(posedge clk); #1;

        wait_ack();
        load_ui  = 8'b1_1_000000;
        load_uio = 8'h00;
        @(posedge clk); #1;

        // ── verify RAM ────────────────────────────────────────────────
        $display("  IMEM check:");
        $display("    memory[0]=0x%04h (expect 0x2901)", DUT.IMEM.memory[0]);
        $display("    memory[1]=0x%04h (expect 0x2901)", DUT.IMEM.memory[1]);
        $display("    memory[2]=0x%04h (expect 0x2901)", DUT.IMEM.memory[2]);
        $display("    memory[3]=0x%04h (expect 0x3101)", DUT.IMEM.memory[3]);
        $display("    memory[4]=0x%04h (expect 0x0000)", DUT.IMEM.memory[4]);
        $display("    memory[5]=0x%04h (expect 0x0000)", DUT.IMEM.memory[5]);
        $display("    write_addr=%0d   (expect 6)",      DUT.IMEM.write_addr);

        // ══════════════════════════════════════════════════════════════
        // PHASE 2 — RESET then RUN
        // ══════════════════════════════════════════════════════════════
        $display("\n===============================================");
        $display("PHASE 2: RESET then RUN");
        $display("===============================================");

        // switch to RUN mode — bit[7]=0
        load_ui  = 8'b0_0_000000;
        load_uio = 8'h00;
        reset    = 1;
        repeat(4) @(posedge clk); #1;
        passTest(dbg_pc, 16'h0000, "PC=0 during reset");
        reset = 0;

        // ══════════════════════════════════════════════════════════════
        // PHASE 3 — Execution trace
        // ══════════════════════════════════════════════════════════════
        $display("\n===============================================");
        $display("PHASE 3: Execution trace");
        $display("===============================================");

        watchdog = 0;
        while (watchdog < 20) begin
            @(posedge clk); #1;
            print_state();
            watchdog = watchdog + 1;
        end

        // ══════════════════════════════════════════════════════════════
        // PHASE 4 — Register checks
        // ══════════════════════════════════════════════════════════════
        $display("\n===============================================");
        $display("PHASE 4: Register checks");
        $display("===============================================");

        passTest(dbg_x1, 16'h0000, "x1=0 untouched");
        passTest(dbg_x2, 16'h0004, "x2=4 after instructions");
        passTest(dbg_x3, 16'h0000, "x3=0 untouched");

        $display("\n===============================================");
        $display("FINAL: pass=%0d fail=%0d", pass_count, fail_count);
        $display("===============================================\n");

        $finish;
    end

endmodule