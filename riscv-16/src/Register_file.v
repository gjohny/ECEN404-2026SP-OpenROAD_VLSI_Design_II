`timescale 1ns / 1ps
module Register_file(
    input            clk,          // Clock
    input            reset,
    // Write port
    input            RegWrite,     // Write enable
    input  [2:0]     A3,           // Destination register
    input  [15:0]    WD3,          // Data to write
    // Read port 1
    input  [2:0]     A1,           // Source register 1
    output [15:0]    RD1,          // Data read from A1
    // Read port 2
    input  [2:0]     A2,           // Source register 2
    output [15:0]    RD2,          // Data read from A2    

    // Debug: expose X1
    output [15:0]    dbg_x1,
    output [15:0]    dbg_x2,
    output [15:0]    dbg_x3,
    output [15:0]    dbg_x4,   
    output [15:0]    dbg_x5, 
    output [15:0]    dbg_x6
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
        if (reset) begin
            for(i = 0; i < 8; i = i + 1)
                reg_array[i] <= 16'd0;
        end else if (RegWrite && A3 != 3'b000)  // X0 is always 0
            reg_array[A3] <= WD3;
    end

    // Combinational reads
    assign RD1 = (A1 == 3'b000) ? 16'd0 : reg_array[A1];
    assign RD2 = (A2 == 3'b000) ? 16'd0 : reg_array[A2];

    // Debug output
    assign dbg_x1 = reg_array[3'b001]; // X
    assign dbg_x2 = reg_array[3'b010]; // X2
    assign dbg_x3 = reg_array[3'b011]; // X3
    assign dbg_x4 = reg_array[3'b100]; // X4
    assign dbg_x5 = reg_array[3'b101]; // X5
    assign dbg_x6 = reg_array[3'b110]; // X6
endmodule