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
    // initial begin
    //     $dumpfile("./tb/waveform/Sign_Extender.vcd");
    //     $dumpvars(0, Sign_Extender_tb);
    // end

    reg [15:0] expected;
    reg [8*8-1:0] instr_type; 

    initial begin
        
        $display("Instr               ImmSrc   Type      ImmExt               Expected             Pass");
        $display("-------------------------------------------------------------------------------------------");

        
        // ----------------------   R-TYPE  ----------------------
        instr = 16'b0000000000000000; ImmSrc = 3'b000; instr_type = "R-TYPE"; expected = 16'b0; #10;
        $display("%-18b  %-7b  %-8s  %-18b  %-18b  %b", instr, ImmSrc, instr_type, ImmExt, expected, (ImmExt==expected));

        
        // ----------------------  I-TYPE (positive)  ----------------------
        instr = 16'b0110000000000000; ImmSrc = 3'b001; instr_type = "I-TYPE"; expected = 16'b0000000000000011; #10;
        $display("%-18b  %-7b  %-8s  %-18b  %-18b  %b", instr, ImmSrc, instr_type, ImmExt, expected, (ImmExt==expected));

        // ----------------------  I-TYPE (negative). ----------------------
        instr = 16'b1010000000000000; ImmSrc = 3'b001; instr_type = "I-TYPE"; expected = 16'b1111111111111101; #10;
        $display("%-18b  %-7b  %-8s  %-18b  %-18b  %b", instr, ImmSrc, instr_type, ImmExt, expected, (ImmExt==expected));

        
        // ----------------------  S-TYPE (positive)  ----------------------
        instr = 16'b0010101000000000; ImmSrc = 3'b010; instr_type = "S-TYPE"; expected = 16'b0000000000010101; #10;
        $display("%-18b  %-7b  %-8s  %-18b  %-18b  %b", instr, ImmSrc, instr_type, ImmExt, expected, (ImmExt==expected));

        //   ----------------------  S-TYPE (negative)  ----------------------
        instr = 16'b1010101000000000; ImmSrc = 3'b010; instr_type = "S-TYPE"; expected = 16'b1111111111010101; #10;
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
