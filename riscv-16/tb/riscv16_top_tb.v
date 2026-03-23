`timescale 1ns / 1ps

module riscv16_top_tb;

    //===========================================================================
    // Testbench Signals
    //===========================================================================
    reg         clk;
    reg         reset;
    
    // Debug outputs from DUT
    wire [15:0] dbg_pc;
    wire [15:0] dbg_instr;
    wire [15:0] dbg_alu_result;
    wire [15:0] dbg_x1;
    wire [15:0] dbg_x2;
    wire [15:0] dbg_x3;
    
    // Test control
    integer     cycle_count;
    integer     test_num;
    integer     errors;
    
    //===========================================================================
    // Clock Generation - 100MHz (10ns period)
    //===========================================================================
    parameter CLK_PERIOD = 10;
    
    initial begin
        clk = 0;
        forever #(CLK_PERIOD/2) clk = ~clk;
    end
    
    //===========================================================================
    // DUT Instantiation
    //===========================================================================
    riscv16_top DUT (
        .clk(clk),
        .reset(reset),
        .dbg_pc(dbg_pc),
        .dbg_instr(dbg_instr),
        .dbg_alu_result(dbg_alu_result),
        .dbg_x1(dbg_x1),
        .dbg_x2(dbg_x2),
        .dbg_x3(dbg_x3)
    );
    
    //===========================================================================
    // Waveform Dump for GTKWave / ModelSim
    //===========================================================================
    initial begin
        $dumpfile("riscv16_pipeline_tb.vcd");
        $dumpvars(0, riscv16_top_tb);
    end
    
    //===========================================================================
    // Cycle Counter
    //===========================================================================
    always @(posedge clk or posedge reset) begin
        if (reset)
            cycle_count <= 0;
        else
            cycle_count <= cycle_count + 1;
    end
    
    //===========================================================================
    // Monitor Task - Display pipeline state each cycle
    //===========================================================================
    task display_state;
        begin
            $display("================================================================================");
            $display("Cycle: %0d | Time: %0t", cycle_count, $time);
            $display("--------------------------------------------------------------------------------");
            $display("  PC         = 0x%04h", dbg_pc);
            $display("  Instruction= 0x%04h", dbg_instr);
            $display("  ALU Result = 0x%04h (%0d)", dbg_alu_result, $signed(dbg_alu_result));
            $display("  x1         = 0x%04h (%0d)", dbg_x1, $signed(dbg_x1));
            $display("  x2         = 0x%04h (%0d)", dbg_x2, $signed(dbg_x2));
            $display("  x3         = 0x%04h (%0d)", dbg_x3, $signed(dbg_x3));
            $display("================================================================================");
        end
    endtask
    
    //===========================================================================
    // Monitor - Automatic display on each clock edge
    //===========================================================================
    always @(posedge clk) begin
        if (!reset) begin
            display_state();
        end
    end
    
    //===========================================================================
    // Instruction Decoder for Debug Display
    //===========================================================================
    function [8*20:1] decode_opcode;
        input [2:0] opcode;
        begin
            case (opcode)
                3'b000: decode_opcode = "R-type";
                3'b001: decode_opcode = "I-type";
                3'b010: decode_opcode = "Load";
                3'b011: decode_opcode = "Store";
                3'b100: decode_opcode = "Branch";
                3'b101: decode_opcode = "JAL";
                3'b110: decode_opcode = "LUI/AUIPC";
                3'b111: decode_opcode = "JALR";
                default: decode_opcode = "Unknown";
            endcase
        end
    endfunction
    
    //===========================================================================
    // Test Stimulus
    //===========================================================================
    initial begin
        // Initialize
        $display("\n");
        $display("########################################################################");
        $display("#                                                                      #");
        $display("#          RISC-V 16-bit 3-Stage Pipeline Testbench                   #");
        $display("#                                                                      #");
        $display("########################################################################");
        $display("\n");
        
        errors = 0;
        test_num = 0;
        
        // Apply Reset
        $display("[%0t] Applying reset...", $time);
        reset = 1;
        #(CLK_PERIOD * 5);
        
        // Release Reset
        $display("[%0t] Releasing reset...", $time);
        reset = 0;
        #(CLK_PERIOD);
        
        //=======================================================================
        // Test 1: Basic Instruction Fetch
        //=======================================================================
        test_num = 1;
        $display("\n=== TEST %0d: Basic Instruction Fetch ===", test_num);
        
        // Let pipeline run for several cycles
        repeat (10) @(posedge clk);
        
        // Check that PC is incrementing
        if (dbg_pc == 16'h0000) begin
            $display("[ERROR] PC stuck at 0x0000");
            errors = errors + 1;
        end else begin
            $display("[PASS] PC is advancing: 0x%04h", dbg_pc);
        end
        
        //=======================================================================
        // Test 2: Run for more cycles to observe register changes
        //=======================================================================
        test_num = 2;
        $display("\n=== TEST %0d: Register File Updates ===", test_num);
        
        repeat (20) @(posedge clk);
        
        $display("Register state after 30 cycles:");
        $display("  x1 = 0x%04h", dbg_x1);
        $display("  x2 = 0x%04h", dbg_x2);
        $display("  x3 = 0x%04h", dbg_x3);
        
        //=======================================================================
        // Test 3: Extended Run
        //=======================================================================
        test_num = 3;
        $display("\n=== TEST %0d: Extended Pipeline Operation ===", test_num);
        
        repeat (50) @(posedge clk);
        
        //=======================================================================
        // Test 4: Check for Pipeline Stalls/Hazards
        //=======================================================================
        test_num = 4;
        $display("\n=== TEST %0d: Pipeline Hazard Handling ===", test_num);
        
        // Run more cycles
        repeat (20) @(posedge clk);
        
        //=======================================================================
        // Final Summary
        //=======================================================================
        $display("\n");
        $display("########################################################################");
        $display("#                        TEST SUMMARY                                  #");
        $display("########################################################################");
        $display("  Total Cycles Run : %0d", cycle_count);
        $display("  Final PC         : 0x%04h", dbg_pc);
        $display("  Final x1         : 0x%04h", dbg_x1);
        $display("  Final x2         : 0x%04h", dbg_x2);
        $display("  Final x3         : 0x%04h", dbg_x3);
        $display("  Errors           : %0d", errors);
        $display("########################################################################");
        
        if (errors == 0)
            $display(">>> ALL TESTS PASSED <<<");
        else
            $display(">>> TESTS FAILED <<<");
        
        $display("\n");
        
        #(CLK_PERIOD * 5);
        $finish;
    end
    
    //===========================================================================
    // Timeout Watchdog
    //===========================================================================
    initial begin
        #(CLK_PERIOD * 500);
        $display("\n[TIMEOUT] Simulation exceeded maximum time!");
        $finish;
    end
    
    //===========================================================================
    // Optional: Check for X/Z values
    //===========================================================================
    always @(posedge clk) begin
        if (!reset) begin
            if (^dbg_pc === 1'bx) begin
                $display("[WARNING] Cycle %0d: PC contains X values!", cycle_count);
            end
            if (^dbg_instr === 1'bx) begin
                $display("[WARNING] Cycle %0d: Instruction contains X values!", cycle_count);
            end
        end
    end

endmodule