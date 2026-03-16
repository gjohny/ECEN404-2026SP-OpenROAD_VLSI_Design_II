`default_nettype none
`timescale 1ns / 1ps

module tt_um_riscv16 (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

    // ── all bidir pins are outputs ─────────────────────────────────────
    assign uio_oe = 8'hFF;

    // ── convert active-low reset to active-high ────────────────────────
    wire reset = ~rst_n;

    // ── debug bus from the core ────────────────────────────────────────
    wire [15:0] dbg_pc, dbg_instr, dbg_alu_result;
    wire [15:0] dbg_x1, dbg_x2, dbg_x3;

    // ── instantiate your processor (completely unmodified) ─────────────
    riscv16_top CPU (
        .clk           (clk),
        .reset         (reset),
        .dbg_pc        (dbg_pc),
        .dbg_instr     (dbg_instr),
        .dbg_alu_result(dbg_alu_result),
        .dbg_x1        (dbg_x1),
        .dbg_x2        (dbg_x2),
        .dbg_x3        (dbg_x3)
    );

    // ── debug multiplexer ──────────────────────────────────────────────
    // ui_in[2:0] selects which 16-bit word to display:
    //   000 → PC           001 → Instruction
    //   010 → ALU result   011 → x1
    //   100 → x2           101 → x3
    //
    // uo_out  = selected word [7:0]  (low byte)
    // uio_out = selected word [15:8] (high byte)

    reg [15:0] dbg_word;
    always @(*) begin
        case (ui_in[2:0])
            3'd0: dbg_word = dbg_pc;
            3'd1: dbg_word = dbg_instr;
            3'd2: dbg_word = dbg_alu_result;
            3'd3: dbg_word = dbg_x1;
            3'd4: dbg_word = dbg_x2;
            3'd5: dbg_word = dbg_x3;
            default: dbg_word = 16'hDEAD;
        endcase
    end

    assign uo_out  = dbg_word[7:0];
    assign uio_out = dbg_word[15:8];

    // ── suppress unused input warnings ────────────────────────────────
    wire _unused = &{ena, uio_in, ui_in[7:3], 1'b0};

endmodule