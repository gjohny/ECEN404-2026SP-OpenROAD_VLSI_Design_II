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

    // Helper task to print table rows
    task print_row;
        input [63:0] time_val;
        input [15:0] pc_val;
        input [127:0] operation;
        input pass_fail;  // 0=normal, 1=PASS, 2=FAIL
        begin
            if (pass_fail == 1)
                $display("| %6d | 0x%04h | %-35s | PASS |", time_val, pc_val, operation);
            else if (pass_fail == 2)
                $display("| %6d | 0x%04h | %-35s | FAIL |", time_val, pc_val, operation);
            else
                $display("| %6d | 0x%04h | %-35s |      |", time_val, pc_val, operation);
        end
    endtask

    task print_separator;
        begin
            $display("+--------+--------+-------------------------------------+------+");
        end
    endtask

    task print_header;
        input [255:0] title;
        begin
            $display("\n+--------+--------+-------------------------------------+------+");
            $display("|                     %-43s |", title);
            print_separator();
            $display("|  Time  |   PC   |             Operation               |Status|");
            print_separator();
        end
    endtask

    // Test sequence
    initial begin
        // Waveform dump
        $dumpfile("tb_pc_counter.vcd");
        $dumpvars(0, tb_pc_counter);

        // Initialize all inputs
        reset = 1;
        pc_en = 0;
        branch_taken = 0;
        branch_imm = 7'd0;
        jal_taken = 0;
        jal_imm = 10'd0;
        jalr_taken = 0;
        jalr_target = 16'h0000;

        // Wait for reset to stabilize
        #12;
        @(negedge clk);
        reset = 0;
        pc_en = 1;
        
        // Wait one full cycle after reset deassertion
        @(posedge clk);
        @(posedge clk);
        #1;

        // Test 1: Sequential increment
        print_header("Test 1: Sequential Increment (PC += 2)");
        repeat(8) begin
            print_row($time, pc, "Sequential", 0);
            @(posedge clk);
            #1;
        end
        print_separator();

        // Test 2: Branch forward
        print_header("Test 2: Branch Forward (+10 bytes)");
        $display("| Current PC before branch: 0x%04h                              |", pc);
        print_separator();
        @(negedge clk);
        branch_taken = 1;
        branch_imm = 7'sd5;
        @(posedge clk);
        #1;
        print_row($time, pc, "Branch taken (+10 bytes)", 0);
        branch_taken = 0;
        repeat(3) begin
            @(posedge clk);
            #1;
            print_row($time, pc, "Sequential", 0);
        end
        print_separator();

        // Test 3: Branch backward
        print_header("Test 3: Branch Backward (-8 bytes)");
        $display("| Current PC before branch: 0x%04h                              |", pc);
        print_separator();
        @(negedge clk);
        branch_taken = 1;
        branch_imm = -7'sd4;
        @(posedge clk);
        #1;
        print_row($time, pc, "Branch taken (-8 bytes)", 0);
        branch_taken = 0;
        repeat(3) begin
            @(posedge clk);
            #1;
            print_row($time, pc, "Sequential", 0);
        end
        print_separator();

        // Test 4: JAL forward
        print_header("Test 4: JAL Forward (+16 bytes)");
        $display("| Current PC before JAL: 0x%04h                                 |", pc);
        print_separator();
        @(negedge clk);
        jal_taken = 1;
        jal_imm = 10'sd8;
        @(posedge clk);
        #1;
        print_row($time, pc, "JAL taken (+16 bytes)", 0);
        jal_taken = 0;
        repeat(3) begin
            @(posedge clk);
            #1;
            print_row($time, pc, "Sequential", 0);
        end
        print_separator();

        // Test 5: JAL backward
        print_header("Test 5: JAL Backward (-12 bytes)");
        $display("| Current PC before JAL: 0x%04h                                 |", pc);
        print_separator();
        @(negedge clk);
        jal_taken = 1;
        jal_imm = -10'sd6;
        @(posedge clk);
        #1;
        print_row($time, pc, "JAL taken (-12 bytes)", 0);
        jal_taken = 0;
        repeat(3) begin
            @(posedge clk);
            #1;
            print_row($time, pc, "Sequential", 0);
        end
        print_separator();

        // Test 6: JALR absolute
        print_header("Test 6: JALR to 0x0100");
        $display("| Current PC before JALR: 0x%04h                                |", pc);
        print_separator();
        @(negedge clk);
        jalr_taken = 1;
        jalr_target = 16'h0100;
        @(posedge clk);
        #1;
        print_row($time, pc, "JALR to 0x0100", 0);
        jalr_taken = 0;
        repeat(3) begin
            @(posedge clk);
            #1;
            print_row($time, pc, "Sequential", 0);
        end
        print_separator();

        // Test 7: JALR unaligned
        print_header("Test 7: JALR Unaligned (0x0055 -> 0x0054)");
        $display("| Current PC before JALR: 0x%04h                                |", pc);
        print_separator();
        @(negedge clk);
        jalr_taken = 1;
        jalr_target = 16'h0055;
        @(posedge clk);
        #1;
        if (pc == 16'h0054)
            print_row($time, pc, "JALR aligned correctly", 1);
        else
            print_row($time, pc, "JALR alignment FAILED", 2);
        jalr_taken = 0;
        repeat(2) begin
            @(posedge clk);
            #1;
            print_row($time, pc, "Sequential", 0);
        end
        print_separator();

        // Test 8: PC stall
        print_header("Test 8: PC Stall (pc_en = 0)");
        $display("| Current PC: 0x%04h                                            |", pc);
        print_separator();
        @(negedge clk);
        pc_en = 0;
        repeat(5) begin
            @(posedge clk);
            #1;
            print_row($time, pc, "PC stalled", 0);
        end
        print_separator();
        
        // Resume
        $display("\n| Resuming PC (pc_en = 1)                                          |");
        print_separator();
        @(negedge clk);
        pc_en = 1;
        repeat(3) begin
            @(posedge clk);
            #1;
            print_row($time, pc, "Sequential", 0);
        end
        print_separator();

        // Test 9: Reset
        print_header("Test 9: Reset");
        $display("| Current PC before reset: 0x%04h                               |", pc);
        print_separator();
        @(negedge clk);
        reset = 1;
        @(posedge clk);
        #1;
        print_row($time, pc, "Reset asserted", 0);
        
        @(negedge clk);
        reset = 0;
        @(posedge clk);
        #1;
        if (pc == 16'h0000)
            print_row($time, pc, "PC at 0x0000 after reset", 1);
        else
            print_row($time, pc, "Reset verification", 2);
        
        repeat(3) begin
            @(posedge clk);
            #1;
            print_row($time, pc, "Sequential after reset", 0);
        end
        print_separator();

        // Test 10: Priority
        print_header("Test 10: Priority (JALR > JAL > Branch)");
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
            print_row($time, pc, "JALR priority correct", 1);
        else
            print_row($time, pc, "Priority test FAILED", 2);
        branch_taken = 0;
        jal_taken = 0;
        jalr_taken = 0;
        print_separator();

        // End
        #50;
        $display("\n+========================================+");
        $display("|     PC Counter Test Complete           |");
        $display("+========================================+\n");
        $finish;
    end

    // Timeout watchdog
    initial begin
        #10000;
        $display("\nERROR: Testbench timeout!");
        $finish;
    end

endmodule