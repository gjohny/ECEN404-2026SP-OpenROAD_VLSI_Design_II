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
        $dumpfile("./tb/waveform/ALU.vcd");
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

                             // =====================
        // ADD edge: wraparound (0xFFFF + 1)
        // =====================
        SrcA = 16'hFFFF; SrcB = 16'h0001; ALU_control = 4'b0000; expected = 16'h0000;
        #10 $display("| ADD_W  | %8h | %8h |   %b    | %8h | %10h |   %b  |      %s      |  %s  |",
            SrcA, SrcB, ALU_control, expected, ALU_result, zero,
            (zero == 1'b1) ? "YES" : "NO",
            (ALU_result == expected) ? "YES" : "NO");

        // =====================
        // ADD edge: signed overflow (+32767 + 1)
        // =====================
        SrcA = 16'h7FFF; SrcB = 16'h0001; ALU_control = 4'b0000; expected = 16'h8000;
        #10 $display("| ADD_SO | %8h | %8h |   %b    | %8h | %10h |   %b  |      %s      |  %s  |",
            SrcA, SrcB, ALU_control, expected, ALU_result, zero,
            (zero == (expected == 0)) ? "YES" : "NO",
            (ALU_result == expected) ? "YES" : "NO");

        // =====================
        // ADD edge: negative overflow (-32768 + -32768)
        // =====================
        SrcA = 16'h8000; SrcB = 16'h8000; ALU_control = 4'b0000; expected = 16'h0000;
        #10 $display("| ADD_NO | %8h | %8h |   %b    | %8h | %10h |   %b  |      %s      |  %s  |",
            SrcA, SrcB, ALU_control, expected, ALU_result, zero,
            (zero == 1'b1) ? "YES" : "NO",
            (ALU_result == expected) ? "YES" : "NO");

        // =====================
        // ADD edge: cross-sign cancel
        // =====================
        SrcA = 16'h8000; SrcB = 16'h7FFF; ALU_control = 4'b0000; expected = 16'hFFFF;
        #10 $display("| ADD_X  | %8h | %8h |   %b    | %8h | %10h |   %b  |      %s      |  %s  |",
            SrcA, SrcB, ALU_control, expected, ALU_result, zero,
            (zero == (expected == 0)) ? "YES" : "NO",
            (ALU_result == expected) ? "YES" : "NO");

        // -------------------
        // SUB TEST CASES 
        // -------------------

        // SUB - normal
        SrcA = 16'd10; SrcB = 16'd5; ALU_control = 4'b0001; 
        expected = (SrcA - SrcB) & 16'hFFFF; 
        #10 $display("| SUB    | %8h | %8h |   %b    | %8h | %10h |   %b  |      %s      |  %s  |",
                    SrcA, SrcB, ALU_control, expected, ALU_result, zero,
                    (zero == (expected == 0)) ? "YES" : "NO",
                    (ALU_result == expected) ? "YES" : "NO");

        // SUB - zero result
        SrcA = 16'd15; SrcB = 16'd15; ALU_control = 4'b0001;
        expected = (SrcA - SrcB) & 16'hFFFF;
        #10 $display("| SUB0   | %8h | %8h |   %b    | %8h | %10h |   %b  |      %s      |  %s  |",
                    SrcA, SrcB, ALU_control, expected, ALU_result, zero,
                    (zero == (expected == 0)) ? "YES" : "NO",
                    (ALU_result == expected) ? "YES" : "NO");

        // SUB - underflow / wraparound
        SrcA = 16'd0; SrcB = 16'd1; ALU_control = 4'b0001;
        expected = (SrcA - SrcB) & 16'hFFFF; 
        #10 $display("| SUB_UF | %8h | %8h |   %b    | %8h | %10h |   %b  |      %s      |  %s  |",
                    SrcA, SrcB, ALU_control, expected, ALU_result, zero,
                    (zero == (expected == 0)) ? "YES" : "NO",
                    (ALU_result == expected) ? "YES" : "NO");

        // SUB - large numbers
        SrcA = 16'h8000; SrcB = 16'h7FFF; ALU_control = 4'b0001;
        expected = (SrcA - SrcB) & 16'hFFFF;
        #10 $display("| SUB_L  | %8h | %8h |   %b    | %8h | %10h |   %b  |      %s      |  %s  |",
                    SrcA, SrcB, ALU_control, expected, ALU_result, zero,
                    (zero == (expected == 0)) ? "YES" : "NO",
                    (ALU_result == expected) ? "YES" : "NO");

        // SUB - max value minus zero
        SrcA = 16'hFFFF; SrcB = 16'h0000; ALU_control = 4'b0001;
        expected = (SrcA - SrcB) & 16'hFFFF;
        #10 $display("| SUB_M0 | %8h | %8h |   %b    | %8h | %10h |   %b  |      %s      |  %s  |",
                    SrcA, SrcB, ALU_control, expected, ALU_result, zero,
                    (zero == (expected == 0)) ? "YES" : "NO",
                    (ALU_result == expected) ? "YES" : "NO");

        // SUB - zero minus max value (wraparound)
        SrcA = 16'h0000; SrcB = 16'hFFFF; ALU_control = 4'b0001;
        expected = (SrcA - SrcB) & 16'hFFFF;
        #10 $display("| SUB_0M | %8h | %8h |   %b    | %8h | %10h |   %b  |      %s      |  %s  |",
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
