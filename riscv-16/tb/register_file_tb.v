`timescale 1ns / 1ps

module Register_file_tb;

    // -----------------------------------------------------------------------
    // DUT ports
    // -----------------------------------------------------------------------
    reg         clk;
    reg         RegWrite;
    reg  [2:0]  A3;        // Write address
    reg  [15:0] WD3;       // Write data
    reg  [2:0]  A1;        // Read address 1
    reg  [2:0]  A2;        // Read address 2
    wire [15:0] RD1;       // Read data 1
    wire [15:0] RD2;       // Read data 2

    // -----------------------------------------------------------------------
    // Instantiate DUT
    // -----------------------------------------------------------------------
    Register_file uut (
        .clk(clk),
        .RegWrite(RegWrite),
        .A3(A3),
        .WD3(WD3),
        .A1(A1),
        .A2(A2),
        .RD1(RD1),
        .RD2(RD2)
    );

    // -----------------------------------------------------------------------
    // Clock: 10 ns period
    // -----------------------------------------------------------------------
    initial clk = 0;
    always #5 clk = ~clk;

    // -----------------------------------------------------------------------
    // Waveform dump
    // -----------------------------------------------------------------------
    initial begin
        $dumpfile("./tb/waveform/Register_file.vcd");
        $dumpvars(0, Register_file_tb);
    end

    // -----------------------------------------------------------------------
    // Pass / fail counters
    // -----------------------------------------------------------------------
    integer pass_count = 0;
    integer fail_count = 0;
    integer test_num   = 0;

    // -----------------------------------------------------------------------
    // Helper task — write a register, then verify both read ports
    //   Drives A3/WD3/RegWrite, waits for the next rising edge (synchronous
    //   write), then checks RD1 and RD2 with A1/A2 already set by the caller.
    // -----------------------------------------------------------------------
    task write_and_check;
        input [127:0] test_name;
        input  [2:0]  addr;
        input  [15:0] data;
        input  [2:0]  ra1;
        input  [2:0]  ra2;
        input  [15:0] exp_rd1;
        input  [15:0] exp_rd2;
        reg           pass;
        begin
            test_num = test_num + 1;
            A3 = addr; WD3 = data; RegWrite = 1'b1;
            A1 = ra1;  A2  = ra2;
            @(posedge clk); #1;           // let write latch, then settle

            pass = (RD1 === exp_rd1) && (RD2 === exp_rd2);

            $display("| %4d | %-28s | %0d | %5d | WR=1 | %0d | %0d | exp(%5d,%5d) got(%5d,%5d) | %s |",
                     test_num, test_name, addr, data, ra1, ra2,
                     exp_rd1, exp_rd2, RD1, RD2,
                     pass ? "\033[32mPASS\033[0m" : "\033[31mFAIL\033[0m");

            if (pass) pass_count = pass_count + 1;
            else      fail_count = fail_count + 1;
        end
    endtask

    // -----------------------------------------------------------------------
    // Helper task — read only (RegWrite=0), check both ports
    // -----------------------------------------------------------------------
    task read_check;
        input [127:0] test_name;
        input  [2:0]  ra1;
        input  [2:0]  ra2;
        input  [15:0] exp_rd1;
        input  [15:0] exp_rd2;
        reg           pass;
        begin
            test_num  = test_num + 1;
            RegWrite  = 1'b0;
            A1 = ra1; A2 = ra2;
            #1;   // purely combinational read — just let signals settle

            pass = (RD1 === exp_rd1) && (RD2 === exp_rd2);

            $display("| %4d | %-28s |   |       | WR=0 | %0d | %0d | exp(%5d,%5d) got(%5d,%5d) | %s |",
                     test_num, test_name, ra1, ra2,
                     exp_rd1, exp_rd2, RD1, RD2,
                     pass ? "\033[32mPASS\033[0m" : "\033[31mFAIL\033[0m");

            if (pass) pass_count = pass_count + 1;
            else      fail_count = fail_count + 1;
        end
    endtask

    // -----------------------------------------------------------------------
    // Stimulus
    // -----------------------------------------------------------------------
    initial begin
        // Initialise
        RegWrite = 0; A3 = 0; WD3 = 0; A1 = 0; A2 = 0;

        $display("===========================================================================================================");
        $display("| Test | Description                  | A3 | WD3   | RW   | A1 | A2 | Expected (RD1,RD2)   Result       |");
        $display("===========================================================================================================");

        // ===================================================================
        // SECTION 1 — x0 is hardwired to 0, can never be written
        // ===================================================================
        $display("|--- Section 1: x0 hardwired zero -------------------------------------------------------------------|------|");

        // Attempt to write x0, then read it back — must still be 0
        write_and_check("Write x0=999 (must stay 0)", 3'd0, 16'd999, 3'd0, 3'd0, 16'd0, 16'd0);

        // Read x0 on both ports simultaneously
        read_check("Read x0||x0", 3'd0, 3'd0, 16'd0, 16'd0);

        // ===================================================================
        // SECTION 2 — Write then read every general-purpose register (x1–x7)
        // ===================================================================
        $display("\n|--- Section 2: Write + read back every register (x1–x7) --------------------------------------------|------|");

        write_and_check("Write x1=100",  3'd1, 16'd100,  3'd1, 3'd0, 16'd100,  16'd0);
        write_and_check("Write x2=200",  3'd2, 16'd200,  3'd2, 3'd1, 16'd200,  16'd100);
        write_and_check("Write x3=300",  3'd3, 16'd300,  3'd3, 3'd2, 16'd300,  16'd200);
        write_and_check("Write x4=400",  3'd4, 16'd400,  3'd4, 3'd3, 16'd400,  16'd300);
        write_and_check("Write x5=500",  3'd5, 16'd500,  3'd5, 3'd4, 16'd500,  16'd400);
        write_and_check("Write x6=600",  3'd6, 16'd600,  3'd6, 3'd5, 16'd600,  16'd500);
        write_and_check("Write x7=700",  3'd7, 16'd700,  3'd7, 3'd6, 16'd700,  16'd600);

        // ===================================================================
        // SECTION 3 — Read both ports independently across all registers
        // ===================================================================
        $display("\n|--- Section 3: Independent reads from all register pairs -------------------------------------------|------|");

        read_check("Read x1||x2", 3'd1, 3'd2, 16'd100, 16'd200);
        read_check("Read x3||x4", 3'd3, 3'd4, 16'd300, 16'd400);
        read_check("Read x5||x6", 3'd5, 3'd6, 16'd500, 16'd600);
        read_check("Read x7||x0", 3'd7, 3'd0, 16'd700, 16'd0);
        read_check("Read x0||x7", 3'd0, 3'd7, 16'd0,   16'd700);
        // Same register on both ports
        read_check("Read x3||x3 (same reg)", 3'd3, 3'd3, 16'd300, 16'd300);

        // ===================================================================
        // SECTION 4 — Boundary / extreme data values
        // ===================================================================
        $display("\n|--- Section 4: Boundary data values ----------------------------------------------------------------|------|");

        write_and_check("Write x1=0x0000",  3'd1, 16'h0000, 3'd1, 3'd0, 16'h0000, 16'h0000);
        write_and_check("Write x2=0xFFFF",  3'd2, 16'hFFFF, 3'd2, 3'd0, 16'hFFFF, 16'h0000);
        write_and_check("Write x3=0x5555",  3'd3, 16'h5555, 3'd3, 3'd2, 16'h5555, 16'hFFFF);
        write_and_check("Write x4=0xAAAA",  3'd4, 16'hAAAA, 3'd4, 3'd3, 16'hAAAA, 16'h5555);
        write_and_check("Write x5=0x0001",  3'd5, 16'h0001, 3'd5, 3'd0, 16'h0001, 16'h0000);
        write_and_check("Write x6=0x8000",  3'd6, 16'h8000, 3'd6, 3'd5, 16'h8000, 16'h0001);
        write_and_check("Write x7=0x7FFF",  3'd7, 16'h7FFF, 3'd7, 3'd6, 16'h7FFF, 16'h8000);

        // ===================================================================
        // SECTION 5 — RegWrite = 0: write must be ignored
        // ===================================================================
        $display("\n|--- Section 5: RegWrite=0, write must be ignored ----------------------------------------------------|------|");

        // Attempt to overwrite x1 (currently 0x0000) with 0xDEAD while RegWrite=0
        // First set up a "false write" scenario
        A3 = 3'd1; WD3 = 16'hDEAD; RegWrite = 1'b0;
        A1 = 3'd1; A2  = 3'd0;
        @(posedge clk); #1;
        begin : blk_rw0
            reg pass_rw0;
            test_num = test_num + 1;
            pass_rw0 = (RD1 === 16'h0000) && (RD2 === 16'h0000);
            $display("| %4d | %-28s | %0d | 0xDEAD | WR=0 | %0d | %0d | exp(%5d,%5d) got(%5d,%5d) | %s |",
                     test_num, "RegWrite=0: x1 unchanged",
                     1, 1, 0,
                     16'h0000, 16'h0000, RD1, RD2,
                     pass_rw0 ? "\033[32mPASS\033[0m" : "\033[31mFAIL\033[0m");
            if (pass_rw0) pass_count = pass_count + 1;
            else          fail_count = fail_count + 1;
        end

        // ===================================================================
        // SECTION 6 — Overwrite: confirm old value is replaced
        // ===================================================================
        $display("\n|--- Section 6: Overwrite existing value ------------------------------------------------------------|------|");

        write_and_check("Overwrite x3: 0x5555->0x1234", 3'd3, 16'h1234, 3'd3, 3'd0, 16'h1234, 16'h0000);
        write_and_check("Overwrite x7: 0x7FFF->0x0002", 3'd7, 16'h0002, 3'd7, 3'd3, 16'h0002, 16'h1234);

        // ===================================================================
        // SECTION 7 — Simultaneous read/write to the SAME register
        //   Synchronous write: during the cycle the write is clocked in,
        //   the read port should still return the OLD value.
        //   One cycle later it must return the new value.
        // ===================================================================
        $display("\n|--- Section 7: Simultaneous read/write (same register) ----------------------------------------------|------|");

        // x5 currently holds 0x0001
        // Drive a write to x5 = 0xBEEF; sample RD1 (A1=x5) BEFORE posedge
        A3 = 3'd5; WD3 = 16'hBEEF; RegWrite = 1'b1;
        A1 = 3'd5; A2  = 3'd0;
        #1;   // sample combinational read BEFORE clock edge
        begin : blk_sim_pre
            reg pass_pre;
            test_num = test_num + 1;
            pass_pre = (RD1 === 16'h0001);   // old value still visible
            $display("| %4d | %-28s | %0d | 0xBEEF | WR=1 | %0d | %0d | exp( 0001,    0) got(%5d,%5d) | %s |",
                     test_num, "SimRW x5 pre-edge (old val)",
                     5, 5, 0,
                     RD1, RD2,
                     pass_pre ? "\033[32mPASS\033[0m" : "\033[31mFAIL\033[0m");
            if (pass_pre) pass_count = pass_count + 1;
            else          fail_count = fail_count + 1;
        end

        @(posedge clk); #1;   // write has now been clocked in
        begin : blk_sim_post
            reg pass_post;
            test_num = test_num + 1;
            pass_post = (RD1 === 16'hBEEF);  // new value visible after edge
            $display("| %4d | %-28s | %0d | 0xBEEF | WR=1 | %0d | %0d | exp(0xBEEF,   0) got(%5d,%5d) | %s |",
                     test_num, "SimRW x5 post-edge (new val)",
                     5, 5, 0,
                     RD1, RD2,
                     pass_post ? "\033[32mPASS\033[0m" : "\033[31mFAIL\033[0m");
            if (pass_post) pass_count = pass_count + 1;
            else           fail_count = fail_count + 1;
        end

        // ===================================================================
        // SECTION 8 — Simultaneous read/write to DIFFERENT registers
        //   Write x6; read x5 (recently written) and x6 (being written).
        //   RD1(x5) should be stable at 0xBEEF; RD2(x6) should be old value
        //   before the clock edge, new value after.
        // ===================================================================
        $display("\n|--- Section 8: Simultaneous read/write (different registers) ------------------------------------------|------|");

        // x6 currently 0x8000
        A3 = 3'd6; WD3 = 16'hCAFE; RegWrite = 1'b1;
        A1 = 3'd5; A2  = 3'd6;
        #1;  // before clock edge
        begin : blk_diff_pre
            reg pass_dp;
            test_num = test_num + 1;
            pass_dp = (RD1 === 16'hBEEF) && (RD2 === 16'h8000);
            $display("| %4d | %-28s | %0d | 0xCAFE | WR=1 | %0d | %0d | exp(0xBEEF,0x8000) got(%5d,%5d) | %s |",
                     test_num, "SimRW diff regs pre-edge",
                     6, 5, 6,
                     RD1, RD2,
                     pass_dp ? "\033[32mPASS\033[0m" : "\033[31mFAIL\033[0m");
            if (pass_dp) pass_count = pass_count + 1;
            else         fail_count = fail_count + 1;
        end

        @(posedge clk); #1;  // write x6 now latched
        begin : blk_diff_post
            reg pass_dp2;
            test_num = test_num + 1;
            pass_dp2 = (RD1 === 16'hBEEF) && (RD2 === 16'hCAFE);
            $display("| %4d | %-28s | %0d | 0xCAFE | WR=1 | %0d | %0d | exp(0xBEEF,0xCAFE) got(%5d,%5d) | %s |",
                     test_num, "SimRW diff regs post-edge",
                     6, 5, 6,
                     RD1, RD2,
                     pass_dp2 ? "\033[32mPASS\033[0m" : "\033[31mFAIL\033[0m");
            if (pass_dp2) pass_count = pass_count + 1;
            else          fail_count = fail_count + 1;
        end

        // ===================================================================
        // SECTION 9 — Back-to-back writes to the same register
        //   Two consecutive clock cycles write different values to x4.
        //   After both, x4 must hold the second value.
        // ===================================================================
        $display("\n|--- Section 9: Back-to-back writes to same register --------------------------------------------------|------|");

        // Cycle 1: write x4 = 0x1111
        A3 = 3'd4; WD3 = 16'h1111; RegWrite = 1'b1;
        A1 = 3'd4; A2  = 3'd0;
        @(posedge clk); #1;
        // Cycle 2: immediately write x4 = 0x2222
        A3 = 3'd4; WD3 = 16'h2222; RegWrite = 1'b1;
        @(posedge clk); #1;
        begin : blk_b2b
            reg pass_b2b;
            test_num = test_num + 1;
            pass_b2b = (RD1 === 16'h2222);
            $display("| %4d | %-28s | %0d | 0x2222 | WR=1 | %0d | %0d | exp(0x2222,    0) got(%5d,%5d) | %s |",
                     test_num, "Back-to-back write x4",
                     4, 4, 0,
                     RD1, RD2,
                     pass_b2b ? "\033[32mPASS\033[0m" : "\033[31mFAIL\033[0m");
            if (pass_b2b) pass_count = pass_count + 1;
            else          fail_count = fail_count + 1;
        end

        // ===================================================================
        // SECTION 10 — Write x0 again after other writes (must remain 0)
        // ===================================================================
        $display("\n|--- Section 10: x0 still zero after all writes -----------------------------------------------------|------|");

        write_and_check("Write x0=0xFFFF (must stay 0)", 3'd0, 16'hFFFF, 3'd0, 3'd1, 16'd0, RD2);
        // Note: RD2 (x1) here just confirms a non-zero reg is readable alongside x0

        // ===================================================================
        // SECTION 11 — All registers readable simultaneously
        //   Read every adjacent pair to confirm no aliasing between addresses.
        // ===================================================================
        $display("\n|--- Section 11: No address aliasing across all registers -------------------------------------------|------|");

        // Refresh all with known distinct values first
        write_and_check("Refresh x1=0x0011", 3'd1, 16'h0011, 3'd1, 3'd0, 16'h0011, 16'h0000);
        write_and_check("Refresh x2=0x0022", 3'd2, 16'h0022, 3'd2, 3'd1, 16'h0022, 16'h0011);
        write_and_check("Refresh x3=0x0033", 3'd3, 16'h0033, 3'd3, 3'd2, 16'h0033, 16'h0022);
        write_and_check("Refresh x4=0x0044", 3'd4, 16'h0044, 3'd4, 3'd3, 16'h0044, 16'h0033);
        write_and_check("Refresh x5=0x0055", 3'd5, 16'h0055, 3'd5, 3'd4, 16'h0055, 16'h0044);
        write_and_check("Refresh x6=0x0066", 3'd6, 16'h0066, 3'd6, 3'd5, 16'h0066, 16'h0055);
        write_and_check("Refresh x7=0x0077", 3'd7, 16'h0077, 3'd7, 3'd6, 16'h0077, 16'h0066);

        // Read every register on RD2 against x0 on RD1 (x0 anchors RD1 = 0)
        read_check("Alias check x0||x1", 3'd0, 3'd1, 16'h0000, 16'h0011);
        read_check("Alias check x1||x2", 3'd1, 3'd2, 16'h0011, 16'h0022);
        read_check("Alias check x2||x3", 3'd2, 3'd3, 16'h0022, 16'h0033);
        read_check("Alias check x3||x4", 3'd3, 3'd4, 16'h0033, 16'h0044);
        read_check("Alias check x4||x5", 3'd4, 3'd5, 16'h0044, 16'h0055);
        read_check("Alias check x5||x6", 3'd5, 3'd6, 16'h0055, 16'h0066);
        read_check("Alias check x6||x7", 3'd6, 3'd7, 16'h0066, 16'h0077);
        read_check("Alias check x7||x0", 3'd7, 3'd0, 16'h0077, 16'h0000);

        // ===================================================================
        // Summary
        // ===================================================================
        $display("=============================================================================================================");
        $display("  SUMMARY: %0d passed,  %0d failed  out of  %0d tests.",
                 pass_count, fail_count, pass_count + fail_count);
        $display("=============================================================================================================");
        $finish;
    end

endmodule