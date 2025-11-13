`timescale 1ns / 1ps
module Sign_Extender_tb;

    reg  [15:0] instr;
    reg  [1:0]  ImmSrc;
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
    reg [8*1:0] instr_type; // instruction type as string

    initial begin
        // Table header with wider spacing
        $display("Instr               ImmSrc   Type    ImmExt               Expected             Pass");
        $display("-----------------------------------------------------------------------------------------");

        // R-TYPE
        instr = 16'b0000000000000000; ImmSrc = 2'b00; instr_type = "R"; expected = 16'b0000000000000000; #10;
        $display("%-18b  %-7b  %-5s  %-18b  %-18b  %b", instr, ImmSrc, instr_type, ImmExt, expected, (ImmExt==expected));

        // I-TYPE (positive)
        instr = 16'b0110000000000000; ImmSrc = 2'b00; instr_type = "I"; expected = {{13{1'b0}}, instr[15:13]}; #10;
        $display("%-18b  %-7b  %-5s  %-18b  %-18b  %b", instr, ImmSrc, instr_type, ImmExt, expected, (ImmExt==expected));

        // I-TYPE (negative)
        instr = 16'b1010000000000000; ImmSrc = 2'b00; instr_type = "I"; expected = {{13{1'b1}}, instr[15:13]}; #10;
        $display("%-18b  %-7b  %-5s  %-18b  %-18b  %b", instr, ImmSrc, instr_type, ImmExt, expected, (ImmExt==expected));

        // S-TYPE
        instr = 16'b0010101000000000; ImmSrc = 2'b11; instr_type = "S"; expected = {{9{1'b0}}, instr[15:9]}; #10;
        $display("%-18b  %-7b  %-5s  %-18b  %-18b  %b", instr, ImmSrc, instr_type, ImmExt, expected, (ImmExt==expected));

        instr = 16'b1010101000000000; ImmSrc = 2'b11; instr_type = "S"; expected = {{9{1'b1}}, instr[15:9]}; #10;
        $display("%-18b  %-7b  %-5s  %-18b  %-18b  %b", instr, ImmSrc, instr_type, ImmExt, expected, (ImmExt==expected));

        // B-TYPE
        instr = 16'b0010101000000000; ImmSrc = 2'b01; instr_type = "B"; expected = {{9{1'b0}}, {instr[15:13], instr[12:9]}}; #10;
        $display("%-18b  %-7b  %-5s  %-18b  %-18b  %b", instr, ImmSrc, instr_type, ImmExt, expected, (ImmExt==expected));

        instr = 16'b1010101000000000; ImmSrc = 2'b01; instr_type = "B"; expected = {{9{1'b1}}, {instr[15:13], instr[12:9]}}; #10;
        $display("%-18b  %-7b  %-5s  %-18b  %-18b  %b", instr, ImmSrc, instr_type, ImmExt, expected, (ImmExt==expected));

        // U-TYPE
        instr = 16'b0001100011110000; ImmSrc = 2'b10; instr_type = "U"; expected = {instr[15:6], 6'b000000}; #10;
        $display("%-18b  %-7b  %-5s  %-18b  %-18b  %b", instr, ImmSrc, instr_type, ImmExt, expected, (ImmExt==expected));

        instr = 16'b1001100011110000; ImmSrc = 2'b10; instr_type = "U"; expected = {instr[15:6], 6'b000000}; #10;
        $display("%-18b  %-7b  %-5s  %-18b  %-18b  %b", instr, ImmSrc, instr_type, ImmExt, expected, (ImmExt==expected));

        // J-TYPE
        instr = 16'b0001111000010000; ImmSrc = 2'b10; instr_type = "J"; expected = {instr[15:6], 6'b000000}; #10;
        $display("%-18b  %-7b  %-5s  %-18b  %-18b  %b", instr, ImmSrc, instr_type, ImmExt, expected, (ImmExt==expected));

        instr = 16'b1001111000010000; ImmSrc = 2'b10; instr_type = "J"; expected = {instr[15:6], 6'b000000}; #10;
        $display("%-18b  %-7b  %-5s  %-18b  %-18b  %b", instr, ImmSrc, instr_type, ImmExt, expected, (ImmExt==expected));

        // INVALID ImmSrc
        instr = 16'b1111111111111111; ImmSrc = 2'bxx; instr_type = "X"; expected = 16'b0; #10;
        $display("%-18b  %-7b  %-5s  %-18b  %-18b  %b", instr, ImmSrc, instr_type, ImmExt, expected, (ImmExt==expected));

        $finish;
    end

endmodule
