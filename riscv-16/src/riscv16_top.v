`timescale 1ns / 1ps
module riscv16_top (
    input  wire        clk,
    input  wire        reset,
    output wire [15:0] dbg_pc,
    output wire [15:0] dbg_instr,
    output wire [15:0] dbg_alu_result,
    output wire [15:0] dbg_x1,
    output wire [15:0] dbg_x2,
    output wire [15:0] dbg_x3
);

    //===========================================================================
    // Pipeline Control
    //===========================================================================
    wire stall;
    wire flush_IF_ID;

    //===========================================================================
    // STAGE 1: IF
    //===========================================================================
    wire [15:0] PC, PC_next, PC_plus2;
    wire [15:0] instruction_IF;

    assign PC_plus2 = PC + 16'd2;

    pc_counter_16 PC_REG (
        .clk(clk),
        .reset(reset),
        .pc_en(~stall),
        .pc_next(PC_next),
        .pc(PC)
    );

    Instruction_memory #(
        .IMEM_WORDS(256),
        .MEMFILE("src/program16.mem")
    ) IMEM (
        .clk(clk),
        .pc(PC),
        .instruction(instruction_IF)
    );

    //===========================================================================
    // IF/ID
    //===========================================================================
    reg [15:0] PC_IF_ID;
    reg [15:0] PC_plus2_IF_ID;
    reg [15:0] instruction_IF_ID;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            PC_IF_ID          <= 16'h0000;
            PC_plus2_IF_ID    <= 16'h0000;
            instruction_IF_ID <= 16'h0000;
        end else if (flush_IF_ID) begin
            PC_IF_ID          <= 16'h0000;
            PC_plus2_IF_ID    <= 16'h0000;
            instruction_IF_ID <= 16'h0000;
        end else if (~stall) begin
            PC_IF_ID          <= PC;
            PC_plus2_IF_ID    <= PC_plus2;
            instruction_IF_ID <= instruction_IF;
        end
    end

    //===========================================================================
    // STAGE 2: ID/EX (decode + execute)
    //===========================================================================
    wire [15:0] instruction = instruction_IF_ID;

    // ISA opcode map [1]
    wire [2:0] opcode = instruction[2:0];
    localparam OPC_R = 3'b000;
    localparam OPC_I = 3'b001;
    localparam OPC_S = 3'b010; // stores [1]
    localparam OPC_B = 3'b011; // branches [1]
    localparam OPC_U = 3'b100; // U-type [1]
    localparam OPC_J = 3'b101; // J-type [1]
    // 110–111 reserved/system in ISA [1] (you may still use 111 as JR extension)

    wire [3:0] func = instruction[6:3];

    // Field extracts per ISA bit diagrams [1]
    // R-type: Rs1[15:13] Rs2[12:10] Rd[9:7] func[6:3] op[2:0]
    wire [2:0] rs1_r = instruction[15:13];
    wire [2:0] rs2_r = instruction[12:10];
    wire [2:0] rd_r  = instruction[9:7];

    // I-type: imm[2:0]=[15:13], Rs1=[12:10], Rd=[9:7], func=[6:3], op=[2:0] [1]
    wire [2:0] imm_i3 = instruction[15:13];
    wire [2:0] rs1_i  = instruction[12:10];
    wire [2:0] rd_i   = instruction[9:7];

    // S-type: imm[6:0]=[15:9], Rs1=[8:6], Rs2=[5:3], op=[2:0] [1]
    wire [6:0] imm_s7 = instruction[15:9];
    wire [2:0] rs1_s  = instruction[8:6];
    wire [2:0] rs2_s  = instruction[5:3];

    // B-type: imm[6:4]=[15:13], imm[3:0]=[12:9], Rs1=[8:6], Rs2=[5:3], op=[2:0] [1]
    wire [2:0] imm_b_hi = instruction[15:13];
    wire [3:0] imm_b_lo = instruction[12:9];
    wire [6:0] imm_b7   = {imm_b_hi, imm_b_lo};
    wire [2:0] rs1_b    = instruction[8:6];
    wire [2:0] rs2_b    = instruction[5:3];

    // U-type: imm[12:3]=[15:6], Rd=[5:3], op=[2:0] [1]
    wire [2:0] rd_u = instruction[5:3];

    // J-type: imm[15:9]=[15:9], Rs1=[8:6], Rd=[5:3], op=[2:0] [1]
    wire [6:0] imm_j7 = instruction[15:9];
    wire [2:0] rs1_j  = instruction[8:6];
    wire [2:0] rd_j   = instruction[5:3];

    // Register selects
    wire [2:0] rs1 =
        (opcode == OPC_R) ? rs1_r :
        (opcode == OPC_I) ? rs1_i :
        (opcode == OPC_S) ? rs1_s :
        (opcode == OPC_B) ? rs1_b :
        (opcode == OPC_J) ? rs1_j :
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
        3'b000;

    // Control signals
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

    // Register file + WB from MEM/WB stage
    wire [15:0] RD1, RD2, WD3;
    wire [15:0] rf_dbg_x1, rf_dbg_x2, rf_dbg_x3;

    reg  [2:0]  rd_MEM_WB;
    reg         RegWrite_MEM_WB;
    reg  [15:0] ALUResult_MEM_WB;
    reg  [15:0] ReadData_MEM_WB;
    reg  [1:0]  ResultSrc_MEM_WB;
    reg  [15:0] PC_plus2_MEM_WB;
    reg         MemRead_MEM_WB;

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

    // Immediate generation (your Sign_Extender)
    wire [15:0] imm_ext;
    Sign_Extender SE (
        .instr(instruction),
        .ImmSrc(ImmSrc),
        .ImmExt(imm_ext)
    );

    // Forwarding from MEM/WB
    wire [15:0] ForwardData =
        (ResultSrc_MEM_WB == 2'b01) ? ReadData_MEM_WB :
        (ResultSrc_MEM_WB == 2'b10) ? PC_plus2_MEM_WB :
                                      ALUResult_MEM_WB;

    wire forward_A = RegWrite_MEM_WB && (rd_MEM_WB != 3'b000) && (rd_MEM_WB == rs1);
    wire forward_B = RegWrite_MEM_WB && (rd_MEM_WB != 3'b000) && (rd_MEM_WB == rs2);

    wire [15:0] RD1_forwarded = forward_A ? ForwardData : RD1;
    wire [15:0] RD2_forwarded = forward_B ? ForwardData : RD2;

    // ALU
    wire [15:0] ALU_B;
    wire [15:0] ALUResult;

    ALUSrc_mux ALUSRC_MUX (
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

    // Branch/J/U/J immediate construction per ISA layouts [1]
    wire [15:0] imm_b = {{9{imm_b7[6]}}, imm_b7};   // 7-bit signed
    wire [15:0] imm_j = {{9{imm_j7[6]}}, imm_j7};   // 7-bit signed

    // Targets (ISA uses halfword alignment => <<1 like you had)
    wire [15:0] branch_target = PC_IF_ID + (imm_b << 1);

    // J-type uses Rs1 in ISA format [1]: target = rs1 + (imm<<1), clear bit0
    wire [15:0] jal_sum    = RD1_forwarded + (imm_j << 1);
    wire [15:0] jal_target = {jal_sum[15:1], 1'b0};

    // PC update:
    // - For J-type, we jump to jal_target.
    // - For branches, CU drives PCSrc.
    wire j_taken = (opcode == OPC_J);

    assign PC_next =
        j_taken   ? jal_target :
        PCSrc     ? branch_target :
                    PC_plus2;

    // Flush on any control-flow change
    assign flush_IF_ID = PCSrc | j_taken;

    // Load-use stall (kept as you had it; only relevant if you add loads)
    assign stall = MemRead_MEM_WB &&
                   ((rd_MEM_WB == rs1) || (rd_MEM_WB == rs2)) &&
                   (rd_MEM_WB != 3'b000);

    //===========================================================================
    // ID/EX -> MEM/WB pipeline reg (your existing single reg stage)
    //===========================================================================
    reg [15:0] ALUResult_ID_EX;
    reg [15:0] RD2_ID_EX;
    reg [2:0]  rd_ID_EX;
    reg        RegWrite_ID_EX;
    reg        MemWrite_ID_EX;
    reg        MemRead_ID_EX;
    reg [1:0]  ResultSrc_ID_EX;
    reg [15:0] PC_plus2_ID_EX;

    wire RegWrite_gated = (stall | flush_IF_ID) ? 1'b0 : RegWrite;
    wire MemWrite_gated = (stall | flush_IF_ID) ? 1'b0 : MemWrite;
    wire MemRead_gated  = (stall | flush_IF_ID) ? 1'b0 : MemRead;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            ALUResult_ID_EX <= 16'h0000;
            RD2_ID_EX       <= 16'h0000;
            rd_ID_EX        <= 3'b000;
            RegWrite_ID_EX  <= 1'b0;
            MemWrite_ID_EX  <= 1'b0;
            MemRead_ID_EX   <= 1'b0;
            ResultSrc_ID_EX <= 2'b00;
            PC_plus2_ID_EX  <= 16'h0000;
        end else begin
            ALUResult_ID_EX <= ALUResult;
            RD2_ID_EX       <= RD2_forwarded;
            rd_ID_EX        <= rd;
            RegWrite_ID_EX  <= RegWrite_gated;
            MemWrite_ID_EX  <= MemWrite_gated;
            MemRead_ID_EX   <= MemRead_gated;
            ResultSrc_ID_EX <= ResultSrc;
            PC_plus2_ID_EX  <= PC_plus2_IF_ID;
        end
    end

    //===========================================================================
    // STAGE 3: MEM/WB
    //===========================================================================
    wire [15:0] ReadData;

    Data_Memory DMEM (
        .clk(clk),
        .mem_access_addr(ALUResult_ID_EX),
        .mem_write_data(RD2_ID_EX),
        .mem_write_en(MemWrite_ID_EX),
        .mem_read(MemRead_ID_EX),
        .mem_read_data(ReadData)
    );

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            ALUResult_MEM_WB <= 16'h0000;
            ReadData_MEM_WB  <= 16'h0000;
            rd_MEM_WB        <= 3'b000;
            RegWrite_MEM_WB  <= 1'b0;
            ResultSrc_MEM_WB <= 2'b00;
            PC_plus2_MEM_WB  <= 16'h0000;
            MemRead_MEM_WB   <= 1'b0;
        end else begin
            ALUResult_MEM_WB <= ALUResult_ID_EX;
            ReadData_MEM_WB  <= ReadData;
            rd_MEM_WB        <= rd_ID_EX;
            RegWrite_MEM_WB  <= RegWrite_ID_EX;
            ResultSrc_MEM_WB <= ResultSrc_ID_EX;
            PC_plus2_MEM_WB  <= PC_plus2_ID_EX;
            MemRead_MEM_WB   <= MemRead_ID_EX;
        end
    end

    Writeback_mux WB_MUX (
        .ALUResult(ALUResult_MEM_WB),
        .MemData(ReadData_MEM_WB),
        .PcPlus2(PC_plus2_MEM_WB),
        .MemtoReg(ResultSrc_MEM_WB),
        .WD3(WD3)
    );

    //===========================================================================
    // Debug
    //===========================================================================
    assign dbg_pc         = PC;
    assign dbg_instr      = instruction_IF;
    assign dbg_alu_result = ALUResult;
    assign dbg_x1         = rf_dbg_x1;
    assign dbg_x2         = rf_dbg_x2;
    assign dbg_x3         = rf_dbg_x3;

endmodule