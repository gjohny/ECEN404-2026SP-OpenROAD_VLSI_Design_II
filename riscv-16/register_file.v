`timescale 1ns / 1ps
module regsiter_file(
    input            clk,          // Clock
    // Write port
    input            RegWrite,     // Write enable
    input  [2:0]     A3,           // Destination register
    input  [15:0]    WD3,          // Data to write
    // Read port 1
    input  [2:0]     A1,           // Source register 1
    output [15:0]    RD1,          // Data read from A1
    // Read port 2
    input  [2:0]     A2,           // Source register 2
    output [15:0]    RD2           // Data read from A2
);

    reg [15:0] reg_array [7:0];    // 8 registers X0-X7
    integer i;

    // Initialize registers to 0 at simulation start
    initial begin
        for(i = 0; i < 8; i = i + 1)
            reg_array[i] = 16'd0;
    end

    // Synchronous write
    always @(posedge clk) begin
        if (RegWrite && A3 != 3'b000)  // X0 is always 0
            reg_array[A3] <= WD3;
    end

    // Combinational reads
    assign RD1 = (A1 == 3'b000) ? 16'd0 : reg_array[A1];
    assign RD2 = (A2 == 3'b000) ? 16'd0 : reg_array[A2];

endmodule
