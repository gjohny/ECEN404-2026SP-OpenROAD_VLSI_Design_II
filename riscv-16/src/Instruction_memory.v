`timescale 1ns/1ps

module Instruction_memory #(
    parameter IMEM_WORDS = 256
)(
    input  wire        clk,
    input  wire [15:0] pc,
    output wire [15:0] instruction,

    // load ports
    input  wire        load_mode,
<<<<<<< HEAD
    input  wire [7:0]  load_data,
    input  wire        load_hibyte,
    input  wire [7:0]  load_addr,
=======
    input  wire        load_transfer,  // 0=transfer1, 1=transfer2
    input  wire [5:0]  load_ui,        // ui_in[5:0]
    input  wire [7:0]  load_uio,       // uio_in[7:0]
>>>>>>> a2343428e0d0bc7bc46b25e85478673e04bb91ac
    output reg         load_ack
);

    // ── RAM ───────────────────────────────────────────────────────────
    reg [15:0] memory [0:IMEM_WORDS-1];
    integer i;
    initial begin
        for (i = 0; i < IMEM_WORDS; i = i + 1)
            memory[i] = 16'h0000;
    end

    // ── read ──────────────────────────────────────────────────────────
    wire [15:0] word_index = pc[15:1];
    assign instruction = (word_index < IMEM_WORDS) ? memory[word_index] : 16'h0000;

    // ── auto-increment address counter ────────────────────────────────
    reg [7:0] write_addr;

    // ── Boot FSM ──────────────────────────────────────────────────────
    // Transfer 1: ui[5:0] = instr[5:0],  uio[7:0] = instr[13:6]  → 14 bits
    // Transfer 2: ui[5:4] = instr[15:14], ui[3:0] = unused        →  2 bits
    // Total = 16 bits 
    localparam IDLE   = 3'd0;
    localparam GOT_T1 = 3'd1;  // received transfer 1
    localparam GOT_T2 = 3'd2;  // received transfer 2
    localparam WRITE  = 3'd3;  // write to RAM
    localparam ACK    = 3'd4;  // pulse ack

    reg [2:0]  state;
<<<<<<< HEAD
    reg [7:0]  lo_byte;   // holds low  byte while waiting for high
    reg [7:0]  hi_byte;   // holds high byte before write
    reg [7:0]  addr_latch;// latches address at receive time
=======
    reg [15:0] instr_latch;
>>>>>>> a2343428e0d0bc7bc46b25e85478673e04bb91ac

    always @(posedge clk) begin

                // reset FSM and address counter if load_mode drops
        if (!load_mode) begin
            state      <= IDLE;
            load_ack   <= 0;
            write_addr <= 8'h00;
        end else begin

        load_ack <= 0;

        case (state)

            IDLE: begin
                if (load_mode) begin
                    if (load_transfer == 1'b0) begin
                        // Transfer 1
                        // ui[5:0]  → instr[5:0]
                        // uio[7:0] → instr[13:6]
                        instr_latch[5:0]  <= load_ui[5:0];
                        instr_latch[13:6] <= load_uio[7:0];
                        state <= GOT_T1;
                    end
                end
            end

            GOT_T1: begin
                if (load_mode && load_transfer == 1'b1) begin
                    // Transfer 2
                    // ui[5:4] → instr[15:14]
                    instr_latch[15:14] <= load_ui[5:4];
                    state <= GOT_T2;
                end
            end

            GOT_T2: begin
                // both transfers received, move to write
                state <= WRITE;
            end

            WRITE: begin
                // write assembled instruction to RAM at current address
                memory[write_addr] <= instr_latch;
                write_addr         <= write_addr + 1;
                state              <= ACK;
            end

            ACK: begin
                // pulse ack for one cycle
                load_ack <= 1;
                state    <= IDLE;
            end

            default: state <= IDLE;

        endcase
        end
    end

endmodule
    // ```

    // ---

    // **How the 16 bits are assembled:**
    // ```
    // Transfer 1:
    // load_ui[5:0]  → instr[5:0]   (6 bits)
    // load_uio[7:0] → instr[13:6]  (8 bits)
    // Total: 14 bits

    // Transfer 2:
    // load_ui[5:4]  → instr[15:14] (2 bits)
    // Total: 16 bits 

    // Address:
    // Auto-increments after every WRITE
    // Starts at 0, goes to 1, 2, 3...
    // Resets to 0 when load_mode drops