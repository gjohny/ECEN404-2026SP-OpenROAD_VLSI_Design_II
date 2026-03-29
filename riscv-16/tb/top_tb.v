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
    reg         load_mode;
    reg         load_transfer;
    reg  [5:0]  load_ui;
    reg  [7:0]  load_uio;
    wire        load_ack;

    integer pass_count;
    integer fail_count;

    top DUT (
        .clk           (clk),
        .reset         (reset),
        .dbg_pc        (dbg_pc),
        .dbg_instr     (dbg_instr),
        .dbg_alu_result(dbg_alu_result),
        .dbg_x1        (dbg_x1),
        .dbg_x2        (dbg_x2),
        .dbg_x3        (dbg_x3),
        .load_mode     (load_mode),
        .load_transfer (load_transfer),
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

    task load_instruction;
        input [15:0] instr;
        integer timeout;
        begin
            $display("  [LOAD] instr=0x%04h  T1:ui=0x%02h uio=0x%02h  T2:ui[5:4]=0b%02b",
                     instr, instr[5:0], instr[13:6], instr[15:14]);

            // Transfer 1: load_transfer=0
            load_transfer = 1'b0;
            load_ui       = instr[5:0];
            load_uio      = instr[13:6];
            @(posedge clk); #1;

            // Transfer 2: load_transfer=1
            load_transfer = 1'b1;
            load_ui       = {instr[15:14], 4'b0000};
            load_uio      = 8'h00;
            @(posedge clk); #1;

            // Wait for ACK — keep transfer=1 so FSM stays in WRITE/ACK
            timeout = 0;
            while (!load_ack && timeout < 8) begin
                @(posedge clk); #1;
                timeout = timeout + 1;
            end
            if (load_ack)
                $display("  [LOAD] ACK OK  (addr=%0d)", DUT.IMEM.write_addr - 1);
            else
                $display("  [LOAD] ACK TIMEOUT - FSM state=%0d", DUT.IMEM.state);

            // Idle: hold transfer=1 so FSM does NOT re-enter GOT_T1
            load_transfer = 1'b1;
            load_ui       = 6'h00;
            load_uio      = 8'h00;
            @(posedge clk); #1;
        end
    endtask

    task print_state;
        begin
            $display("  PC=0x%04h | INSTR=0x%04h | ALU=0x%04h | x1=0x%04h | x2=0x%04h | x3=0x%04h",
                     dbg_pc, dbg_instr, dbg_alu_result, dbg_x1, dbg_x2, dbg_x3);
        end
    endtask

    integer watchdog;

    initial begin
        pass_count    = 0;
        fail_count    = 0;
        watchdog      = 0;
        load_mode     = 1;
        load_transfer = 1;
        load_ui       = 0;
        load_uio      = 0;
        reset         = 1;

        repeat(4) @(posedge clk);
        reset = 0;
        repeat(2) @(posedge clk);

        $display("\n===============================================");
        $display("PHASE 1: LOAD MODE");
        $display("===============================================");

        load_mode = 1;

        load_instruction(16'h2901);
        load_instruction(16'h2901);
        load_instruction(16'h2901);
        load_instruction(16'h0000);
        load_instruction(16'h0000);

        $display("  IMEM check:");
        $display("    memory[0]=0x%04h (expect 0x2901)", DUT.IMEM.memory[0]);
        $display("    memory[1]=0x%04h (expect 0x2901)", DUT.IMEM.memory[1]);
        $display("    memory[2]=0x%04h (expect 0x2901)", DUT.IMEM.memory[2]);
        $display("    memory[3]=0x%04h (expect 0x0000)", DUT.IMEM.memory[3]);
        $display("    write_addr=%0d (expect 5)", DUT.IMEM.write_addr);

        $display("\n===============================================");
        $display("PHASE 2: RESET then RUN");
        $display("===============================================");

        load_mode = 0;
        reset     = 1;
        repeat(4) @(posedge clk); #1;
        passTest(dbg_pc, 16'h0000, "PC=0 during reset");
        reset = 0;

        $display("\n===============================================");
        $display("PHASE 3: Execution trace");
        $display("===============================================");

        watchdog = 0;
        while (watchdog < 15) begin
            @(posedge clk); #1;
            print_state();
            watchdog = watchdog + 1;
        end

        $display("\n===============================================");
        $display("PHASE 4: Register checks");
        $display("===============================================");

        passTest(dbg_x1, 16'h0000, "x1=0 untouched");
        passTest(dbg_x2, 16'h0003, "x2=3 after 3x ADDI x2,x2,1");
        passTest(dbg_x3, 16'h0000, "x3=0 untouched");

        $display("\n===============================================");
        $display("FINAL: pass=%0d fail=%0d", pass_count, fail_count);
        $display("===============================================\n");

        $finish;
    end

endmodule
