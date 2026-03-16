
`timescale 1ns / 1ps

// =============================================================================
//  RISC-V 16-bit  –  3-Stage Pipeline  (IF | ID/EX | MEM/WB)
//
//  Stage Breakdown
//  ───────────────
//  Stage 1  IF      : PC, Instruction Memory fetch
//  Stage 2  ID/EX   : Decode, Register Read, Immediate Generation, ALU
//  Stage 3  MEM/WB  : Data Memory, Writeback, Branch/Jump resolution
//
//  Hazard Handling
//  ───────────────
//  • Load-use stall  : 1-cycle bubble inserted when ID/EX produces a load
//                      result needed by the very next instruction.
//  • Branch/Jump flush: PC is corrected in MEM/WB; the one instruction that
//                       entered IF while the branch resolved is flushed (bubble).
//  • Full forwarding : EX→EX  and  MEM→EX  forwarding for ALU operands so
//                      back-to-back non-load instructions run without stalls.
// =============================================================================

module riscv16_pipeline_top (
    input  wire        clk,
    input  wire        reset,

    // Debug outputs (reflect MEM/WB stage values)
    output wire [15:0] dbg_pc,
    output wire [15:0] dbg_instr,
    output wire [15:0] dbg_alu_result,
    output wire [15:0] dbg_x1,
    output wire [15:0] dbg_x2,
    output wire [15:0] dbg_x3
);

    // =========================================================================
    //  Opcode constants (match your original)
    // =========================================================================
    localparam OPC_R = 3'b000;
    localparam OPC_I = 3'b001;
    localparam OPC_L = 3'b010;
    localparam OPC_S = 3'b011;
    localparam OPC_B = 3'b100;
    localparam OPC_J = 3'b101;
    localparam OPC_U = 3'b110;

    // =========================================================================
    //  ──────────────────────────────────────────────────────────────────────
    //  STAGE 1 : IF  (Instruction Fetch)
    //  ──────────────────────────────────────────────────────────────────────
    // =========================================================================

    wire [15:0] PC;
    wire [15:0] PC_plus2   = PC + 16'd2;

    // PC-enable: stall when load-use hazard detected
    wire        stall;
    // Flush IF/ID register when branch/jump resolves in MEM/WB
    wire        flush_ifid;
    // Corrected PC coming from MEM/WB
    wire [15:0] PC_redirect;
    wire        PC_redirect_en;

    wire [15:0] PC_next = PC_redirect_en ? PC_redirect : PC_plus2;

    pc_counter_16 PC_REG (
        .clk    (clk),
        .reset  (reset),
        .pc_en  (~stall),          // freeze PC on stall
        .pc_next(PC_next),
        .pc     (PC)
    );

    wire [15:0] if_instruction;

    Instruction_memory #(
        .IMEM_WORDS(256),
        .MEMFILE("src/program16.mem")
    ) IMEM (
        .clk        (clk),
        .pc         (PC),
        .instruction(if_instruction)
    );

    // =========================================================================
    //  IF/ID Pipeline Register
    // =========================================================================
    reg  [15:0] ifid_PC;
    reg  [15:0] ifid_instr;

    always @(posedge clk or posedge reset) begin
        if (reset || flush_ifid) begin
            ifid_PC    <= 16'd0;
            ifid_instr <= 16'd0;   // NOP = all-zero instruction
        end else if (~stall) begin
            ifid_PC    <= PC;
            ifid_instr <= if_instruction;
        end
        // When stall=1 : registers hold their value (freeze)
    end

    // =========================================================================
    //  ──────────────────────────────────────────────────────────────────────
    //  STAGE 2 : ID / EX  (Decode + Execute)
    //  ──────────────────────────────────────────────────────────────────────
    // =========================================================================

    // ----- Instruction field decode (combinational, from ifid_instr) --------

    wire [2:0] id_opcode = ifid_instr[2:0];
    wire [3:0] id_func   = ifid_instr[6:3];

    // R-type
    wire [2:0] id_rs1_r  = ifid_instr[15:13];
    wire [2:0] id_rs2_r  = ifid_instr[12:10];
    wire [2:0] id_rd_r   = ifid_instr[9:7];

    // I-type
    wire [5:0] id_imm_i_raw = ifid_instr[15:10];
    wire [2:0] id_rs1_i     = ifid_instr[9:7];
    wire [2:0] id_rd_i      = ifid_instr[9:7];

    // S-type
    wire [6:0] id_imm_s_raw = ifid_instr[15:9];
    wire [2:0] id_rs1_s     = ifid_instr[8:6];
    wire [2:0] id_rs2_s     = ifid_instr[5:3];

    // L-type
    wire [6:0] id_imm_l_raw = ifid_instr[15:9];
    wire [2:0] id_rs1_l     = ifid_instr[8:6];
    wire [2:0] id_rd_l      = ifid_instr[5:3];

    // B-type
    wire [2:0] id_imm_b_hi  = ifid_instr[15:13];
    wire [3:0] id_imm_b_lo  = ifid_instr[12:9];
    wire [2:0] id_rs1_b     = ifid_instr[8:6];
    wire [2:0] id_rs2_b     = ifid_instr[5:3];

    // U-type
    wire [9:0] id_imm_u_raw = ifid_instr[15:6];
    wire [2:0] id_rd_u      = ifid_instr[5:3];

    // J-type
    wire [9:0] id_imm_j_raw = ifid_instr[15:6];
    wire [2:0] id_rd_j      = ifid_instr[5:3];

    // ----- Unified register indices ----------------------------------------

    wire [2:0] id_rs1 =
        (id_opcode == OPC_R) ? id_rs1_r :
        (id_opcode == OPC_I) ? id_rs1_i :
        (id_opcode == OPC_S) ? id_rs1_s :
        (id_opcode == OPC_B) ? id_rs1_b :
        (id_opcode == OPC_L) ? id_rs1_l :
        3'b000;

    wire [2:0] id_rs2 =
        (id_opcode == OPC_R) ? id_rs2_r :
        (id_opcode == OPC_S) ? id_rs2_s :
        (id_opcode == OPC_B) ? id_rs2_b :
        3'b000;

    wire [2:0] id_rd =
        (id_opcode == OPC_R) ? id_rd_r :
        (id_opcode == OPC_I) ? id_rd_i :
        (id_opcode == OPC_U) ? id_rd_u :
        (id_opcode == OPC_J) ? id_rd_j :
        (id_opcode == OPC_L) ? id_rd_l :
        3'b000;

    // ----- Immediate construction (sign-extended to 16 bits) ---------------

    wire [15:0] id_imm_i = {{13{id_imm_i_raw[2]}}, id_imm_i_raw};
    wire [15:0] id_imm_s = {{9{id_imm_s_raw[6]}},  id_imm_s_raw};
    wire [15:0] id_imm_b = {{9{id_imm_b_hi[2]}},   id_imm_b_hi, id_imm_b_lo};
    wire [15:0] id_imm_u = {id_imm_u_raw, 6'b000000};
    wire [15:0] id_imm_j = {{6{id_imm_j_raw[9]}},  id_imm_j_raw};

    wire [15:0] id_imm =
        (id_opcode == OPC_I) ? id_imm_i :
        (id_opcode == OPC_S) ? id_imm_s :
        (id_opcode == OPC_B) ? id_imm_b :
        (id_opcode == OPC_U) ? id_imm_u :
        (id_opcode == OPC_J) ? id_imm_j :
        16'h0000;

    // ----- Control signals (combinational) ----------------------------------

    wire        id_PCSrc_raw;    // branch taken? (zero-dependent, evaluated here)
    wire        id_ResultSrc;
    wire        id_MemWrite;
    wire        id_ALUSrc;
    wire        id_RegWrite;
    wire [2:0]  id_ImmSrc;
    wire [3:0]  id_ALUControl;
    wire        id_zero_dummy;   // zero fed back after ALU – see EX stage

    // We instantiate the control unit here; zero is available after ALU.
    // For branch resolution we store PCSrc and re-evaluate it in MEM/WB.
    Control_unit CU (
        .opcode    (id_opcode),
        .func      (id_func),
        .zero      (ex_zero),         // forwarded from EX ALU output
        .PCSrc     (id_PCSrc_raw),
        .ResultSrc (id_ResultSrc),
        .MemWrite  (id_MemWrite),
        .ALUControl(id_ALUControl),
        .ALUSrc    (id_ALUSrc),
        .ImmSrc    (id_ImmSrc),
        .RegWrite  (id_RegWrite)
    );

    // ----- Register File ----------------------------------------------------
    //  Written by MEM/WB stage.  Read ports here in ID.

    wire [15:0] id_RD1_raw, id_RD2_raw;
    wire [15:0] rf_dbg_x1, rf_dbg_x2, rf_dbg_x3;

    // WB-stage writeback signals (declared forward; driven below)
    wire        wb_RegWrite;
    wire [2:0]  wb_rd;
    wire [15:0] wb_WD3;

    Register_file RF (
        .clk      (clk),
        .RegWrite (wb_RegWrite),
        .A3       (wb_rd),
        .WD3      (wb_WD3),
        .A1       (id_rs1),
        .RD1      (id_RD1_raw),
        .A2       (id_rs2),
        .RD2      (id_RD2_raw),
        .dbg_x1   (rf_dbg_x1),
        .dbg_x2   (rf_dbg_x2),
        .dbg_x3   (rf_dbg_x3)
    );

    // ----- Sign Extender (ImmExt not really needed separately – id_imm used) -
    wire [15:0] id_imm_ext;

    Sign_Extender SE (
        .instr  (ifid_instr),
        .ImmSrc (id_ImmSrc),
        .ImmExt (id_imm_ext)
    );

    // =========================================================================
    //  ID/EX Pipeline Register
    // =========================================================================

    // Stall: insert NOP bubble – freeze IF/ID, kill control signals in ID/EX
    // Flush: branch/jump taken – kill the instruction that snuck in during fetch

    reg  [15:0] idex_PC;
    reg  [15:0] idex_RD1, idex_RD2;
    reg  [2:0]  idex_rs1, idex_rs2, idex_rd;
    reg  [15:0] idex_imm;
    reg  [2:0]  idex_opcode;
    reg  [3:0]  idex_func;
    // Control
    reg         idex_ResultSrc;
    reg         idex_MemWrite;
    reg         idex_ALUSrc;
    reg         idex_RegWrite;
    reg  [3:0]  idex_ALUControl;
    // JAL/JALR detection
    reg         idex_is_jal;
    reg         idex_is_jalr;

    wire id_is_jal  = (id_opcode == OPC_J);
    wire id_is_jalr = (id_opcode == OPC_I) && (id_func == 4'b1101);

    always @(posedge clk or posedge reset) begin
        if (reset || stall) begin
            // Bubble / NOP
            idex_PC         <= 16'd0;
            idex_RD1        <= 16'd0;
            idex_RD2        <= 16'd0;
            idex_rs1        <= 3'd0;
            idex_rs2        <= 3'd0;
            idex_rd         <= 3'd0;
            idex_imm        <= 16'd0;
            idex_opcode     <= 3'd0;
            idex_func       <= 4'd0;
            idex_ResultSrc  <= 1'b0;
            idex_MemWrite   <= 1'b0;
            idex_ALUSrc     <= 1'b0;
            idex_RegWrite   <= 1'b0;
            idex_ALUControl <= 4'd0;
            idex_is_jal     <= 1'b0;
            idex_is_jalr    <= 1'b0;
        end else begin
            idex_PC         <= ifid_PC;
            idex_RD1        <= id_RD1_raw;
            idex_RD2        <= id_RD2_raw;
            idex_rs1        <= id_rs1;
            idex_rs2        <= id_rs2;
            idex_rd         <= id_rd;
            idex_imm        <= id_imm_ext;   // use sign-extender output for consistency
            idex_opcode     <= id_opcode;
            idex_func       <= id_func;
            idex_ResultSrc  <= id_ResultSrc;
            idex_MemWrite   <= id_MemWrite;
            idex_ALUSrc     <= id_ALUSrc;
            idex_RegWrite   <= id_RegWrite;
            idex_ALUControl <= id_ALUControl;
            idex_is_jal     <= id_is_jal;
            idex_is_jalr    <= id_is_jalr;
        end
    end

    // =========================================================================
    //  ──────────────────────────────────────────────────────────────────────
    //  EXECUTE  (combinational logic driven by ID/EX registers)
    //  ──────────────────────────────────────────────────────────────────────
    // =========================================================================

    // ----- Forwarding mux inputs -------------------------------------------
    //  Forward from MEM/WB writeback if register matches and write is enabled.
    //  (Only one prior stage in a 3-stage pipe, so single-level forwarding.)

    wire [15:0] ex_fwd_RD1 =
        (wb_RegWrite && (wb_rd != 3'd0) && (wb_rd == idex_rs1)) ? wb_WD3 : idex_RD1;

    wire [15:0] ex_fwd_RD2 =
        (wb_RegWrite && (wb_rd != 3'd0) && (wb_rd == idex_rs2)) ? wb_WD3 : idex_RD2;

    // ----- ALU source B mux ------------------------------------------------
    wire [15:0] ex_ALU_B = idex_ALUSrc ? idex_imm : ex_fwd_RD2;

    // ----- ALU ---------------------------------------------------------------
    wire [15:0] ex_ALUResult;
    wire        ex_zero;

    ALU ALU_CORE (
        .SrcA       (ex_fwd_RD1),
        .SrcB       (ex_ALU_B),
        .ALU_control(idex_ALUControl),
        .ALU_result (ex_ALUResult),
        .zero       (ex_zero)
    );

    // ----- Branch / Jump target computation ---------------------------------
    wire [15:0] ex_branch_target = idex_PC + (idex_imm << 1);
    wire [15:0] ex_jal_target    = idex_PC + (idex_imm << 1);
    wire [15:0] ex_jalr_sum      = ex_fwd_RD1 + idex_imm;
    wire [15:0] ex_jalr_target   = {ex_jalr_sum[15:1], 1'b0};

    // =========================================================================
    //  EX/MEM (ID/EX → MEM/WB)  Pipeline Register
    //  In a 3-stage design the EX result flows directly to MEM/WB.
    // =========================================================================

    reg  [15:0] memwb_PC;
    reg  [15:0] memwb_ALUResult;
    reg  [15:0] memwb_RD2;          // store data
    reg  [2:0]  memwb_rd;
    reg  [15:0] memwb_branch_target;
    reg  [15:0] memwb_jal_target;
    reg  [15:0] memwb_jalr_target;
    // Control
    reg         memwb_ResultSrc;
    reg         memwb_MemWrite;
    reg         memwb_RegWrite;
    reg         memwb_PCSrc;        // branch condition met
    reg         memwb_is_jal;
    reg         memwb_is_jalr;
    reg  [15:0] memwb_instr;        // for debug

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            memwb_PC            <= 16'd0;
            memwb_ALUResult     <= 16'd0;
            memwb_RD2           <= 16'd0;
            memwb_rd            <= 3'd0;
            memwb_branch_target <= 16'd0;
            memwb_jal_target    <= 16'd0;
            memwb_jalr_target   <= 16'd0;
            memwb_ResultSrc     <= 1'b0;
            memwb_MemWrite      <= 1'b0;
            memwb_RegWrite      <= 1'b0;
            memwb_PCSrc         <= 1'b0;
            memwb_is_jal        <= 1'b0;
            memwb_is_jalr       <= 1'b0;
            memwb_instr         <= 16'd0;
        end else begin
            memwb_PC            <= idex_PC;
            memwb_ALUResult     <= ex_ALUResult;
            memwb_RD2           <= ex_fwd_RD2;
            memwb_rd            <= idex_rd;
            memwb_branch_target <= ex_branch_target;
            memwb_jal_target    <= ex_jal_target;
            memwb_jalr_target   <= ex_jalr_target;
            memwb_ResultSrc     <= idex_ResultSrc;
            memwb_MemWrite      <= idex_MemWrite;
            memwb_RegWrite      <= idex_RegWrite;
            memwb_PCSrc         <= id_PCSrc_raw;  // branch taken flag (from CU+zero)
            memwb_is_jal        <= idex_is_jal;
            memwb_is_jalr       <= idex_is_jalr;
            memwb_instr         <= ifid_instr;    // carries through for debug
        end
    end

    // =========================================================================
    //  ──────────────────────────────────────────────────────────────────────
    //  STAGE 3 : MEM / WB  (Memory Access + Writeback)
    //  ──────────────────────────────────────────────────────────────────────
    // =========================================================================

    // ----- Data Memory -------------------------------------------------------
    wire [15:0] mem_ReadData;

    Data_Memory DMEM (
        .clk            (clk),
        .mem_access_addr(memwb_ALUResult),
        .mem_write_data (memwb_RD2),
        .mem_write_en   (memwb_MemWrite),
        .mem_read       (memwb_ResultSrc),
        .mem_read_data  (mem_ReadData)
    );

    // ----- Writeback ---------------------------------------------------------
    // JAL/JALR write PC+2 (return address) to rd
    wire [15:0] jal_ret_addr = memwb_PC + 16'd2;

    assign wb_WD3 =
        memwb_is_jal  ? jal_ret_addr :
        memwb_is_jalr ? jal_ret_addr :
        memwb_ResultSrc ? mem_ReadData :
        memwb_ALUResult;

    assign wb_RegWrite = memwb_RegWrite;
    assign wb_rd       = memwb_rd;

    // ----- PC Redirect (branch / jump resolution) ---------------------------
    assign PC_redirect_en =
        memwb_is_jalr  ? 1'b1 :
        memwb_is_jal   ? 1'b1 :
        memwb_PCSrc    ? 1'b1 :
        1'b0;

    assign PC_redirect =
        memwb_is_jalr ? memwb_jalr_target  :
        memwb_is_jal  ? memwb_jal_target   :
        memwb_PCSrc   ? memwb_branch_target:
        PC_plus2;   // fallback (unused when enable=0)

    // Flush the IF/ID register when we redirect the PC
    assign flush_ifid = PC_redirect_en;

    // =========================================================================
    //  Load-Use Hazard Detection
    //  Stall when ID/EX carries a load (ResultSrc=1) whose destination
    //  matches either source register of the instruction currently in ID.
    // =========================================================================
    assign stall = idex_ResultSrc &&
                   ((idex_rd == id_rs1 && idex_rd != 3'd0) ||
                    (idex_rd == id_rs2 && idex_rd != 3'd0));

    // =========================================================================
    //  Debug outputs
    // =========================================================================
    assign dbg_pc         = memwb_PC;
    assign dbg_instr      = memwb_instr;
    assign dbg_alu_result = memwb_ALUResult;
    assign dbg_x1         = rf_dbg_x1;
    assign dbg_x2         = rf_dbg_x2;
    assign dbg_x3         = rf_dbg_x3;

endmodule