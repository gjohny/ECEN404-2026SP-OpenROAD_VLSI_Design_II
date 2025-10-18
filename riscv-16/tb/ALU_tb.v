`timescale 1ns / 1ps

module ALU_tb;

    // Inputs
    reg [15:0] SrcA;
    reg [15:0] SrcB;
    reg [3:0] ALU_control;

    // Outputs
    wire [15:0] ALU_result;
    wire zero;

    // Expected result
    reg [15:0] expected;

    // Instantiate the ALU
    ALU uut (
        .SrcA(SrcA),
        .SrcB(SrcB),
        .ALU_control(ALU_control),
        .ALU_result(ALU_result),
        .zero(zero)
    );

    // For waveform generation
    initial begin
        $dumpfile("./waveform/ALU_tb.vcd");
        $dumpvars(0, ALU_tb);
    end

    initial begin
        $display("-----------------------------------------------------------------------------------------------");
        $display("| Instr  |   SrcA   |   SrcB   | ALU Ctrl | Expected  | ALU Result | Zero | Zero Correct? | Pass? |");
        $display("-----------------------------------------------------------------------------------------------");

        // ADD
        SrcA = 16'd10; SrcB = 16'd5; ALU_control = 4'b0000; expected = 10 + 5;
        #10 $display("| ADD    | %8d | %8d |   %b    | %8d | %10d |   %b  |      %s      |  %s  |",
                     SrcA, SrcB, ALU_control, expected, ALU_result, zero,
                     (zero == (expected == 0)) ? "YES" : "NO",
                     (ALU_result == expected) ? "YES" : "NO");

        // SUB
        ALU_control = 4'b0001; expected = 10 - 5;
        #10 $display("| SUB    | %8d | %8d |   %b    | %8d | %10d |   %b  |      %s      |  %s  |",
                     SrcA, SrcB, ALU_control, expected, ALU_result, zero,
                     (zero == (expected == 0)) ? "YES" : "NO",
                     (ALU_result == expected) ? "YES" : "NO");

        // XOR
        ALU_control = 4'b0010; expected = 10 ^ 5;
        #10 $display("| XOR    | %8d | %8d |   %b    | %8d | %10d |   %b  |      %s      |  %s  |",
                     SrcA, SrcB, ALU_control, expected, ALU_result, zero,
                     (zero == (expected == 0)) ? "YES" : "NO",
                     (ALU_result == expected) ? "YES" : "NO");

        // OR
        ALU_control = 4'b0011; expected = 10 | 5;
        #10 $display("| OR     | %8d | %8d |   %b    | %8d | %10d |   %b  |      %s      |  %s  |",
                     SrcA, SrcB, ALU_control, expected, ALU_result, zero,
                     (zero == (expected == 0)) ? "YES" : "NO",
                     (ALU_result == expected) ? "YES" : "NO");

        // AND
        ALU_control = 4'b0100; expected = 10 & 5;
        #10 $display("| AND    | %8d | %8d |   %b    | %8d | %10d |   %b  |      %s      |  %s  |",
                     SrcA, SrcB, ALU_control, expected, ALU_result, zero,
                     (zero == (expected == 0)) ? "YES" : "NO",
                     (ALU_result == expected) ? "YES" : "NO");

        // SLL
        SrcA = 16'd26; SrcB = 16'd3; ALU_control = 4'b0101; expected = 26 << 3;
        #10 $display("| SLL    | %8d | %8d |   %b    | %8d | %10d |   %b  |      %s      |  %s  |",
                     SrcA, SrcB, ALU_control, expected, ALU_result, zero,
                     (zero == (expected == 0)) ? "YES" : "NO",
                     (ALU_result == expected) ? "YES" : "NO");

        // SRL
        SrcA = 16'b1100_0000_0000_1111; SrcB = 16'd4; ALU_control = 4'b0110; expected = SrcA >> 4;
        #10 $display("| SRL    | %8d | %8d |   %b    | %8d | %10d |   %b  |      %s      |  %s  |",
                     SrcA, SrcB, ALU_control, expected, ALU_result, zero,
                     (zero == (expected == 0)) ? "YES" : "NO",
                     (ALU_result == expected) ? "YES" : "NO");

        // SRA
        SrcA = 16'b1000_0000_0000_1111; SrcB = 16'd4; ALU_control = 4'b0111; expected = $signed(SrcA) >>> 4;
        #10 $display("| SRA    | %8d | %8d |   %b    | %8d | %10d |   %b  |      %s      |  %s  |",
                     $signed(SrcA), SrcB, ALU_control, $signed(expected), $signed(ALU_result), zero,
                     (zero == (expected == 0)) ? "YES" : "NO",
                     ($signed(ALU_result) == $signed(expected)) ? "YES" : "NO");

        // JAL
        SrcA = 16'd100; ALU_control = 4'b1000; expected = 100 + 2;
        #10 $display("| JAL    | %8d | %8s |   %b    | %8d | %10d |   %b  |      %s      |  %s  |",
                     SrcA, "-", ALU_control, expected, ALU_result, zero,
                     (zero == (expected == 0)) ? "YES" : "NO",
                     (ALU_result == expected) ? "YES" : "NO");

        // Load/Store Address (ADD)
        SrcA = 16'd200; SrcB = 16'd12; ALU_control = 4'b0000; expected = 200 + 12;
        #10 $display("| LD/ST  | %8d | %8d |   %b    | %8d | %10d |   %b  |      %s      |  %s  |",
                     SrcA, SrcB, ALU_control, expected, ALU_result, zero,
                     (zero == (expected == 0)) ? "YES" : "NO",
                     (ALU_result == expected) ? "YES" : "NO");

        // Edge Case: zero result (SUB)
        SrcA = 16'd15; SrcB = 16'd15; ALU_control = 4'b0001; expected = 0;
        #10 $display("| SUB0   | %8d | %8d |   %b    | %8d | %10d |   %b  |      %s      |  %s  |",
                     SrcA, SrcB, ALU_control, expected, ALU_result, zero,
                     (zero == (expected == 0)) ? "YES" : "NO",
                     (ALU_result == expected) ? "YES" : "NO");

        $display("-----------------------------------------------------------------------------------------------");
        $display("ALU Test Bench Completed.");
        $finish;
    end

endmodule
