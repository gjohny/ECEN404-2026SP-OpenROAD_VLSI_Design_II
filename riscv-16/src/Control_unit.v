`timescale 1ns / 1ps
module Control_unit(
    input  wire [2:0] opcode,
    input  wire [3:0] func,
    input  wire       zero,
    input  wire       negative,
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
        // defaults (NOP-safe)
        PCSrc      = 1'b0;
        ResultSrc  = 2'b00;
        MemWrite   = 1'b0;
        MemRead    = 1'b0;
        ALUControl = 4'b0000;
        ALUSrc     = 1'b0;
        ImmSrc     = 3'b000;
        RegWrite   = 1'b0;

        case (opcode)
            3'b000: begin // R-type [1]
                RegWrite   = 1'b1;
                ALUSrc     = 1'b0;
                ResultSrc  = 2'b00;
                ALUControl = func;
            end

            3'b001: begin // I-type [1]
                ALUSrc    = 1'b1;
                RegWrite  = 1'b1;
                ResultSrc = 2'b00;
                ImmSrc    = 3'b001;

                case (func)
                    4'b0000: ALUControl = 4'b0000; // ADDI
                    4'b0001: ALUControl = 4'b0010; // XORI
                    4'b0010: ALUControl = 4'b0011; // ORI
                    4'b0011: ALUControl = 4'b0100; // ANDI
                    default: ALUControl = 4'b0000;
                endcase
            end

            3'b010: begin // S-type (stores) [1]
                ALUSrc     = 1'b1;
                MemWrite   = 1'b1;
                ALUControl = 4'b0000; // address calc
                ImmSrc     = 3'b010;
            end

            3'b011: begin // B-type (branches) [1]
                ALUControl = 4'b0001; // SUB compare
                ImmSrc     = 3'b011;

                // branch condition select via func[1:0]
                case (func[1:0])
                    2'b00: PCSrc = zero;                 // BEQ
                    2'b01: PCSrc = ~zero;                // BNE
                    2'b10: PCSrc = negative;             // BLT
                    2'b11: PCSrc = (~negative) & (~zero);// BGT
                endcase
            end

            3'b100: begin // U-type [1]
                RegWrite   = 1'b1;
                ALUSrc     = 1'b1;
                ALUControl = 4'b0000; // x0 + imm (if rs1 is x0)
                ImmSrc     = 3'b100;  // U-type immediate [1]
                ResultSrc  = 2'b00;
            end

            3'b101: begin // J-type [1]
                PCSrc      = 1'b1;
                RegWrite   = 1'b1;
                ImmSrc     = 3'b101;  // J-type immediate [1]
                ResultSrc  = 2'b10;   // write back PC+2
            end

            default: begin
                // 110–111 reserved/system in ISA [1] -> treat as NOP
            end
        endcase
    end

endmodule