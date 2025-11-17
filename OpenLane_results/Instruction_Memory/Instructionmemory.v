`timescale 1ns/1ps
module Instruction_Memory_16 #(
parameter IMEM_WORDS = 256
)(
input clk,
input [15:0] pc,
output reg [15:0] instruction
);
// Word-aligned index
wire [15:0] word_index = pc[15:1];

// Combinational ROM
reg [15:0] rom_out;
always @(*) begin
case (word_index)
16'd0: rom_out = 16'h1234;
16'd1: rom_out = 16'h5678;
16'd2: rom_out = 16'h9ABC;
16'd3: rom_out = 16'hDEF0;
16'd4: rom_out = 16'hAAAA;
16'd5: rom_out = 16'h5555;
16'd6: rom_out = 16'hFFFF;
16'd7: rom_out = 16'h0000;

16'd16: rom_out = 16'h1111;
16'd17: rom_out = 16'h2222;
16'd18: rom_out = 16'h3333;
16'd19: rom_out = 16'h4444;
16'd20: rom_out = 16'hBEEF;
16'd21: rom_out = 16'hCAFE;
16'd22: rom_out = 16'hDEAD;
16'd23: rom_out = 16'hC0DE;

16'd24: rom_out = 16'h0001;
16'd25: rom_out = 16'h0002;
16'd26: rom_out = 16'h0003;
16'd27: rom_out = 16'h0004;
16'd28: rom_out = 16'h0005;
16'd29: rom_out = 16'h0006;
16'd30: rom_out = 16'h0007;
16'd31: rom_out = 16'h0008;

default: rom_out = 16'h0000;
endcase
end

// Register the output so clk has sinks and pins are connected
always @(posedge clk) begin
instruction <= rom_out;
end
endmodule
