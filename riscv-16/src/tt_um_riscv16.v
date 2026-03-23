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
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);
    // ui_in[7] = 0 → LOAD mode, ui_in[7] = 1 → RUN mode
    wire load_mode = ~ui_in[7];
    wire run_mode  =  ui_in[7];

    // bidir pins are inputs in LOAD mode, outputs in RUN mode
    assign uio_oe = run_mode ? 8'hFF : 8'h00;

    wire reset = ~rst_n;
    wire [15:0] dbg_pc, dbg_instr, dbg_alu_result;
    wire [15:0] dbg_x1, dbg_x2, dbg_x3;
    wire load_ack;

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

    // output depends on mode
    assign uo_out  = load_mode ? {7'b0, load_ack} : dbg_word[7:0];
    assign uio_out = run_mode  ? dbg_word[15:8]   : 8'h00;

    wire _unused = &{ena, 1'b0};
endmodule