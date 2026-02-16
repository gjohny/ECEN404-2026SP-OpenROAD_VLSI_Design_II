`timescale 1ns / 1ps

module Control_unit(
    input  [2:0] opcode,      // primary opcode
    input  [3:0] func,        // function field (R-type, I-type)
    input        zero,        // ALU zero flag (for branches)
    output reg        PCSrc,        // PC source select
    output reg        ResultSrc,    // result source select
    output reg        MemWrite,     // memory write enable
    output reg  [3:0] ALUControl,   // ALU operation select
    output reg        ALUSrc,       // ALU source select
    output reg  [1:0] ImmSrc,       // immediate type select
    output reg        RegWrite      // register file write enable
);

    always @(*) begin
        // Default values (NOP-safe)
        PCSrc      = 1'b0;
        ResultSrc  = 1'b0;
        MemWrite   = 1'b0;
        ALUControl = 4'b0000;
        ALUSrc     = 1'b0;
        ImmSrc     = 2'b00;
        RegWrite   = 1'b0;

        case (opcode)

            // ------------------------------------------------
            // R-type: opcode = 000
            // ------------------------------------------------
            3'b000: begin
                RegWrite   = 1'b1;
                ALUSrc     = 1'b0;
                ResultSrc  = 1'b0;
                ALUControl = func; // func directly controls ALU op
            end

            // ------------------------------------------------
            // I-type: opcode = 001
            // (addi/xori/ori/andi/jalr)
            // ------------------------------------------------
            3'b001: begin
                ALUSrc     = 1'b1;
                RegWrite   = 1'b1;
                ResultSrc  = 1'b0;
                ImmSrc     = 2'b01;

                // Decode func field
                case (func)
                    4'b0000: ALUControl = 4'b0000; // ADDI
                    4'b0001: ALUControl = 4'b0010; // XORI
                    4'b0010: ALUControl = 4'b0011; // ORI
                    4'b0011: ALUControl = 4'b0100; // ANDI
                    4'b1101: begin                  // JALR
                                ALUControl = 4'b0000; // ALU does addition (rs1 + imm)
                                ImmSrc     = 2'b00;
                                PCSrc      = 1'b1;
                            end
                    default: ALUControl = 4'b0000;
                endcase
            end

            // ------------------------------------------------
            // LW: opcode = 010
            // ------------------------------------------------
            3'b010: begin
                ALUSrc     = 1'b1;
                RegWrite   = 1'b1;
                ResultSrc  = 1'b1; // writeback from memory
                ALUControl = 4'b0000; // ADD base + offset
                ImmSrc     = 2'b00;
            end

            // ------------------------------------------------
            // SW: opcode = 011
            // ------------------------------------------------
            3'b011: begin
                ALUSrc     = 1'b1;
                MemWrite   = 1'b1;
                ALUControl = 4'b0000; // ADD base + offset
                ImmSrc     = 2'b00;
            end

            // ------------------------------------------------
            // Branches: opcode = 100
            // func = 000 (BEQ), 001 (BNE)
            // ------------------------------------------------
            3'b100: begin
                ALUSrc     = 1'b0;
                ALUControl = 4'b0001; // SUB for comparison
                ImmSrc     = 2'b01;
                RegWrite   = 1'b0;

                // Branch condition
                case (func[0])
                    1'b0: PCSrc = (zero) ? 1'b1 : 1'b0;  // BEQ
                    1'b1: PCSrc = (~zero) ? 1'b1 : 1'b0; // BNE
                endcase
            end

            // ------------------------------------------------
            // JAL: opcode = 101
            // ------------------------------------------------
            3'b101: begin
                PCSrc      = 1'b1;
                RegWrite   = 1'b1;
                ALUSrc     = 1'b1;
                ALUControl = 4'b0000; // Add PC + imm
                ImmSrc     = 2'b10;
                ResultSrc  = 1'b0;
            end

            // ------------------------------------------------
            // Default (NOP)
            // ------------------------------------------------
            default: begin
                PCSrc      = 1'b0;
                ResultSrc  = 1'b0;
                MemWrite   = 1'b0;
                ALUControl = 4'b0000;
                ALUSrc     = 1'b0;
                ImmSrc     = 2'b00;
                RegWrite   = 1'b0;
            end
        endcase
    end
endmodule
