`timescale 1ns / 1ps

module pc_counter_16 (
    input              clk,
    input              reset,
    input              pc_en,           // enable (for stalls)

    // Branch control (B-type, opcode=011)
    input              branch_taken,
    input signed [6:0] branch_imm,     // signed halfword offset from B-type [2]

    // JAL (J-type, opcode=101)
    input              jal_taken,
    input signed [9:0] jal_imm,        // signed halfword offset from J-type [2]

    // JALR (I-type, func=1101)
    input              jalr_taken,
    input      [15:0]  jalr_target,    // rs1 + imm (byte address)

    output reg [15:0]  pc
);
    // Convert halfword offsets to byte addresses
    function [15:0] hw_to_bytes;
        input signed [15:0] imm_hw;
        begin
            hw_to_bytes = imm_hw << 1;
        end
    endfunction

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            pc <= 16'h0000;
        end else if (pc_en) begin
            if (jalr_taken) begin
                // JALR: PC = rs1 + imm, align to 2-byte boundary [1]
                pc <= {jalr_target[15:1], 1'b0};
            end else if (jal_taken) begin
                // JAL: PC += imm (halfwords → bytes), rd = PC+2 in WB [1]
                pc <= pc + hw_to_bytes({{6{jal_imm[9]}}, jal_imm});
            end else if (branch_taken) begin
                // Branch: PC += imm (halfwords → bytes) [2]
                pc <= pc + hw_to_bytes({{9{branch_imm[6]}}, branch_imm});
            end else begin
                // Sequential: next 16-bit instruction
                pc <= pc + 16'd2;
            end
        end
    end
endmodule
