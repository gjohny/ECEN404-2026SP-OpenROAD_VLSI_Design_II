`timescale 1ns / 1ps

module Control_Unit_tb;

    // Inputs
    reg [2:0] opcode;
    reg [3:0] func;
    reg       zero;
    reg       clk;

    // Outputs
    wire PCSrc;
    wire ResultSrc;
    wire MemWrite;
    wire [3:0] ALUControl;
    wire ALUSrc;
    wire [1:0] ImmSrc;
    wire RegWrite;

    // Instantiate DUT
    Control_Unit uut (
        .opcode(opcode),
        .func(func),
        .zero(zero),
        .PCSrc(PCSrc),
        .ResultSrc(ResultSrc),
        .MemWrite(MemWrite),
        .ALUControl(ALUControl),
        .ALUSrc(ALUSrc),
        .ImmSrc(ImmSrc),
        .RegWrite(RegWrite)
    );

    // Clock generation (10ns period)
    always #5 clk = ~clk;

    // Waveform dump
    initial begin
        $dumpfile("./waveform/Control_unit.vcd");
        $dumpvars(0, Control_Unit_tb);
    end

    // Display header
    initial begin
        $display("==================================================================================================================");
        $display("Time | Opcode | Func | Zero | PCSrc | ResultSrc | MemWrite | ALUControl | ALUSrc | ImmSrc | RegWrite | Instruction");
        $display("==================================================================================================================");
    end

    // Task to show signals and check expected outputs
    task show_ctrl;
        input [255:0] instr_name;
        input exp_PCSrc, exp_ResultSrc, exp_MemWrite;
        input [3:0] exp_ALUControl;
        input exp_ALUSrc;
        input [1:0] exp_ImmSrc;
        input exp_RegWrite;
        reg pass;
        begin
            #1;
            $display("%4t |  %03b   | %04b |  %b   |   %b   |     %b     |    %b     |   %04b     |   %b   |   %02b   |    %b     | %s",
                     $time, opcode, func, zero, PCSrc, ResultSrc, MemWrite,
                     ALUControl, ALUSrc, ImmSrc, RegWrite, instr_name);

            pass = (PCSrc === exp_PCSrc) && (ResultSrc === exp_ResultSrc) && 
                   (MemWrite === exp_MemWrite) && (ALUControl === exp_ALUControl) &&
                   (ALUSrc === exp_ALUSrc) && (ImmSrc === exp_ImmSrc) &&
                   (RegWrite === exp_RegWrite);

            if (pass)
                $display("Result: \033[32mPASSED\033[0m\n");   // Green
            else
                $display("Result: \033[31mFAILED\033[0m\n");   // Red
        end
    endtask

    // Stimulus
    initial begin
        clk = 0;
        opcode = 3'b000;
        func   = 4'b0000;
        zero   = 0;

        // --- R-type instructions ---
        @(posedge clk); opcode = 3'b000; func = 4'b0000; show_ctrl("ADD", 0,0,0,4'b0000,0,2'b00,1);
        @(posedge clk); opcode = 3'b000; func = 4'b0001; show_ctrl("SUB", 0,0,0,4'b0001,0,2'b00,1);
        @(posedge clk); opcode = 3'b000; func = 4'b0010; show_ctrl("XOR", 0,0,0,4'b0010,0,2'b00,1);
        @(posedge clk); opcode = 3'b000; func = 4'b0011; show_ctrl("OR", 0,0,0,4'b0011,0,2'b00,1);
        @(posedge clk); opcode = 3'b000; func = 4'b0100; show_ctrl("AND", 0,0,0,4'b0100,0,2'b00,1);
        @(posedge clk); opcode = 3'b000; func = 4'b0101; show_ctrl("SLL", 0,0,0,4'b0101,0,2'b00,1);

        // --- I-type instructions ---
        @(posedge clk); opcode = 3'b001; func = 4'b0000; show_ctrl("ADDI", 0,0,0,4'b0000,1,2'b00,1);
        @(posedge clk); opcode = 3'b001; func = 4'b0001; show_ctrl("XORI", 0,0,0,4'b0010,1,2'b00,1);
        @(posedge clk); opcode = 3'b001; func = 4'b0010; show_ctrl("ORI", 0,0,0,4'b0011,1,2'b00,1);
        @(posedge clk); opcode = 3'b001; func = 4'b0011; show_ctrl("ANDI", 0,0,0,4'b0100,1,2'b00,1);
        @(posedge clk); opcode = 3'b001; func = 4'b1101; show_ctrl("JALR", 1,0,0,4'b0000,1,2'b00,1);

        // --- Load/Store ---
        @(posedge clk); opcode = 3'b010; func = 4'b0000; show_ctrl("LW", 0,1,0,4'b0000,1,2'b00,1);
        @(posedge clk); opcode = 3'b011; func = 4'b0000; show_ctrl("SW", 0,0,1,4'b0000,1,2'b00,0);

        // --- Branches ---
        @(posedge clk); zero = 1; opcode = 3'b100; func = 4'b0000; show_ctrl("BEQ (taken)", 1,0,0,4'b0001,0,2'b01,0);
        @(posedge clk); zero = 0; opcode = 3'b100; func = 4'b0000; show_ctrl("BEQ (not taken)", 0,0,0,4'b0001,0,2'b01,0);
        @(posedge clk); zero = 1; opcode = 3'b100; func = 4'b0001; show_ctrl("BNE (not taken)", 0,0,0,4'b0001,0,2'b01,0);
        @(posedge clk); zero = 0; opcode = 3'b100; func = 4'b0001; show_ctrl("BNE (taken)", 1,0,0,4'b0001,0,2'b01,0);

        // --- JAL ---
        @(posedge clk); opcode = 3'b101; func = 4'b0000; show_ctrl("JAL", 1,0,0,4'b0000,1,2'b10,1);

        @(posedge clk);
        $display("==================================================================================================================");
        $finish;
    end

endmodule
