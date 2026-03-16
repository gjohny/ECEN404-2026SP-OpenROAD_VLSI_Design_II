`timescale 1ns / 1ps

module Control_unit(
    input  [2:0] opcode,      // primary opcode
    input  [3:0] func,        // function field (R-type, I-type)
    input        zero,        // ALU zero flag (for branches)
    output reg        PCSrc,        // PC source select
    output reg  [1:0] ResultSrc,    // result source select
    output reg        MemWrite,     // memory write enable
    output reg        MemRead,
    output reg  [3:0] ALUControl,   // ALU operation select
    output reg        ALUSrc,       // ALU source select
    output reg  [2:0] ImmSrc,       // immediate type select
    output reg        RegWrite      // register file write enable
);

    always @(*) begin
        // Default values (NOP-safe)
        PCSrc      = 1'b0;
        ResultSrc  = 2'b00;
        MemWrite   = 1'b0;
        MemRead    = 1'b0;
        ALUControl = 4'b0000;
        ALUSrc     = 1'b0;
        ImmSrc     = 3'b000;
        RegWrite   = 1'b0;

        case (opcode)

            // ------------------------------------------------
            // R-type: opcode = 000
            // ------------------------------------------------
            3'b000: begin
                RegWrite   = 1'b1;
                ALUSrc     = 1'b0;
                ResultSrc  = 2'b00;
                ALUControl = func; // func directly controls ALU op
            end

            // ------------------------------------------------
            // I-type: opcode = 001
            // (addi/xori/ori/andi/jalr)
            // ------------------------------------------------
            3'b001: begin
                ALUSrc     = 1'b1;
                RegWrite   = 1'b1;
                ResultSrc  = 2'b00;
                ImmSrc     = 3'b001;

                // Decode func field
                case (func)
                    4'b0000: ALUControl = 4'b0000; // ADDI
                    4'b0001: ALUControl = 4'b0010; // XORI
                    4'b0010: ALUControl = 4'b0011; // ORI
                    4'b0011: ALUControl = 4'b0100; // ANDI
                    4'b1101: begin                  // JALR
                                ALUControl = 4'b0000; // ALU does addition (rs1 + imm)
                                ImmSrc     = 3'b001; // JALR immediate format
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
                MemRead    = 1'b1;
                ResultSrc  = 2'b01; // writeback from memory
                ALUControl = 4'b0000; // ADD base + offset
                ImmSrc     = 3'b010;
            end

            // ------------------------------------------------
            // SW: opcode = 011
            // ------------------------------------------------
            3'b011: begin
                ALUSrc     = 1'b1;
                MemWrite   = 1'b1;
                ALUControl = 4'b0000; // ADD base + offset
                ImmSrc     = 3'b010;
            end

            // ------------------------------------------------
            // Branches: opcode = 100
            // func = 000 (BEQ), 001 (BNE)
            // ------------------------------------------------
            3'b100: begin
                ALUControl = 4'b0001; // SUB for comparison
                ImmSrc     = 3'b011;

                // Branch condition
                case(func[1:0])
                    2'b00: PCSrc = zero;                // BEQ
                    2'b01: PCSrc = ~zero;               // BNE
                    2'b10: PCSrc = negative;            // BLT
                    2'b11: PCSrc = ~negative & ~zero;   // BGT
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
                ImmSrc     = 3'b101;
                ResultSrc  = 2'b10; // Write back PC + 2
            end

            // ------------------------------------------------
            // JR: opcode = 111
            // ------------------------------------------------
            3'b111: begin
                PCSrc      = 1'b1;
                RegWrite   = 1'b1;
                ALUSrc     = 1'b1;
                ALUControl = 4'b0000; // Add rs1 + imm
                ImmSrc     = 3'b110;
                ResultSrc  = 2'b10; // Write back PC + 2
            end

            // ------------------------------------------------
            // U-TYPE: opcode = 110  (LUI)
            // ------------------------------------------------
            3'b110: begin
                PCSrc      = 1'b0;        // No branch
                RegWrite   = 1'b1;        // Write to rd
                ALUSrc     = 1'b1;        // Use immediate
                ALUControl = 4'b0000;     // ADD (x0 + imm)
                ImmSrc     = 3'b101;       // Select U-type immediate
                ResultSrc  = 2'b00;        // Write ALU result
            end


            // ------------------------------------------------
            // Default (NOP)
            // ------------------------------------------------
            default: begin
                PCSrc      = 1'b0;
                ResultSrc  = 2'b00;
                MemWrite   = 1'b0;
                MemRead    = 1'b0;
                ALUControl = 4'b0000;
                ALUSrc     = 1'b0;
                ImmSrc     = 2'b00;
                RegWrite   = 1'b0;
            end
        endcase
    end
endmodule
