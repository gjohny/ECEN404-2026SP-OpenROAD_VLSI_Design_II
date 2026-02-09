`timescale 1ns/1ps
`include "Parameter.v"

module sram_8x16 (
  input  wire            clk,
  input  wire [2:0]      addr,
  input  wire [`COL-1:0] wdata,
  input  wire            we,
  output wire [`COL-1:0] rdata
);
  reg [`COL-1:0] memory [0:`ROW_D-1];

  always @(posedge clk) begin
    if (we)
      memory[addr] <= wdata;
  end

  assign rdata = memory[addr];
endmodule
