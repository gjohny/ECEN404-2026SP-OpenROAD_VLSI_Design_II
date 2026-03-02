`timescale 1ns / 1ps

module riscv16_top (
    input  wire       clk,
    input  wire       reset,

    output wire [15:0] dbg_pc,
    output wire [15:0] dbg_instr,
    output wire [15:0] dbg_alu_result,
    output wire [15:0] dbg_x1,
    output wire [15:0] dbg_x2,
    output wire [15:0] dbg_x3,
    output wire [15:0] dbg_x4,
    output wire [15:0] dbg_x5,
    output wire [15:0] dbg_x6,
    output wire [15:0] dbg_x7
);

    /* =====================
       Opcodes (same as yours)
    ====================== */
    localparam OPC_R = 3'b000;
    localparam OPC_I = 3'b001;
    localparam OPC_L = 3'b010;
    localparam OPC_S = 3'b011;
    localparam OPC_B = 3'b100;
    localparam OPC_J = 3'b101;
    localparam OPC_U = 3'b110;

    wire [15:0] NOP = 16'h0000;

    /* =====================
       IF Stage: PC + IMEM
    ====================== */
    wire [15:0] PC;
    wire [15:0] instruction_if;
    wire [15:0] PC_plus2_if = PC + 16'd2;

    // PC control (stall capable)
    wire        pc_en;
    wire [15:0] pc_next;

    pc_counter_16 PC_REG (
        .clk(clk),
        .reset(reset),
        .pc_en(pc_en),
        .pc_next(pc_next),
        .pc(PC)
    );

    Instruction_memory #(
        .IMEM_WORDS(256),
        .MEMFILE("src/program16.mem")
    ) IMEM (
        .clk(clk),
        .pc(PC),
        .instruction(instruction_if)
    );

    /* =====================
       IF/ID Pipeline Reg
    ====================== */
    reg [15:0] if_id_pc;
    reg [15:0] if_id_instr;

    wire if_id_we;          // stall: 0 holds IF/ID
    wire if_id_flush = 1'b0; // not doing control hazards yet

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            if_id_pc    <= 16'h0000;
            if_id_instr <= NOP;
        end else if (if_id_we) begin
            if_id_pc    <= PC;
            if_id_instr <= if_id_flush ? NOP : instruction_if;
        end
    end

    /* =====================
       ID Stage: decode from IF/ID
    ====================== */
    wire [15:0] instruction = if_id_instr;

    wire [2:0] opcode = instruction[2:0];
    wire [3:0] func   = instruction[6:3];

    // ---------- R-Type ----------
    wire [2:0] rs1_r = instruction[15:13];
    wire [2:0] rs2_r = instruction[12:10];
    wire [2:0] rd_r  = instruction[9:7];

    // ---------- I-Type ----------
    wire [5:0] imm_i_raw = instruction[15:10];
    wire [2:0] rd_i      = instruction[9:7];

    // ---------- S-Type ----------
    wire [6:0] imm_s_raw = instruction[15:9];
    wire [2:0] rs1_s     = instruction[8:6];
    wire [2:0] rs2_s     = instruction[5:3];

    // ---------- L-Type ----------
    wire [6:0] imm_l_raw = instruction[15:9];
    wire [2:0] rs1_l     = instruction[8:6];
    wire [2:0] rd_l      = instruction[5:3];

    // ---------- B-Type ----------
    wire [2:0] imm_b_hi  = instruction[15:13];
    wire [3:0] imm_b_lo  = instruction[12:9];
    wire [2:0] rs1_b     = instruction[8:6];
    wire [2:0] rs2_b     = instruction[5:3];

    // ---------- U-Type ----------
    wire [9:0] imm_u_raw = instruction[15:6];
    wire [2:0] rd_u      = instruction[5:3];

    // ---------- J-Type ----------
    wire [9:0] imm_j_raw = instruction[15:6];
    wire [2:0] rd_j      = instruction[5:3];

    /* =====================
       Register Selection (same as yours)
    ====================== */
    wire [2:0] rs1 =
        (opcode == OPC_R) ? rs1_r :
        (opcode == OPC_I) ? rd_i  :
        (opcode == OPC_S) ? rs1_s :
        (opcode == OPC_B) ? rs1_b :
        (opcode == OPC_L) ? rs1_l :
        3'b000;

    wire [2:0] rs2 =
        (opcode == OPC_R) ? rs2_r :
        (opcode == OPC_S) ? rs2_s :
        (opcode == OPC_B) ? rs2_b :
        3'b000;

    wire [2:0] rd =
        (opcode == OPC_R) ? rd_r :
        (opcode == OPC_I) ? rd_i :
        (opcode == OPC_U) ? rd_u :
        (opcode == OPC_J) ? rd_j :
        (opcode == OPC_L) ? rd_l :
        3'b000;

    /* =====================
       Immediate Construction (same as yours)
    ====================== */
    wire [15:0] imm_i = {{10{imm_i_raw[5]}}, imm_i_raw};
    wire [15:0] imm_s = {{9{imm_s_raw[6]}}, imm_s_raw};
    wire [15:0] imm_b = {{9{imm_b_hi[2]}}, imm_b_hi, imm_b_lo};
    wire [15:0] imm_u = {imm_u_raw, 6'b000000};
    wire [15:0] imm_j = {{6{imm_j_raw[9]}}, imm_j_raw};

    wire [15:0] imm =
        (opcode == OPC_I) ? imm_i :
        (opcode == OPC_S) ? imm_s :
        (opcode == OPC_B) ? imm_b :
        (opcode == OPC_U) ? imm_u :
        (opcode == OPC_J) ? imm_j :
        16'h0000;

    /* =====================
       Control Unit (ID)
       zero is EX-stage, so tie low here (branch hazards later)
    ====================== */
    wire        PCSrc_id;
    wire        ResultSrc_id;
    wire        MemWrite_id;
    wire        ALUSrc_id;
    wire        RegWrite_id;
    wire [2:0]  ImmSrc_id;
    wire [3:0]  ALUControl_id;

    Control_unit CU (
        .opcode(opcode),
        .func(func),
        .zero(1'b0),
        .PCSrc(PCSrc_id),
        .ResultSrc(ResultSrc_id),
        .MemWrite(MemWrite_id),
        .ALUControl(ALUControl_id),
        .ALUSrc(ALUSrc_id),
        .ImmSrc(ImmSrc_id),
        .RegWrite(RegWrite_id)
    );

    /* =====================
       Register File (writes from WB)
    ====================== */
    wire [15:0] RD1, RD2;
    wire [15:0] rf_dbg_x1, rf_dbg_x2, rf_dbg_x3, rf_dbg_x4, rf_dbg_x5, rf_dbg_x6, rf_dbg_x7;

    wire [2:0]  wb_rd;
    wire [15:0] wb_wd;
    wire        wb_RegWrite;

    Register_file RF (
        .clk(clk),
        .RegWrite(wb_RegWrite),
        .A3(wb_rd),
        .WD3(wb_wd),
        .A1(rs1),
        .RD1(RD1),
        .A2(rs2),
        .RD2(RD2),
        .dbg_x1(rf_dbg_x1),
        .dbg_x2(rf_dbg_x2),
        .dbg_x3(rf_dbg_x3),
        .dbg_x4(rf_dbg_x4),
        .dbg_x5(rf_dbg_x5),
        .dbg_x6(rf_dbg_x6),
        .dbg_x7(rf_dbg_x7)
    );

    /* =====================
       Immediate Gen (keep yours if you want; for ALU we use imm_i for I-type)
       We'll keep a single imm_ext that matches your ImmSrc module behavior.
    ====================== */
    wire [15:0] imm_ext;
    Sign_Extender SE (
        .instr(instruction),
        .ImmSrc(ImmSrc_id),
        .ImmExt(imm_ext)
    );

    /* =====================
       ID/EX Pipeline Reg
    ====================== */
    reg [15:0] id_ex_pc;
    reg [15:0] id_ex_rd1, id_ex_rd2;
    reg [15:0] id_ex_imm;
    reg [2:0]  id_ex_rs1, id_ex_rs2;
    reg [2:0]  id_ex_rd;

    reg        id_ex_ResultSrc;
    reg        id_ex_MemWrite;
    reg        id_ex_ALUSrc;
    reg        id_ex_RegWrite;
    reg [3:0]  id_ex_ALUControl;

    // ===== load-use stall (safe) =====
    // If EX is a load and ID wants that rd, stall one cycle (freeze PC + IF/ID).
    wire ex_is_load = id_ex_ResultSrc && id_ex_RegWrite && (id_ex_rd != 3'b000);
    wire load_use_hazard =
        ex_is_load && (
            ((rs1 != 3'b000) && (rs1 == id_ex_rd)) ||
            ((rs2 != 3'b000) && (rs2 == id_ex_rd))
        );

    assign pc_en    = ~load_use_hazard;
    assign if_id_we = ~load_use_hazard;

    // On a stall, insert a bubble into EX by clearing control bits.
    wire id_ex_bubble = load_use_hazard;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            id_ex_pc         <= 16'h0000;
            id_ex_rd1        <= 16'h0000;
            id_ex_rd2        <= 16'h0000;
            id_ex_imm        <= 16'h0000;
            id_ex_rs1        <= 3'b000;
            id_ex_rs2        <= 3'b000;
            id_ex_rd         <= 3'b000;

            id_ex_ResultSrc  <= 1'b0;
            id_ex_MemWrite   <= 1'b0;
            id_ex_ALUSrc     <= 1'b0;
            id_ex_RegWrite   <= 1'b0;
            id_ex_ALUControl <= 4'b0000;
        end else begin
            id_ex_pc  <= if_id_pc;
            id_ex_rd1 <= RD1;
            id_ex_rd2 <= RD2;

            // Use imm_ext for addressing and for ALU immediates (matches your design)
            id_ex_imm <= imm_ext;

            id_ex_rs1 <= rs1;
            id_ex_rs2 <= rs2;
            id_ex_rd  <= rd;

            if (id_ex_bubble) begin
                id_ex_ResultSrc  <= 1'b0;
                id_ex_MemWrite   <= 1'b0;
                id_ex_ALUSrc     <= 1'b0;
                id_ex_RegWrite   <= 1'b0;
                id_ex_ALUControl <= 4'b0000;
            end else begin
                id_ex_ResultSrc  <= ResultSrc_id;
                id_ex_MemWrite   <= MemWrite_id;
                id_ex_ALUSrc     <= ALUSrc_id;
                id_ex_RegWrite   <= RegWrite_id;
                id_ex_ALUControl <= ALUControl_id;
            end
        end
    end

    /* =====================
       EX Stage with Forwarding (this fixes x1/x2 failures)
    ====================== */

    // Forwarding from WB to EX operands
    wire [15:0] ex_srcA =
        (wb_RegWrite && (wb_rd != 3'b000) && (wb_rd == id_ex_rs1)) ? wb_wd : id_ex_rd1;

    wire [15:0] ex_rs2_val =
        (wb_RegWrite && (wb_rd != 3'b000) && (wb_rd == id_ex_rs2)) ? wb_wd : id_ex_rd2;

    wire [15:0] ex_srcB = id_ex_ALUSrc ? id_ex_imm : ex_rs2_val;

    wire [15:0] ALUResult_ex;
    wire        zero_ex;

    ALU ALU_CORE (
        .SrcA(ex_srcA),
        .SrcB(ex_srcB),
        .ALU_control(id_ex_ALUControl),
        .ALU_result(ALUResult_ex),
        .zero(zero_ex)
    );

    // For now, keep PC sequential (no branch/jump pipelined control yet)
    assign pc_next = PC_plus2_if;

    /* =====================
       EX/WB Pipeline Reg
    ====================== */
    reg [15:0] ex_wb_alu_result;
    reg [15:0] ex_wb_store_data;
    reg [2:0]  ex_wb_rd;

    reg        ex_wb_ResultSrc;
    reg        ex_wb_MemWrite;
    reg        ex_wb_RegWrite;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            ex_wb_alu_result <= 16'h0000;
            ex_wb_store_data <= 16'h0000;
            ex_wb_rd         <= 3'b000;

            ex_wb_ResultSrc  <= 1'b0;
            ex_wb_MemWrite   <= 1'b0;
            ex_wb_RegWrite   <= 1'b0;
        end else begin
            ex_wb_alu_result <= ALUResult_ex;

            // IMPORTANT: store data should be forwarded version
            ex_wb_store_data <= ex_rs2_val;

            ex_wb_rd         <= id_ex_rd;

            ex_wb_ResultSrc  <= id_ex_ResultSrc;
            ex_wb_MemWrite   <= id_ex_MemWrite;
            ex_wb_RegWrite   <= id_ex_RegWrite;
        end
    end

    /* =====================
       MEM/WB Stage
    ====================== */
    wire [15:0] ReadData_wb;

    Data_Memory DMEM (
        .clk(clk),
        .mem_access_addr(ex_wb_alu_result),
        .mem_write_data(ex_wb_store_data),
        .mem_write_en(ex_wb_MemWrite),
        .mem_read(ex_wb_ResultSrc),
        .mem_read_data(ReadData_wb)
    );

    assign wb_wd       = (ex_wb_ResultSrc) ? ReadData_wb : ex_wb_alu_result;
    assign wb_rd       = ex_wb_rd;
    assign wb_RegWrite = ex_wb_RegWrite;

    /* =====================
       Debug
    ====================== */
    assign dbg_pc         = PC;
    assign dbg_instr      = if_id_instr;      // ID-stage instruction
    assign dbg_alu_result = ALUResult_ex;     // EX-stage ALU

    assign dbg_x1 = rf_dbg_x1;
    assign dbg_x2 = rf_dbg_x2;
    assign dbg_x3 = rf_dbg_x3;
    assign dbg_x4 = rf_dbg_x4;
    assign dbg_x5 = rf_dbg_x5;
    assign dbg_x6 = rf_dbg_x6;
    assign dbg_x7 = rf_dbg_x7;

endmodule