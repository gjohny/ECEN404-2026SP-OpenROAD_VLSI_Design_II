`timescale 1ns/1ps

module Instruction_memory #(
    parameter IMEM_WORDS = 256
)(
    input  wire        clk,
    input  wire [15:0] pc,
    output wire [15:0] instruction,

    input  wire        load_mode,
    input  wire        load_transfer,
    input  wire [5:0]  load_ui,
    input  wire [7:0]  load_uio,
    output reg         load_ack
);

    reg [15:0] memory [0:IMEM_WORDS-1];
    integer i;
    initial begin
        for (i = 0; i < IMEM_WORDS; i = i + 1)
            memory[i] = 16'h0000;
    end

    wire [15:0] word_index = pc[15:1];
    assign instruction = (word_index < IMEM_WORDS) ? memory[word_index] : 16'h0000;

    reg [7:0]  write_addr;
    reg [1:0]  state;
    reg [15:0] instr_latch;

    localparam IDLE   = 2'd0;
    localparam GOT_T1 = 2'd1;
    localparam WRITE  = 2'd2;
    localparam ACK    = 2'd3;

    initial begin
        state       = IDLE;
        write_addr  = 8'h00;
        load_ack    = 1'b0;
        instr_latch = 16'h0000;
    end

    always @(posedge clk) begin
        if (!load_mode) begin
            state      <= IDLE;
            load_ack   <= 1'b0;
            write_addr <= 8'h00;
        end else begin
            load_ack <= 1'b0;

            case (state)
                IDLE: begin
                    if (load_transfer == 1'b0) begin
                        instr_latch[5:0]  <= load_ui[5:0];
                        instr_latch[13:6] <= load_uio[7:0];
                        state <= GOT_T1;
                    end
                end

                GOT_T1: begin
                    if (load_transfer == 1'b1) begin
                        instr_latch[15:14] <= load_ui[5:4];
                        state <= WRITE;
                    end
                end

                WRITE: begin
                    memory[write_addr] <= instr_latch;
                    write_addr         <= write_addr + 1;
                    state              <= ACK;
                end

                ACK: begin
                    load_ack <= 1'b1;
                    state    <= IDLE;
                end

                default: state <= IDLE;
            endcase
        end
    end

endmodule
