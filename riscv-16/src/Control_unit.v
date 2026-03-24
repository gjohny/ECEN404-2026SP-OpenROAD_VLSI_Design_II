`timescale 1ns / 1ps

module Control_unit(
    input  [2:0] opcode,
    input  [3:0] func,
    input        zero,
    input        negative,
    output reg        PCSrc,
    output reg  [1:0] ResultSrc,
    output reg        MemWrite,
    output reg        MemRead,
    output reg  [3:0] ALUControl,
    output reg        ALUSrc,
    output reg  [2:0] ImmSrc,
    output reg        RegWrite
);

    always @(*) begin
        // Safe defaults (NOP)
        PCSrc      = 1'b0;
        ResultSrc  = 2'b00;
        MemWrite   = 1'b0;
        MemRead    = 1'b0;
        ALUControl = 4'b0000;
        ALUSrc     = 1'b0;
        ImmSrc     = 3'b000;
        RegWrite   = 1'b0;

        case (opcode)

            // ── R-type (000) ─────────────────────────────────────────────────
            3'b000: begin
                RegWrite   = 1'b1;
                ALUSrc     = 1'b0;
                ResultSrc  = 2'b00;
                ALUControl = func;   // func bits map directly to ALU op
            end

            // ── I-type (001): ADDI / XORI / ORI / ANDI ───────────────────────
            3'b001: begin
                ALUSrc    = 1'b1;
                RegWrite  = 1'b1;
                ResultSrc = 2'b00;
                ImmSrc    = 3'b001;
                case (func)
                    4'b0000: ALUControl = 4'b0000; // ADDI  → ADD
                    4'b0001: ALUControl = 4'b0010; // XORI  → XOR
                    4'b0010: ALUControl = 4'b0011; // ORI   → OR
                    4'b0011: ALUControl = 4'b0100; // ANDI  → AND
                    default: ALUControl = 4'b0000;
                endcase
            end

            // ── LW (010) ─────────────────────────────────────────────────────
            3'b010: begin
                ALUSrc     = 1'b1;
                RegWrite   = 1'b1;
                MemRead    = 1'b1;
                ResultSrc  = 2'b01;   // write-back from memory
                ALUControl = 4'b0000; // ADD: base + offset
                ImmSrc     = 3'b010;
            end

            // ── SW (011) ─────────────────────────────────────────────────────
            3'b011: begin
                ALUSrc     = 1'b1;
                MemWrite   = 1'b1;
                ALUControl = 4'b0000; // ADD: base + offset
                ImmSrc     = 3'b010;
            end

            // ── Branch (100): BEQ / BNE / BLT / BGT ─────────────────────────
            3'b100: begin
                ALUControl = 4'b0001; // SUB for comparison
                ImmSrc     = 3'b011;
                case (func[1:0])
                    2'b00: PCSrc = zero;                    // BEQ
                    2'b01: PCSrc = ~zero;                   // BNE
                    2'b10: PCSrc = negative;                // BLT
                    2'b11: PCSrc = (~negative) & (~zero);   // BGT
                endcase
            end

            // ── JAL (101) ────────────────────────────────────────────────────
            3'b101: begin
                PCSrc      = 1'b1;
                RegWrite   = 1'b1;
                ALUSrc     = 1'b1;
                ALUControl = 4'b0000;
                ImmSrc     = 3'b101;  // J-type: sign_ext(instr[15:6])
                ResultSrc  = 2'b10;   // write back PC+2
            end

            // ── JALR (111) ───────────────────────────────────────────────────
            3'b111: begin
                PCSrc      = 1'b1;
                RegWrite   = 1'b1;
                ALUSrc     = 1'b1;
                ALUControl = 4'b0000; // ADD: rs1 + imm
                ImmSrc     = 3'b110;  // JR-type: sign_ext(instr[15:9])
                ResultSrc  = 2'b10;   // write back PC+2
            end

            // ── LUI (110) ────────────────────────────────────────────────────
            // FIX: was ImmSrc=3'b101 (J-type sign-ext, no shift).
            //      Corrected to ImmSrc=3'b100 so Sign_Extender produces
            //      {instr[15:6], 6'b000000} — the proper upper-immediate.
            3'b110: begin
                RegWrite   = 1'b1;
                ALUSrc     = 1'b1;
                ALUControl = 4'b0000; // ADD x0 + upper_imm
                ImmSrc     = 3'b100;  // U-type: {imm[9:0], 6'b0}
                ResultSrc  = 2'b00;
            end

            default: begin
                PCSrc      = 1'b0;
                ResultSrc  = 2'b00;
                MemWrite   = 1'b0;
                MemRead    = 1'b0;
                ALUControl = 4'b0000;
                ALUSrc     = 1'b0;
                ImmSrc     = 3'b000;
                RegWrite   = 1'b0;
            end
        endcase
    end
endmodule