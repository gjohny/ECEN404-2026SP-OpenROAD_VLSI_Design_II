`include "src/Parameter.v"

module Data_Memory(
  input         clk,
  input  [15:0] mem_access_addr,  // byte address; word index at [3:1]
  input  [15:0] mem_write_data,
  input         mem_write_en,
  input         mem_read,
  output [15:0] mem_read_data
);

  reg [`col-1:0] memory [0:`row_d-1];
  wire [2:0] addr = mem_access_addr[3:1];

  always @(posedge clk) begin
    if (mem_write_en)
      memory[addr] <= mem_write_data;
  end

  assign mem_read_data =
      mem_read
        ? (mem_write_en ? mem_write_data : memory[addr])
        : 16'h0000;

endmodule
