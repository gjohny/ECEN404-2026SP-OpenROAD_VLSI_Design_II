`timescale 1ns / 1ps

module top_tb;

    // -------------------------------------------------------------------------
    // DUT wiring
    // -------------------------------------------------------------------------
    reg clk;
    reg reset;
    wire [15:0] dbg_pc;
    wire [15:0] dbg_instr;

    top DUT (
        .clk(clk),
        .reset(reset),
        .dbg_pc(dbg_pc),
        .dbg_instr(dbg_instr),
        .dbg_alu_result(dbg_alu_result)
    );

    // -------------------------------------------------------------------------
    // Direct taps into internal register file
    // -------------------------------------------------------------------------
    wire [15:0] dbg_x0 = DUT.RF.reg_array[0];
    wire [15:0] dbg_x1 = DUT.RF.reg_array[1];
    wire [15:0] dbg_x2 = DUT.RF.reg_array[2];
    wire [15:0] dbg_x3 = DUT.RF.reg_array[3];
    wire [15:0] dbg_x4 = DUT.RF.reg_array[4];
    wire [15:0] dbg_x5 = DUT.RF.reg_array[5];
    wire [15:0] dbg_x6 = DUT.RF.reg_array[6];
    wire [15:0] dbg_x7 = DUT.RF.reg_array[7];

    reg [15:0] expected_x1_value [0:255]; // store expected value for x1
    reg [7:0] instr_queue [0:255];        // store destination reg number
    integer head = 0;
    integer tail = 0;

    always @(posedge clk) begin
        if (!reset) begin
            // Example: check if the instruction writes to x1
            // Suppose EX_ALUResult is the value to write and dbg_instr encodes destination in bits [3:0] (adjust as needed)
            if (/* instruction writes to x1 */ dbg_instr[3:0] == 1) begin
                instr_queue[tail] <= 1;           // x1 target
                expected_x1_value[tail] <= dbg_alu_result; // value to write
                tail <= tail + 1;
            end
        end
    end

    always @(posedge clk) begin
        if (!reset && head != tail) begin
            // Check x1 4 cycles after instruction
            if ($time >= 4*10) begin // 4 cycles at 10ns period, adjust as needed
                if (dbg_x1 !== expected_x1_value[head]) begin
                    $display("❌ Error: x1 = %04X, expected %04X at time %0t", dbg_x1, expected_x1_value[head], $time);
                end else begin
                    $display("✅ x1 correctly updated to %04X at time %0t", dbg_x1, $time);
                end
                head <= head + 1;
            end
        end
    end

    // -------------------------------------------------------------------------
    // Clock generation
    // -------------------------------------------------------------------------
    initial clk = 0;
    always #5 clk = ~clk;

    // -------------------------------------------------------------------------
    // Waveform dump
    // -------------------------------------------------------------------------
    initial begin
        $dumpfile("./tb/waveform/top.vcd");
        $dumpvars(0, top_tb);
    end

    // -------------------------------------------------------------------------
    // Main test sequence
    // -------------------------------------------------------------------------
    initial begin
        reset = 1;
        repeat(4) @(posedge clk);
        reset = 0;
        $display("\n=== Reset released, starting trace ===\n");

        // Run for N cycles
        repeat(100) @(posedge clk);
        $display("\n=== Simulation complete ===");
        $finish;
    end

    // -------------------------------------------------------------------------
    // Trace every clock cycle
    // -------------------------------------------------------------------------
    always @(posedge clk) begin
        if (!reset) begin
            $display("%0t | PC=%04X | INSTR=%04X | ALU=%04X | x0=%04X x1=%04X x2=%04X x3=%04X x4=%04X x5=%04X x6=%04X x7=%04X",
                     $time, dbg_pc, dbg_instr, dbg_alu_result,
                     dbg_x0, dbg_x1, dbg_x2, dbg_x3,
                     dbg_x4, dbg_x5, dbg_x6, dbg_x7);
        end
    end

endmodule