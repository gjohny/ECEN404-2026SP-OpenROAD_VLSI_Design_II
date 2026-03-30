`timescale 1ns / 1ps

module pc_counter_16 (
    input        clk,
    input        reset,
    input        pc_en,
    input  [15:0] pc_next,
    output reg [15:0] pc
);

    always @(posedge clk or posedge reset) begin
        if (reset)
            pc <= 16'h0000;
        else if (pc_en)
            pc <= pc_next;
    end

endmodule