`timescale 1ns / 1ps




module Control_Unit (
    input  [2:0] opcode,     // 3-bit primary opcode
    output reg [1:0] alu_op, // to ALU decoder
    output reg jump,
    output reg branch,
    output reg mem_read,
    output reg mem_write,
    output reg alu_src,
    output reg mem_to_reg,
    output reg reg_write
);

always @(*) begin
    // Default values (NOP)
    jump       = 1'b0;
    branch     = 1'b0;
    mem_read   = 1'b0;
    mem_write  = 1'b0;
    alu_src    = 1'b0;
    mem_to_reg = 1'b0;
    reg_write  = 1'b0;

    case (opcode)

        // ------------------------------------------------
        // R-type: opcode = 000  (add, sub, xor, or, and, etc.)
        // ------------------------------------------------
        3'b000: 
        begin
            jump       = 1'b0;
            branch     = 1'b0;
            mem_read   = 1'b0;
            mem_write  = 1'b0;
            alu_src    = 1'b0;
            mem_to_reg = 1'b0;
            reg_write  = 1'b0;
        end

        // ------------------------------------------------
        // I-type: opcode = 001  (addi, xori, ori, loads, jalr, etc.)
        // ------------------------------------------------
        3'b001: 
        begin
            jump       = 1'b0;
            branch     = 1'b0;
            mem_read   = 1'b0;
            mem_write  = 1'b0;
            alu_src    = 1'b0;
            mem_to_reg = 1'b0;
            reg_write  = 1'b0;
        end

        // ------------------------------------------------
        // S-type: opcode = 010 (store byte/half)
        // ------------------------------------------------
        3'b010: 
        begin
            jump       = 1'b0;
            branch     = 1'b0;
            mem_read   = 1'b0;
            mem_write  = 1'b0;
            alu_src    = 1'b0;
            mem_to_reg = 1'b0;
            reg_write  = 1'b0;
        end

        // ------------------------------------------------
        // B-type: opcode = 011 (branches)
        // ------------------------------------------------
        3'b011: 
        begin
            jump       = 1'b0;
            branch     = 1'b0;
            mem_read   = 1'b0;
            mem_write  = 1'b0;
            alu_src    = 1'b0;
            mem_to_reg = 1'b0;
            reg_write  = 1'b0;
        end

        // ------------------------------------------------
        // J-type: opcode = 100 (JAL)
        // ------------------------------------------------
        3'b100: 
        begin
            jump       = 1'b0;
            branch     = 1'b0;
            mem_read   = 1'b0;
            mem_write  = 1'b0;
            alu_src    = 1'b0;
            mem_to_reg = 1'b0;
            reg_write  = 1'b0;
        end

        // ------------------------------------------------
        // U-type: opcode = 110 (LUI, AUIPC)
        // ------------------------------------------------
        3'b110: 
        begin
            jump       = 1'b0;
            branch     = 1'b0;
            mem_read   = 1'b0;
            mem_write  = 1'b0;
            alu_src    = 1'b0;
            mem_to_reg = 1'b0;
            reg_write  = 1'b0;
        end

        default: 
        begin
            // Keep all control lines inactive
            jump       = 1'b0;
            branch     = 1'b0;
            mem_read   = 1'b0;
            mem_write  = 1'b0;
            alu_src    = 1'b0;
            mem_to_reg = 1'b0;
            reg_write  = 1'b0;
        end
    endcase
end

endmodule
