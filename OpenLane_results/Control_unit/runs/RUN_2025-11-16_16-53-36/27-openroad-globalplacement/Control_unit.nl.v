module Control_unit (ALUSrc,
    MemWrite,
    PCSrc,
    RegWrite,
    ResultSrc,
    zero,
    ALUControl,
    ImmSrc,
    func,
    opcode);
 output ALUSrc;
 output MemWrite;
 output PCSrc;
 output RegWrite;
 output ResultSrc;
 input zero;
 output [3:0] ALUControl;
 output [1:0] ImmSrc;
 input [3:0] func;
 input [2:0] opcode;

 wire _00_;
 wire _01_;
 wire _02_;
 wire _03_;
 wire _04_;
 wire _05_;
 wire _06_;
 wire _07_;
 wire _08_;
 wire _09_;
 wire _10_;

 sky130_fd_sc_hd__inv_2 _11_ (.A(opcode[1]),
    .Y(_00_));
 sky130_fd_sc_hd__or2_2 _12_ (.A(opcode[2]),
    .B(_00_),
    .X(_01_));
 sky130_fd_sc_hd__nor2_2 _13_ (.A(opcode[0]),
    .B(_01_),
    .Y(ResultSrc));
 sky130_fd_sc_hd__and3b_2 _14_ (.A_N(opcode[2]),
    .B(opcode[0]),
    .C(opcode[1]),
    .X(MemWrite));
 sky130_fd_sc_hd__nand2b_2 _15_ (.A_N(opcode[1]),
    .B(opcode[0]),
    .Y(_02_));
 sky130_fd_sc_hd__nand2_2 _16_ (.A(_01_),
    .B(_02_),
    .Y(ALUSrc));
 sky130_fd_sc_hd__o21ai_2 _17_ (.A1(opcode[2]),
    .A2(opcode[0]),
    .B1(_02_),
    .Y(RegWrite));
 sky130_fd_sc_hd__nor4_2 _18_ (.A(opcode[2]),
    .B(func[3]),
    .C(func[2]),
    .D(_02_),
    .Y(_03_));
 sky130_fd_sc_hd__and2b_2 _19_ (.A_N(func[0]),
    .B(func[1]),
    .X(_04_));
 sky130_fd_sc_hd__and3b_2 _20_ (.A_N(opcode[0]),
    .B(_00_),
    .C(opcode[2]),
    .X(ImmSrc[0]));
 sky130_fd_sc_hd__nor3_2 _21_ (.A(opcode[2]),
    .B(opcode[0]),
    .C(opcode[1]),
    .Y(_05_));
 sky130_fd_sc_hd__a221o_2 _22_ (.A1(_03_),
    .A2(_04_),
    .B1(_05_),
    .B2(func[0]),
    .C1(ImmSrc[0]),
    .X(ALUControl[0]));
 sky130_fd_sc_hd__and2b_2 _23_ (.A_N(func[1]),
    .B(func[0]),
    .X(_06_));
 sky130_fd_sc_hd__or2_2 _24_ (.A(_04_),
    .B(_06_),
    .X(_07_));
 sky130_fd_sc_hd__a22o_2 _25_ (.A1(func[1]),
    .A2(_05_),
    .B1(_07_),
    .B2(_03_),
    .X(ALUControl[1]));
 sky130_fd_sc_hd__a32o_2 _26_ (.A1(func[1]),
    .A2(func[0]),
    .A3(_03_),
    .B1(_05_),
    .B2(func[2]),
    .X(ALUControl[2]));
 sky130_fd_sc_hd__and2_2 _27_ (.A(func[3]),
    .B(_05_),
    .X(ALUControl[3]));
 sky130_fd_sc_hd__and3b_2 _28_ (.A_N(opcode[1]),
    .B(opcode[0]),
    .C(opcode[2]),
    .X(ImmSrc[1]));
 sky130_fd_sc_hd__and4_2 _29_ (.A(opcode[0]),
    .B(_00_),
    .C(func[3]),
    .D(func[2]),
    .X(_08_));
 sky130_fd_sc_hd__xor2_2 _30_ (.A(func[0]),
    .B(zero),
    .X(_09_));
 sky130_fd_sc_hd__a31o_2 _31_ (.A1(opcode[2]),
    .A2(_00_),
    .A3(_09_),
    .B1(ImmSrc[1]),
    .X(_10_));
 sky130_fd_sc_hd__a21o_2 _32_ (.A1(_06_),
    .A2(_08_),
    .B1(_10_),
    .X(PCSrc));
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_0_Right_0 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_1_Right_1 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_2_Right_2 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_3_Right_3 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_4_Right_4 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_5_Right_5 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_6_Right_6 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_7_Right_7 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_0_Left_8 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_1_Left_9 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_2_Left_10 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_3_Left_11 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_4_Left_12 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_5_Left_13 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_6_Left_14 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_7_Left_15 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_0_16 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_2_17 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_4_18 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_6_19 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_7_20 ();
endmodule
