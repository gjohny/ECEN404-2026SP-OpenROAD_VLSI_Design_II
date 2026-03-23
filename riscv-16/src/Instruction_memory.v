`timescale 1ns/1ps
module Instruction_memory #(
    parameter IMEM_WORDS = 256
)(
    input  wire        clk,
    input  wire [15:0] pc,
    output wire [15:0] instruction,

    // load ports
    input  wire        load_mode,
    input  wire [6:0]  load_data,
    input  wire        load_hibyte,
    input  wire [6:0]  load_addr,
    output reg         load_ack
);

    // ── RAM (replaces ROM) ─────────────────────────────────────────────
    reg [15:0] memory [0:IMEM_WORDS-1];
    integer i;
    initial begin
        for (i = 0; i < IMEM_WORDS; i = i + 1)
            memory[i] = 16'h0000;
    end

    // ── read (same as before) ──────────────────────────────────────────
    wire [15:0] word_index = pc[15:1];
    assign instruction = (word_index < IMEM_WORDS) ? memory[word_index] : 16'h0000;

    // ── Boot FSM ───────────────────────────────────────────────────────
    localparam IDLE     = 3'd0;
    localparam RECV_LO  = 3'd1;
    localparam RECV_HI  = 3'd2;
    localparam WRITE    = 3'd3;
    localparam ACK      = 3'd4;

    reg [2:0]  state;
    reg [6:0]  lo_byte;   // holds low  byte while waiting for high
    reg [6:0]  hi_byte;   // holds high byte before write
    reg [6:0]  addr_latch;// latches address at receive time

    always @(posedge clk) begin
        load_ack <= 0; // default: ack is low

        case (state)

            IDLE: begin
                if (load_mode) begin
                    if (!load_hibyte) begin
                        // low byte arriving
                        lo_byte    <= load_data;
                        addr_latch <= load_addr;
                        state      <= RECV_LO;
                    end else begin
                        // high byte arriving
                        hi_byte    <= load_data;
                        addr_latch <= load_addr;
                        state      <= RECV_HI;
                    end
                end
            end

            RECV_LO: begin
                // waiting for high byte to arrive
                if (load_hibyte) begin
                    hi_byte <= load_data;
                    state   <= WRITE;
                end
            end

            RECV_HI: begin
                // waiting for low byte to arrive
                if (!load_hibyte) begin
                    lo_byte <= load_data;
                    state   <= WRITE;
                end
            end

            WRITE: begin
                // assemble and write to RAM
                memory[addr_latch] <= {hi_byte, lo_byte};
                state <= ACK;
            end

            ACK: begin
                // pulse ack for one cycle then go back to IDLE
                load_ack <= 1;
                state    <= IDLE;
            end

            default: state <= IDLE;

        endcase

        // if load_mode goes away, reset FSM
        if (!load_mode) begin
            state    <= IDLE;
            load_ack <= 0;
        end
    end

endmodule