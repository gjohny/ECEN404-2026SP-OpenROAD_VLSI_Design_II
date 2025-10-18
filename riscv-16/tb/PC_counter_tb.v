`timescale 1ns / 1ps

module tb_pc_counter;

    // Inputs
    reg clk;
    reg reset;
    reg pc_en;
    reg branch_taken;
    reg signed [6:0] branch_imm;
    reg jal_taken;
    reg signed [9:0] jal_imm;
    reg jalr_taken;
    reg [15:0] jalr_target;
    
    // Output
    wire [15:0] pc;

    // Instantiate PC counter
    pc_counter_16 uut (
        .clk(clk),
        .reset(reset),
        .pc_en(pc_en),
        .branch_taken(branch_taken),
        .branch_imm(branch_imm),
        .jal_taken(jal_taken),
        .jal_imm(jal_imm),
        .jalr_taken(jalr_taken),
        .jalr_target(jalr_target),
        .pc(pc)
    );

    // Clock generation (10ns period = 100 MHz)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Test sequence
    initial begin
        // Waveform dump
        $dumpfile("tb_pc_counter.vcd");
        $dumpvars(0, tb_pc_counter);

        // Display header
        $display("\n========================================");
        $display("    PC Counter Testbench");
        $display("========================================\n");
        $display("Time\tPC\tOperation");
        $display("----\t----\t---------");

        // Initialize all inputs
        reset = 1;
        pc_en = 0;
        branch_taken = 0;
        branch_imm = 7'd0;
        jal_taken = 0;
        jal_imm = 10'd0;
        jalr_taken = 0;
        jalr_target = 16'h0000;

        // Wait for reset
        #15;
        reset = 0;
        pc_en = 1;
        #10;

        // Test 1: Sequential increment (PC += 2)
        $display("\n--- Test 1: Sequential Increment ---");
        repeat(8) begin
            @(posedge clk);
            #1;
            $display("%0t\t%h\tSequential (PC += 2)", $time, pc);
        end

        // Test 2: Branch forward (+10 bytes)
        $display("\n--- Test 2: Branch Forward (+10 bytes) ---");
        $display("Current PC before branch: %h", pc);
        @(negedge clk);
        branch_taken = 1;
        branch_imm = 7'sd5;  // +5 halfwords = +10 bytes
        @(posedge clk);
        #1;
        $display("%0t\t%h\tBranch taken (+10 bytes)", $time, pc);
        branch_taken = 0;
        
        repeat(3) begin
            @(posedge clk);
            #1;
            $display("%0t\t%h\tSequential", $time, pc);
        end

        // Test 3: Branch backward (-8 bytes)
        $display("\n--- Test 3: Branch Backward (-8 bytes) ---");
        $display("Current PC before branch: %h", pc);
        @(negedge clk);
        branch_taken = 1;
        branch_imm = -7'sd4;  // -4 halfwords = -8 bytes
        @(posedge clk);
        #1;
        $display("%0t\t%h\tBranch taken (-8 bytes)", $time, pc);
        branch_taken = 0;
        
        repeat(3) begin
            @(posedge clk);
            #1;
            $display("%0t\t%h\tSequential", $time, pc);
        end

        // Test 4: JAL forward (+16 bytes)
        $display("\n--- Test 4: JAL Forward (+16 bytes) ---");
        $display("Current PC before JAL: %h", pc);
        @(negedge clk);
        jal_taken = 1;
        jal_imm = 10'sd8;  // +8 halfwords = +16 bytes
        @(posedge clk);
        #1;
        $display("%0t\t%h\tJAL taken (+16 bytes)", $time, pc);
        jal_taken = 0;
        
        repeat(3) begin
            @(posedge clk);
            #1;
            $display("%0t\t%h\tSequential", $time, pc);
        end

        // Test 5: JAL backward (-12 bytes)
        $display("\n--- Test 5: JAL Backward (-12 bytes) ---");
        $display("Current PC before JAL: %h", pc);
        @(negedge clk);
        jal_taken = 1;
        jal_imm = -10'sd6;  // -6 halfwords = -12 bytes
        @(posedge clk);
        #1;
        $display("%0t\t%h\tJAL taken (-12 bytes)", $time, pc);
        jal_taken = 0;
        
        repeat(3) begin
            @(posedge clk);
            #1;
            $display("%0t\t%h\tSequential", $time, pc);
        end

        // Test 6: JALR to absolute address 0x0100
        $display("\n--- Test 6: JALR to 0x0100 ---");
        $display("Current PC before JALR: %h", pc);
        @(negedge clk);
        jalr_taken = 1;
        jalr_target = 16'h0100;
        @(posedge clk);
        #1;
        $display("%0t\t%h\tJALR to 0x0100", $time, pc);
        jalr_taken = 0;
        
        repeat(3) begin
            @(posedge clk);
            #1;
            $display("%0t\t%h\tSequential", $time, pc);
        end

        // Test 7: JALR with unaligned target (0x0055 -> should become 0x0054)
        $display("\n--- Test 7: JALR Unaligned (0x0055 -> 0x0054) ---");
        $display("Current PC before JALR: %h", pc);
        @(negedge clk);
        jalr_taken = 1;
        jalr_target = 16'h0055;  // odd address
        @(posedge clk);
        #1;
        if (pc == 16'h0054)
            $display("%0t\t%h\tJALR aligned correctly (PASS)", $time, pc);
        else
            $display("%0t\t%h\tJALR alignment FAILED (expected 0x0054)", $time, pc);
        jalr_taken = 0;
        
        repeat(2) begin
            @(posedge clk);
            #1;
            $display("%0t\t%h\tSequential", $time, pc);
        end

        // Test 8: PC stall (pc_en = 0)
        $display("\n--- Test 8: PC Stall (pc_en = 0) ---");
        $display("Current PC: %h", pc);
        @(negedge clk);
        pc_en = 0;
        repeat(5) begin
            @(posedge clk);
            #1;
            $display("%0t\t%h\tPC stalled (should not change)", $time, pc);
        end
        
        // Resume
        $display("\n--- Resuming PC (pc_en = 1) ---");
        @(negedge clk);
        pc_en = 1;
        repeat(3) begin
            @(posedge clk);
            #1;
            $display("%0t\t%h\tSequential", $time, pc);
        end

        // Test 9: Reset during operation
        $display("\n--- Test 9: Reset ---");
        $display("Current PC before reset: %h", pc);
        @(negedge clk);
        reset = 1;
        @(posedge clk);
        #1;
        $display("%0t\t%h\tReset asserted", $time, pc);
        @(negedge clk);
        reset = 0;
        @(posedge clk);
        #1;
        if (pc == 16'h0000)
            $display("%0t\t%h\tReset successful (PASS)", $time, pc);
        else
            $display("%0t\t%h\tReset FAILED (expected 0x0000)", $time, pc);
        
        repeat(3) begin
            @(posedge clk);
            #1;
            $display("%0t\t%h\tSequential after reset", $time, pc);
        end

        // Test 10: Priority test (JALR > JAL > Branch)
        $display("\n--- Test 10: Priority Test (all asserted, JALR should win) ---");
        @(negedge clk);
        branch_taken = 1;
        branch_imm = 7'sd2;
        jal_taken = 1;
        jal_imm = 10'sd4;
        jalr_taken = 1;
        jalr_target = 16'h0200;
        @(posedge clk);
        #1;
        if (pc == 16'h0200)
            $display("%0t\t%h\tJALR priority correct (PASS)", $time, pc);
        else
            $display("%0t\t%h\tPriority FAILED (expected 0x0200)", $time, pc);
        branch_taken = 0;
        jal_taken = 0;
        jalr_taken = 0;

        // End
        #50;
        $display("\n========================================");
        $display("    PC Counter Test Complete");
        $display("========================================\n");
        $finish;
    end

    // Timeout watchdog
    initial begin
        #5000;
        $display("\nERROR: Testbench timeout!");
        $finish;
    end

endmodule