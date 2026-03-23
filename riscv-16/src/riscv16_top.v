`timescale 1ns / 1ps
module riscv16_top (
    input  wire        clk,
    input  wire        reset,
    // Debug outputs
    output wire [15:0] dbg_pc,
    output wire [15:0] dbg_instr,
    output wire [15:0] dbg_alu_result,
    output wire [15:0] dbg_x1,
    output wire [15:0] dbg_x2,
    output wire [15:0] dbg_x3
);

    //===========================================================================
    // Pipeline Control Signals
    //===========================================================================
    wire        stall;          // Stall IF and IF/ID stages
    wire        flush_IF_ID;    // Flush IF/ID register on branch/jump
    
    //===========================================================================
    //                         STAGE 1: INSTRUCTION FETCH (IF)
    //===========================================================================
    wire [15:0] PC, PC_next, PC_plus2;
    wire [15:0] instruction_IF;
    
    assign PC_plus2 = PC + 16'd2;
    
    // PC Register
    pc_counter_16 PC_REG (
        .clk(clk),
        .reset(reset),
        .pc_en(~stall),         // Stall PC when needed
        .pc_next(PC_next),
        .pc(PC)
    );
    
    // Instruction Memory
    Instruction_memory #(
        .IMEM_WORDS(256),
        .MEMFILE("src/program16.mem")
    ) IMEM (
        .clk(clk),
        .pc(PC),
        .instruction(instruction_IF)
    );

    //===========================================================================
    //                    IF/ID PIPELINE REGISTER
    //===========================================================================
    reg [15:0] PC_IF_ID;
    reg [15:0] PC_plus2_IF_ID;
    reg [15:0] instruction_IF_ID;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            PC_IF_ID          <= 16'h0000;
            PC_plus2_IF_ID    <= 16'h0000;
            instruction_IF_ID <= 16'h0000;  // NOP
        end
        else if (flush_IF_ID) begin
            // Insert bubble (NOP) on branch/jump
            PC_IF_ID          <= 16'h0000;
            PC_plus2_IF_ID    <= 16'h0000;
            instruction_IF_ID <= 16'h0000;  // NOP
        end
        else if (~stall) begin
            PC_IF_ID          <= PC;
            PC_plus2_IF_ID    <= PC_plus2;
            instruction_IF_ID <= instruction_IF;
        end
        // else: hold values (stall)
    end

    //===========================================================================
    //                 STAGE 2: INSTRUCTION DECODE / EXECUTE (ID/EX)
    //===========================================================================
    
    // Use instruction from IF/ID register
    wire [15:0] instruction = instruction_IF_ID;
    
    /* =====================
       Instruction Fields
    ===================== */
    wire [2:0] opcode = instruction[2:0];
    
    localparam OPC_R  = 3'b000;
    localparam OPC_I  = 3'b001;
    localparam OPC_L  = 3'b010;
    localparam OPC_S  = 3'b011;
    localparam OPC_B  = 3'b100;
    localparam OPC_J  = 3'b101;
    localparam OPC_U  = 3'b110;
    localparam OPC_JR = 3'b111;
    
    wire jal_taken  = (opcode == OPC_J);
    wire jalr_taken = (opcode == OPC_JR);
    
    wire [3:0] func = instruction[6:3];
    
    /* =====================
       Raw Field Extraction
    ===================== */
    // ---------- R-Type ----------
    wire [2:0] rs1_r = instruction[15:13];
    wire [2:0] rs2_r = instruction[12:10];
    wire [2:0] rd_r  = instruction[9:7];
    
    // ---------- I-Type ----------
    wire [5:0] imm_i_raw = instruction[15:10];
    wire [2:0] rs1_i     = instruction[9:7];
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
    wire [4:0] imm_b_raw = instruction[15:11];
    wire [2:0] rs1_b     = instruction[10:8];
    wire [2:0] rs2_b     = instruction[7:5];
    
    // ---------- U-Type ----------
    wire [9:0] imm_u_raw = instruction[15:6];
    wire [2:0] rd_u      = instruction[5:3];
    
    // ---------- J-Type ----------
    wire [9:0] imm_j_raw = instruction[15:6];
    wire [2:0] rd_j      = instruction[5:3];
    
    // ---------- JR-Type ----------
    wire [6:0] imm_jr_raw = instruction[15:9];
    wire [2:0] rs1_jr     = instruction[7:5];
    wire [2:0] rd_jr      = instruction[5:3];

    /* =====================
       Register Selection
    ===================== */
    wire [2:0] rs1 =
        (opcode == OPC_R)  ? rs1_r  :
        (opcode == OPC_I)  ? rs1_i  :
        (opcode == OPC_S)  ? rs1_s  :
        (opcode == OPC_B)  ? rs1_b  :
        (opcode == OPC_L)  ? rs1_l  :
        (opcode == OPC_JR) ? rs1_jr :
        3'b000;
        
    wire [2:0] rs2 =
        (opcode == OPC_R) ? rs2_r :
        (opcode == OPC_S) ? rs2_s :
        (opcode == OPC_B) ? rs2_b :
        3'b000;
        
    wire [2:0] rd =
        (opcode == OPC_R)  ? rd_r  :
        (opcode == OPC_I)  ? rd_i  :
        (opcode == OPC_U)  ? rd_u  :
        (opcode == OPC_J)  ? rd_j  :
        (opcode == OPC_L)  ? rd_l  :
        (opcode == OPC_JR) ? rd_jr :
        3'b000;

    /* =====================
       Immediate Construction
    ===================== */
    wire [15:0] imm_i = {{10{imm_i_raw[5]}}, imm_i_raw};
    wire [15:0] imm_s = {{9{imm_s_raw[6]}}, imm_s_raw};
    wire [15:0] imm_b = {{11{imm_b_raw[4]}}, imm_b_raw};
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
       Control Unit
    ===================== */
    wire        PCSrc;
    wire [1:0]  ResultSrc;
    wire        MemWrite;
    wire        MemRead;
    wire        ALUSrc;
    wire        RegWrite;
    wire [2:0]  ImmSrc;
    wire [3:0]  ALUControl;
    wire        zero;
    wire        negative;

    Control_unit CU (
        .opcode(opcode),
        .func(func),
        .zero(zero),
        .negative(negative),
        .PCSrc(PCSrc),
        .ResultSrc(ResultSrc),
        .MemWrite(MemWrite),
        .MemRead(MemRead),
        .ALUControl(ALUControl),
        .ALUSrc(ALUSrc),
        .ImmSrc(ImmSrc),
        .RegWrite(RegWrite)
    );

    /* =====================
       Register File
    ===================== */
    wire [15:0] RD1, RD2;
    wire [15:0] WD3;
    wire [15:0] rf_dbg_x1, rf_dbg_x2, rf_dbg_x3;
    
    // Writeback comes from MEM/WB stage
    wire [2:0]  rd_MEM_WB;
    wire        RegWrite_MEM_WB;

    Register_file RF (
        .clk(clk),
        .RegWrite(RegWrite_MEM_WB),
        .A3(rd_MEM_WB),
        .WD3(WD3),
        .A1(rs1),
        .RD1(RD1),
        .A2(rs2),
        .RD2(RD2),
        .dbg_x1(rf_dbg_x1),
        .dbg_x2(rf_dbg_x2),
        .dbg_x3(rf_dbg_x3)
    );

    /* =====================
       Immediate Generation
    ===================== */
    wire [15:0] imm_ext;
    
    Sign_Extender SE (
        .instr(instruction),
        .ImmSrc(ImmSrc),
        .ImmExt(imm_ext)
    );

    /* =====================
       Forwarding Logic (from MEM/WB to ID/EX)
    ===================== */
    wire [15:0] ALUResult_MEM_WB;
    wire [15:0] ReadData_MEM_WB;
    wire [1:0]  ResultSrc_MEM_WB;
    
    // Forward A
    wire forward_A = RegWrite_MEM_WB && (rd_MEM_WB != 3'b000) && (rd_MEM_WB == rs1);
    wire [15:0] ForwardData = (ResultSrc_MEM_WB == 2'b01) ? ReadData_MEM_WB :
                              (ResultSrc_MEM_WB == 2'b10) ? PC_plus2_MEM_WB :
                              ALUResult_MEM_WB;
    wire [15:0] RD1_forwarded = forward_A ? ForwardData : RD1;
    
    // Forward B
    wire forward_B = RegWrite_MEM_WB && (rd_MEM_WB != 3'b000) && (rd_MEM_WB == rs2);
    wire [15:0] RD2_forwarded = forward_B ? ForwardData : RD2;

    /* =====================
       ALU
    ===================== */
    wire [15:0] ALU_B;
    wire [15:0] ALUResult;

    ALUSrc_mux RD_2 (
        .RD2(RD2_forwarded),
        .ImmExt(imm_ext),
        .ALUSrc(ALUSrc),
        .SrcB(ALU_B)
    );

    ALU ALU_CORE (
        .SrcA(RD1_forwarded),
        .SrcB(ALU_B),
        .ALU_control(ALUControl),
        .ALU_result(ALUResult),
        .zero(zero),
        .negative(negative)
    );

    /* =====================
       Branch/Jump Target Calculation
    ===================== */
    wire [15:0] branch_target = PC_IF_ID + (imm_b << 1);
    wire [15:0] jal_target    = PC_IF_ID + (imm_j << 1);
    wire [15:0] jalr_sum      = RD1_forwarded + imm_ext;
    wire [15:0] jalr_target   = {jalr_sum[15:1], 1'b0};

    /* =====================
       PC Update Logic
    ===================== */
    wire branch_taken = PCSrc;
    
    assign PC_next = jalr_taken   ? jalr_target   :
                     jal_taken    ? jal_target    :
                     branch_taken ? branch_target :
                     PC_plus2;

    /* =====================
       Flush Logic
    ===================== */
    // Flush IF/ID on taken branch or jump
    assign flush_IF_ID = PCSrc | jal_taken | jalr_taken;

    /* =====================
       Load-Use Hazard Detection
    ===================== */
    wire load_use_hazard = MemRead_ID_EX && 
                           ((rd_ID_EX == rs1) || (rd_ID_EX == rs2)) &&
                           (rd_ID_EX != 3'b000);
    
    // For 3-stage pipeline with MEM in same stage as ID/EX writeback,
    // we need to check MEM/WB stage for load-use
    wire load_use_hazard_MEM = MemRead_MEM_WB && 
                               ((rd_MEM_WB == rs1) || (rd_MEM_WB == rs2)) &&
                               (rd_MEM_WB != 3'b000) &&
                               (ResultSrc_MEM_WB == 2'b01);  // Load instruction
    
    assign stall = load_use_hazard_MEM;

    //===========================================================================
    //                    ID_EX / MEM_WB PIPELINE REGISTER
    //===========================================================================
    reg [15:0] ALUResult_ID_EX;
    reg [15:0] RD2_ID_EX;
    reg [2:0]  rd_ID_EX;
    reg        RegWrite_ID_EX;
    reg        MemWrite_ID_EX;
    reg        MemRead_ID_EX;
    reg [1:0]  ResultSrc_ID_EX;
    reg [15:0] PC_plus2_ID_EX;
    
    // Squash control signals if stalling to insert bubble
    wire RegWrite_gated = stall ? 1'b0 : RegWrite;
    wire MemWrite_gated = stall ? 1'b0 : MemWrite;
    wire MemRead_gated  = stall ? 1'b0 : MemRead;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            ALUResult_ID_EX  <= 16'h0000;
            RD2_ID_EX        <= 16'h0000;
            rd_ID_EX         <= 3'b000;
            RegWrite_ID_EX   <= 1'b0;
            MemWrite_ID_EX   <= 1'b0;
            MemRead_ID_EX    <= 1'b0;
            ResultSrc_ID_EX  <= 2'b00;
            PC_plus2_ID_EX   <= 16'h0000;
        end
        else begin
            ALUResult_ID_EX  <= ALUResult;
            RD2_ID_EX        <= RD2_forwarded;
            rd_ID_EX         <= rd;
            RegWrite_ID_EX   <= RegWrite_gated;
            MemWrite_ID_EX   <= MemWrite_gated;
            MemRead_ID_EX    <= MemRead_gated;
            ResultSrc_ID_EX  <= ResultSrc;
            PC_plus2_ID_EX   <= PC_plus2_IF_ID;
        end
    end

    //===========================================================================
    //                 STAGE 3: MEMORY / WRITEBACK (MEM/WB)
    //===========================================================================
    
    /* =====================
       Data Memory
    ===================== */
    wire [15:0] ReadData;
    
    Data_Memory DMEM (
        .clk(clk),
        .mem_access_addr