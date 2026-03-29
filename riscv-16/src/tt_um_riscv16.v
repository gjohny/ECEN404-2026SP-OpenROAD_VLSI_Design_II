// `default_nettype none
// `timescale 1ns / 1ps

// module tt_um_riscv16 (
//     input  wire [7:0] ui_in,    // Dedicated inputs
//     output wire [7:0] uo_out,   // Dedicated outputs
//     input  wire [7:0] uio_in,   // IOs: Input path
//     output wire [7:0] uio_out,  // IOs: Output path
//     output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
//     input  wire       ena,      // always 1 when the design is powered, so you can ignore it
//     input  wire       clk,      // clock
//     input  wire       rst_n     // reset_n - low to reset
// );

//     assign uio_oe = 8'hFF; //make bidirectional pins as output pins

//     wire reset = ~rst_n;

//     wire [15:0] dbg_pc, dbg_instr, dbg_alu_result;
//     wire [15:0] dbg_x1, dbg_x2, dbg_x3;

//     riscv16_top CPU (
//         .clk           (clk),
//         .reset         (reset),
//         .dbg_pc        (dbg_pc),
//         .dbg_instr     (dbg_instr),
//         .dbg_alu_result(dbg_alu_result),
//         .dbg_x1        (dbg_x1),
//         .dbg_x2        (dbg_x2),
//         .dbg_x3        (dbg_x3)
//     );

//     reg [15:0] dbg_word;
//     always @(*) begin
//         case (ui_in[2:0])
//             3'd0: dbg_word = dbg_pc; //show pc
//             3'd1: dbg_word = dbg_instr; //show specific instruction
//             3'd2: dbg_word = dbg_alu_result; //show alu result
//             3'd3: dbg_word = dbg_x1; //show reg x1
//             3'd4: dbg_word = dbg_x2; ////show reg x2
//             3'd5: dbg_word = dbg_x3; ////show reg x3
//             default: dbg_word = 16'hDEAD;
//         endcase
//     end

//     //split output into 2 8-bit outputs
//     assign uo_out  = dbg_word[7:0];
//     assign uio_out = dbg_word[15:8];

//     wire _unused = &{ena, uio_in, ui_in[7:3], 1'b0};

// endmodule


`default_nettype none
`timescale 1ns / 1ps

module tt_um_riscv16 (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

    // ── mode select ────────────────────────────────────────────────────
    // ui_in[7] = 0 → LOAD mode (writing program into RAM)
    // ui_in[7] = 1 → RUN  mode (executing program)
    wire load_mode = ~ui_in[7];
    wire run_mode  =  ui_in[7];

    // ── bidir direction depends on mode ───────────────────────────────
    // LOAD: bidir = inputs  (receiving instruction data)
    // RUN:  bidir = outputs (sending high byte of debug signal)
    assign uio_oe = run_mode ? 8'hFF : 8'h00;

    // ── reset conversion ──────────────────────────────────────────────
    wire reset = ~rst_n;

    // ── debug bus ─────────────────────────────────────────────────────
    wire [15:0] dbg_pc, dbg_instr, dbg_alu_result;
    wire [15:0] dbg_x1, dbg_x2, dbg_x3;
    wire        load_ack;

    // ── processor ─────────────────────────────────────────────────────
    // LOAD mode pin mapping:
    //   ui_in[7]    = 0           → LOAD mode flag
    //   ui_in[6]    = transfer ID → 0=transfer1, 1=transfer2
    //   Transfer 1:
    //     ui_in[5:0]  = instr[5:0]   (6 bits)
    //     uio_in[7:0] = instr[13:6]  (8 bits) → total 14 bits
    //   Transfer 2:
    //     ui_in[5:4]  = instr[15:14] (2 bits)
    //     uio_in[7:0] = unused
    //
    // RUN mode pin mapping:
    //   ui_in[2:0]   = debug channel selector
    //   uo_out[7:0]  = low  byte of selected signal
    //   uio_out[7:0] = high byte of selected signal
    riscv16_top CPU (
        .clk           (clk),
        .reset         (reset),
        .dbg_pc        (dbg_pc),
        .dbg_instr     (dbg_instr),
        .dbg_alu_result(dbg_alu_result),
        .dbg_x1        (dbg_x1),
        .dbg_x2        (dbg_x2),
        .dbg_x3        (dbg_x3),
        .load_mode     (load_mode),
        .load_transfer (ui_in[6]),
        .load_ui       (ui_in[5:0]),
        .load_uio      (uio_in[7:0]),
        .load_ack      (load_ack)
    );

    // ── RUN mode debug mux ────────────────────────────────────────────
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

    // ── output depends on mode ────────────────────────────────────────
    // LOAD: uo_out[0] = load_ack, rest = 0
    // RUN:  uo_out = low byte, uio_out = high byte
    assign uo_out  = load_mode ? {7'b0, load_ack} : dbg_word[7:0];
    assign uio_out = run_mode  ? dbg_word[15:8]   : 8'h00;

    // ── only truly unused signal is ena ───────────────────────────────
    wire _unused = &{ena, 1'b0};

endmodule