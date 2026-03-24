`timescale 1ns / 1ps
`include "Parameter.v"

module Data_Memory(
    input         clk,
    input  [15:0] mem_access_addr,
    input  [15:0] mem_write_data,
    input         mem_write_en,
    input         mem_read,
    output [15:0] mem_read_data
);

    reg [`col-1:0] memory [0:`row_d-1];

    // FIX: was addr[2:0] = mem_access_addr[3:1] → only 8 word addresses.
    // Now addr[3:0] = mem_access_addr[4:1] → 16 word addresses (matches row_d=16).
    wire [3:0] addr = mem_access_addr[4:1];

    integer i;
    initial begin
        for (i = 0; i < `row_d; i = i + 1)
            memory[i] = 16'h0000;
    end

    always @(posedge clk) begin
        if (mem_write_en)
            memory[addr] <= mem_write_data;
    end

    // Read: forward write data on same-cycle read-during-write to avoid stale data
    assign mem_read_data =
        (mem_read)
            ? (mem_write_en ? mem_write_data : memory[addr])
            : 16'h0000;

endmodule