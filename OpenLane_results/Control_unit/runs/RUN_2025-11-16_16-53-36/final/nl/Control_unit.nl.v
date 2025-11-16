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
 wire net1;
 wire net2;
 wire net3;
 wire net4;
 wire net5;
 wire net6;
 wire net7;
 wire net8;
 wire net9;
 wire net10;
 wire net11;
 wire net12;
 wire net13;
 wire net14;
 wire net15;
 wire net16;
 wire net17;
 wire net18;
 wire net19;
 wire net20;
 wire net21;
 wire net22;
 wire net23;

 sky130_fd_sc_hd__inv_2 _11_ (.A(net6),
    .Y(_00_));
 sky130_fd_sc_hd__or2_1 _12_ (.A(net22),
    .B(_00_),
    .X(_01_));
 sky130_fd_sc_hd__nor2_1 _13_ (.A(net23),
    .B(_01_),
    .Y(net19));
 sky130_fd_sc_hd__and3b_1 _14_ (.A_N(net22),
    .B(net23),
    .C(net6),
    .X(net16));
 sky130_fd_sc_hd__nand2b_1 _15_ (.A_N(net6),
    .B(net23),
    .Y(_02_));
 sky130_fd_sc_hd__nand2_1 _16_ (.A(_01_),
    .B(_02_),
    .Y(net13));
 sky130_fd_sc_hd__o21ai_1 _17_ (.A1(net22),
    .A2(net5),
    .B1(_02_),
    .Y(net18));
 sky130_fd_sc_hd__nor4_1 _18_ (.A(net7),
    .B(net4),
    .C(net3),
    .D(_02_),
    .Y(_03_));
 sky130_fd_sc_hd__and2b_1 _19_ (.A_N(net1),
    .B(net2),
    .X(_04_));
 sky130_fd_sc_hd__and3b_1 _20_ (.A_N(net23),
    .B(_00_),
    .C(net22),
    .X(net14));
 sky130_fd_sc_hd__nor3_1 _21_ (.A(net7),
    .B(net5),
    .C(net6),
    .Y(_05_));
 sky130_fd_sc_hd__a221o_1 _22_ (.A1(net20),
    .A2(_04_),
    .B1(net21),
    .B2(net1),
    .C1(net14),
    .X(net9));
 sky130_fd_sc_hd__and2b_1 _23_ (.A_N(net2),
    .B(net1),
    .X(_06_));
 sky130_fd_sc_hd__or2_1 _24_ (.A(_04_),
    .B(_06_),
    .X(_07_));
 sky130_fd_sc_hd__a22o_1 _25_ (.A1(net2),
    .A2(net21),
    .B1(_07_),
    .B2(net20),
    .X(net10));
 sky130_fd_sc_hd__a32o_1 _26_ (.A1(net2),
    .A2(net1),
    .A3(_03_),
    .B1(net21),
    .B2(net3),
    .X(net11));
 sky130_fd_sc_hd__and2_1 _27_ (.A(net4),
    .B(net21),
    .X(net12));
 sky130_fd_sc_hd__and3b_1 _28_ (.A_N(net6),
    .B(net23),
    .C(net22),
    .X(net15));
 sky130_fd_sc_hd__and4_1 _29_ (.A(net23),
    .B(_00_),
    .C(net4),
    .D(net3),
    .X(_08_));
 sky130_fd_sc_hd__xor2_1 _30_ (.A(net1),
    .B(net8),
    .X(_09_));
 sky130_fd_sc_hd__a31o_1 _31_ (.A1(net22),
    .A2(_00_),
    .A3(_09_),
    .B1(net15),
    .X(_10_));
 sky130_fd_sc_hd__a21o_1 _32_ (.A1(_06_),
    .A2(_08_),
    .B1(_10_),
    .X(net17));
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
 sky130_fd_sc_hd__buf_1 input1 (.A(func[0]),
    .X(net1));
 sky130_fd_sc_hd__buf_1 input2 (.A(func[1]),
    .X(net2));
 sky130_fd_sc_hd__buf_1 input3 (.A(func[2]),
    .X(net3));
 sky130_fd_sc_hd__clkbuf_1 input4 (.A(func[3]),
    .X(net4));
 sky130_fd_sc_hd__buf_1 input5 (.A(opcode[0]),
    .X(net5));
 sky130_fd_sc_hd__buf_1 input6 (.A(opcode[1]),
    .X(net6));
 sky130_fd_sc_hd__buf_1 input7 (.A(opcode[2]),
    .X(net7));
 sky130_fd_sc_hd__clkbuf_1 input8 (.A(zero),
    .X(net8));
 sky130_fd_sc_hd__buf_2 output9 (.A(net9),
    .X(ALUControl[0]));
 sky130_fd_sc_hd__buf_2 output10 (.A(net10),
    .X(ALUControl[1]));
 sky130_fd_sc_hd__buf_2 output11 (.A(net11),
    .X(ALUControl[2]));
 sky130_fd_sc_hd__buf_2 output12 (.A(net12),
    .X(ALUControl[3]));
 sky130_fd_sc_hd__buf_2 output13 (.A(net13),
    .X(ALUSrc));
 sky130_fd_sc_hd__buf_2 output14 (.A(net14),
    .X(ImmSrc[0]));
 sky130_fd_sc_hd__buf_2 output15 (.A(net15),
    .X(ImmSrc[1]));
 sky130_fd_sc_hd__buf_2 output16 (.A(net16),
    .X(MemWrite));
 sky130_fd_sc_hd__buf_2 output17 (.A(net17),
    .X(PCSrc));
 sky130_fd_sc_hd__buf_2 output18 (.A(net18),
    .X(RegWrite));
 sky130_fd_sc_hd__buf_2 output19 (.A(net19),
    .X(ResultSrc));
 sky130_fd_sc_hd__clkbuf_1 max_cap20 (.A(_03_),
    .X(net20));
 sky130_fd_sc_hd__buf_1 wire21 (.A(_05_),
    .X(net21));
 sky130_fd_sc_hd__buf_1 fanout22 (.A(net7),
    .X(net22));
 sky130_fd_sc_hd__buf_1 fanout23 (.A(net5),
    .X(net23));
 sky130_fd_sc_hd__decap_4 FILLER_0_9 ();
 sky130_fd_sc_hd__fill_1 FILLER_0_13 ();
 sky130_fd_sc_hd__fill_1 FILLER_0_27 ();
 sky130_fd_sc_hd__fill_2 FILLER_0_35 ();
 sky130_fd_sc_hd__decap_8 FILLER_1_10 ();
 sky130_fd_sc_hd__decap_3 FILLER_1_18 ();
 sky130_fd_sc_hd__fill_1 FILLER_1_44 ();
 sky130_ef_sc_hd__decap_12 FILLER_2_7 ();
 sky130_fd_sc_hd__decap_8 FILLER_2_19 ();
 sky130_fd_sc_hd__fill_1 FILLER_2_27 ();
 sky130_fd_sc_hd__fill_1 FILLER_2_29 ();
 sky130_fd_sc_hd__decap_4 FILLER_2_38 ();
 sky130_fd_sc_hd__decap_4 FILLER_3_3 ();
 sky130_fd_sc_hd__fill_1 FILLER_3_7 ();
 sky130_ef_sc_hd__decap_12 FILLER_3_21 ();
 sky130_fd_sc_hd__decap_4 FILLER_3_33 ();
 sky130_fd_sc_hd__decap_3 FILLER_3_42 ();
 sky130_fd_sc_hd__fill_2 FILLER_4_7 ();
 sky130_fd_sc_hd__decap_4 FILLER_4_16 ();
 sky130_fd_sc_hd__fill_1 FILLER_4_20 ();
 sky130_fd_sc_hd__decap_4 FILLER_4_34 ();
 sky130_fd_sc_hd__fill_1 FILLER_5_7 ();
 sky130_fd_sc_hd__decap_8 FILLER_5_15 ();
 sky130_fd_sc_hd__fill_1 FILLER_5_23 ();
 sky130_fd_sc_hd__decap_3 FILLER_5_28 ();
 sky130_fd_sc_hd__fill_1 FILLER_5_40 ();
 sky130_fd_sc_hd__fill_2 FILLER_6_6 ();
 sky130_fd_sc_hd__decap_8 FILLER_6_18 ();
 sky130_fd_sc_hd__fill_2 FILLER_6_26 ();
 sky130_fd_sc_hd__fill_2 FILLER_6_43 ();
 sky130_fd_sc_hd__decap_3 FILLER_7_6 ();
 sky130_fd_sc_hd__fill_1 FILLER_7_12 ();
 sky130_fd_sc_hd__fill_1 FILLER_7_16 ();
 sky130_fd_sc_hd__decap_3 FILLER_7_21 ();
 sky130_fd_sc_hd__fill_1 FILLER_7_27 ();
 sky130_fd_sc_hd__decap_8 FILLER_7_29 ();
endmodule
