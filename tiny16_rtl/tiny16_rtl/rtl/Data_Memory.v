`include "Parameter.v"
// Data Memory (compatible with your existing system)
// Ports unchanged:
//   clk, mem_access_addr, mem_write_data, mem_write_en, mem_read, mem_read_data
// Behavior:
//   - 16-bit words, word-aligned addressing (drop bit0)
//   - Synchronous write on clk when mem_write_en == 1
//   - Combinational read when mem_read == 1, else 0
//   - Write-first on same-cycle read+write (returns mem_write_data)

module Data_Memory(
  input         clk,
  input  [15:0] mem_access_addr,  // byte address; internal word index = [ADDR_W:1]
  input  [15:0] mem_write_data,
  input         mem_write_en,
  input         mem_read,
  output [15:0] mem_read_data
);

  // Depth/width from Parameter.v
  reg [`col-1:0] memory [`row_d-1:0];

  // Address width derived from depth
  localparam integer ADDR_W = (`row_d <= 1) ? 1 : $clog2(`row_d);

  // Word-aligned index (drop bit0)
  wire [ADDR_W-1:0] addr = mem_access_addr[ADDR_W:1];

  // Synchronous write
  always @(posedge clk) begin
    if (mem_write_en)
      memory[addr] <= mem_write_data;
  end

  // Combinational read with write-first semantics
  assign mem_read_data =
      mem_read
        ? (mem_write_en ? mem_write_data : memory[addr])
        : {`col{1'b0}};

endmodule


