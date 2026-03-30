`timescale 1ns / 1ps

module Sign_Extender(
    input  wire [15:0] instr,
    input  wire [2:0]  ImmSrc,
    output reg  [15:0] ImmExt
);

// ImmSrc encoding (must match Control_unit assignments):
//   000 → R-type    : no immediate
//   001 → I-type    : sign_ext( instr[15:13] )   ← 3-bit signed immediate
//   010 → S/L-type  : sign_ext( instr[15:9]  )   ← 7-bit signed offset
//   011 → B-type    : sign_ext( instr[15:11] ) << 1  ← 5-bit, byte offset
//   100 → U-type    : { instr[15:6], 6'b0 }       ← upper 10 bits shifted
//   101 → J-type    : sign_ext( instr[15:6]  )    ← 10-bit signed (JAL)
//   110 → JR-type   : sign_ext( instr[15:9]  )    ← 7-bit signed (JALR)

always @(*) begin
    case (ImmSrc)
        3'b000: ImmExt = 16'b0;

        // I-type: immediate lives in instr[15:13] (top 3 bits of instruction).
        // Sign bit is instr[15]. Extend to 16 bits.
        3'b001: ImmExt = {{13{instr[15]}}, instr[15:13]};

        // S-type (SW) and L-type (LW): 7-bit offset in instr[15:9].
        3'b010: ImmExt = {{9{instr[15]}}, instr[15:9]};

        // B-type (branches): 5-bit immediate in instr[15:11], shifted left 1
        // so the branch target is PC + (imm5 << 1), giving 2-byte alignment.
        3'b011: ImmExt = {{11{instr[15]}}, instr[15:11], 1'b0};

        // U-type (LUI): upper 10 bits placed at [15:6], bottom 6 bits zero.
        // FIX: was identical to J-type (sign-extend only). Now correctly shifts.
        3'b100: ImmExt = {instr[15:6], 6'b000000};

        // J-type (JAL): 10-bit signed immediate in instr[15:6].
        // Pipeline top shifts this left 1 when computing jal_target.
        3'b101: ImmExt = {{6{instr[15]}}, instr[15:6]};

        // JR-type (JALR): 7-bit signed offset in instr[15:9].
        3'b110: ImmExt = {{9{instr[15]}}, instr[15:9]};

        default: ImmExt = 16'b0;
    endcase
end

endmodule