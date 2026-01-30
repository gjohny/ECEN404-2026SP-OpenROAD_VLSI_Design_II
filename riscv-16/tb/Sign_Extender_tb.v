`timescale 1ns / 1ps
module Sign_Extender_tb;

    reg  [15:0] instr;
    reg  [2:0]  ImmSrc;    
    wire [15:0] ImmExt;

    Sign_Extender uut (
        .instr(instr),
        .ImmSrc(ImmSrc),
        .ImmExt(ImmExt)
    );

    // For waveform generation
    initial begin
        $dumpfile("./tb/waveform/Sign_Extender.vcd");
        $dumpvars(0, Sign_Extender_tb);
    end

    reg [15:0] expected;
    reg [8*8-1:0] instr_type; 

    initial begin
        
        $display("Instr               ImmSrc   Type      ImmExt               Expected             Pass");
        $display("-------------------------------------------------------------------------------------------");

        
// ---------------------- R-TYPE EDGE CASES ----------------------

        // All zeros 
        instr = 16'b0000000000000000; ImmSrc = 3'b000; instr_type = "R-TYPE"; expected = 16'b0; #10;
        $display("%-18b  %-7b  %-8s  %-18b  %-18b  %b", instr, ImmSrc, instr_type, ImmExt, expected, (ImmExt==expected));

        // All ones
        instr = 16'b1111111111111111; ImmSrc = 3'b000; instr_type = "R-TYPE"; expected = 16'b0; #10;
        $display("%-18b  %-7b  %-8s  %-18b  %-18b  %b", instr, ImmSrc, instr_type, ImmExt, expected, (ImmExt==expected));

        // Alternating bits 1010...
        instr = 16'b1010101010101010; ImmSrc = 3'b000; instr_type = "R-TYPE"; expected = 16'b0; #10;
        $display("%-18b  %-7b  %-8s  %-18b  %-18b  %b", instr, ImmSrc, instr_type, ImmExt, expected, (ImmExt==expected));

        // Alternating bits 0101...
        instr = 16'b0101010101010101; ImmSrc = 3'b000; instr_type = "R-TYPE"; expected = 16'b0; #10;
        $display("%-18b  %-7b  %-8s  %-18b  %-18b  %b", instr, ImmSrc, instr_type, ImmExt, expected, (ImmExt==expected));

        // Max positive 15-bit number in lower bits - Sign Extension check
        instr = 16'b0000111111111111; ImmSrc = 3'b000; instr_type = "R-TYPE"; expected = 16'b0; #10;
        $display("%-18b  %-7b  %-8s  %-18b  %-18b  %b", instr, ImmSrc, instr_type, ImmExt, expected, (ImmExt==expected));

        // Max negative 16-bit number
        instr = 16'b1000000000000000; ImmSrc = 3'b000; instr_type = "R-TYPE"; expected = 16'b0; #10;
        $display("%-18b  %-7b  %-8s  %-18b  %-18b  %b", instr, ImmSrc, instr_type, ImmExt, expected, (ImmExt==expected));


                // ---------------------- I-TYPE EDGE CASES ----------------------
        ImmSrc = 3'b001; instr_type = "I-TYPE";

        // Positive immediates
        instr = 16'b0000000000000000; expected = 16'b0000000000000000; #10;
        $display("%-18b  %-7b  %-8s  %-18b  %-18b  %b", instr, ImmSrc, instr_type, ImmExt, expected, (ImmExt==expected));

        instr = 16'b0010000000000000; expected = 16'b0000000000000001; #10;
        $display("%-18b  %-7b  %-8s  %-18b  %-18b  %b", instr, ImmSrc, instr_type, ImmExt, expected, (ImmExt==expected));

        instr = 16'b0100000000000000; expected = 16'b0000000000000010; #10;
        $display("%-18b  %-7b  %-8s  %-18b  %-18b  %b", instr, ImmSrc, instr_type, ImmExt, expected, (ImmExt==expected));

        instr = 16'b0110000000000000; expected = 16'b0000000000000011; #10;
        $display("%-18b  %-7b  %-8s  %-18b  %-18b  %b", instr, ImmSrc, instr_type, ImmExt, expected, (ImmExt==expected));

        // Negative immediates
        instr = 16'b1000000000000000; expected = 16'b1111111111111100; #10; // -4
        $display("%-18b  %-7b  %-8s  %-18b  %-18b  %b", instr, ImmSrc, instr_type, ImmExt, expected, (ImmExt==expected));

        instr = 16'b1010000000000000; expected = 16'b1111111111111101; #10; // -3
        $display("%-18b  %-7b  %-8s  %-18b  %-18b  %b", instr, ImmSrc, instr_type, ImmExt, expected, (ImmExt==expected));

        instr = 16'b1100000000000000; expected = 16'b1111111111111110; #10; // -2
        $display("%-18b  %-7b  %-8s  %-18b  %-18b  %b", instr, ImmSrc, instr_type, ImmExt, expected, (ImmExt==expected));

        instr = 16'b1110000000000000; expected = 16'b1111111111111111; #10; // -1
        $display("%-18b  %-7b  %-8s  %-18b  %-18b  %b", instr, ImmSrc, instr_type, ImmExt, expected, (ImmExt==expected));


        
        // ----------------------  S-TYPE (positive and negative edge cases) ----------------------
        // Case 1: largest positive number
        instr = 16'b0111111000000000; ImmSrc = 3'b010; instr_type = "S-TYPE"; expected = 16'b0000000000111111; #10;
        $display("%-18b  %-7b  %-8s  %-18b  %-18b  %b", instr, ImmSrc, instr_type, ImmExt, expected, (ImmExt==expected));

        // Case 2: largest negative number
        instr = 16'b1000000000000000; ImmSrc = 3'b010; instr_type = "S-TYPE"; expected = 16'b1111111111000000; #10;
        $display("%-18b  %-7b  %-8s  %-18b  %-18b  %b", instr, ImmSrc, instr_type, ImmExt, expected, (ImmExt==expected));

        // Case 3: smallest positive number
        instr = 16'b0000001000000000; ImmSrc = 3'b010; instr_type = "S-TYPE"; expected = 16'b0000000000000001; #10;
        $display("%-18b  %-7b  %-8s  %-18b  %-18b  %b", instr, ImmSrc, instr_type, ImmExt, expected, (ImmExt==expected));

        // Case 4: small negative number
        instr = 16'b1000001000000000; ImmSrc = 3'b010; instr_type = "S-TYPE"; expected = 16'b1111111111000001; #10;
        $display("%-18b  %-7b  %-8s  %-18b  %-18b  %b", instr, ImmSrc, instr_type, ImmExt, expected, (ImmExt==expected));

        // Case 5: typical middle value
        instr = 16'b0010101000000000; ImmSrc = 3'b010; instr_type = "S-TYPE"; expected = 16'b0000000000010101; #10;
        $display("%-18b  %-7b  %-8s  %-18b  %-18b  %b", instr, ImmSrc, instr_type, ImmExt, expected, (ImmExt==expected));


        
        // ----------------------  B-TYPE (positive)  ----------------------
        instr = 16'b0010101000000000; ImmSrc = 3'b011; instr_type = "B-TYPE"; expected = 16'b0000000000010101; #10;
        $display("%-18b  %-7b  %-8s  %-18b  %-18b  %b", instr, ImmSrc, instr_type, ImmExt, expected, (ImmExt==expected));

        //  ----------------------  B-TYPE (negative) ----------------------
        instr = 16'b1010101000000000; ImmSrc = 3'b011; instr_type = "B-TYPE"; expected = 16'b1111111111010101; #10;
        $display("%-18b  %-7b  %-8s  %-18b  %-18b  %b", instr, ImmSrc, instr_type, ImmExt, expected, (ImmExt==expected));

         
        // ----------------------  U-TYPE (positive). ----------------------
        instr = 16'b0001100011110000; ImmSrc = 3'b100; instr_type = "U-TYPE"; expected = 16'b0001100011110000; #10;
        $display("%-18b  %-7b  %-8s  %-18b  %-18b  %b", instr, ImmSrc, instr_type, ImmExt, expected, (ImmExt==expected));

        // ----------------------  U-TYPE (negative). ----------------------
        instr = 16'b1001100011110000; ImmSrc = 3'b100; instr_type = "U-TYPE"; expected = 16'b1001100011110000; #10;
        $display("%-18b  %-7b  %-8s  %-18b  %-18b  %b", instr, ImmSrc, instr_type, ImmExt, expected, (ImmExt==expected));

        
        //----------------------  J-TYPE (positive)  ----------------------
        instr = 16'b0001111000010000; ImmSrc = 3'b101; instr_type = "J-TYPE"; expected = 16'b0001111000000000; #10;
        $display("%-18b  %-7b  %-8s  %-18b  %-18b  %b", instr, ImmSrc, instr_type, ImmExt, expected, (ImmExt==expected));

        // ---------------------- J-TYPE (negative). ----------------------
        instr = 16'b1001111000010000; ImmSrc = 3'b101; instr_type = "J-TYPE"; expected = 16'b1001111000000000; #10;
        $display("%-18b  %-7b  %-8s  %-18b  %-18b  %b", instr, ImmSrc, instr_type, ImmExt, expected, (ImmExt==expected));

        
        //  ---------------------- INVALID / default  ----------------------
        instr = 16'b1111111111111111; ImmSrc = 3'b110; instr_type = "X"; expected = 16'b0; #10;
        $display("%-18b  %-7b  %-8s  %-18b  %-18b  %b", instr, ImmSrc, instr_type, ImmExt, expected, (ImmExt==expected));

        $finish;
    end

endmodule
