module Sign_Extender (ImmExt,
    ImmSrc,
    instr);
 output [15:0] ImmExt;
 input [1:0] ImmSrc;
 input [15:0] instr;

 wire _00_;
 wire _01_;
 wire _02_;
 wire _03_;
 wire _04_;
 wire _05_;
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
 wire net24;
 wire net25;
 wire net26;
 wire net27;
 wire net28;
 wire net29;
 wire net30;
 wire net31;

 sky130_fd_sc_hd__or3b_1 _06_ (.A(net2),
    .B(net31),
    .C_N(net6),
    .X(_00_));
 sky130_fd_sc_hd__a21bo_1 _07_ (.A1(net31),
    .A2(net12),
    .B1_N(_00_),
    .X(net13));
 sky130_fd_sc_hd__or3b_1 _08_ (.A(net2),
    .B(net31),
    .C_N(net7),
    .X(_01_));
 sky130_fd_sc_hd__a21bo_1 _09_ (.A1(net31),
    .A2(net3),
    .B1_N(_01_),
    .X(net20));
 sky130_fd_sc_hd__nor3b_1 _10_ (.A(net2),
    .B(net31),
    .C_N(net30),
    .Y(_02_));
 sky130_fd_sc_hd__a21o_1 _11_ (.A1(net31),
    .A2(net4),
    .B1(net29),
    .X(net21));
 sky130_fd_sc_hd__a21o_1 _12_ (.A1(net31),
    .A2(net5),
    .B1(net29),
    .X(net22));
 sky130_fd_sc_hd__a21o_1 _13_ (.A1(net1),
    .A2(net6),
    .B1(_02_),
    .X(net23));
 sky130_fd_sc_hd__a21o_1 _14_ (.A1(net31),
    .A2(net7),
    .B1(net29),
    .X(net24));
 sky130_fd_sc_hd__nand2b_4 _15_ (.A_N(net31),
    .B(net2),
    .Y(_03_));
 sky130_fd_sc_hd__mux2_1 _16_ (.A0(net9),
    .A1(net30),
    .S(_03_),
    .X(net25));
 sky130_fd_sc_hd__mux2_1 _17_ (.A0(net10),
    .A1(net30),
    .S(_03_),
    .X(net26));
 sky130_fd_sc_hd__mux2_1 _18_ (.A0(net11),
    .A1(net30),
    .S(_03_),
    .X(net27));
 sky130_fd_sc_hd__mux2_1 _19_ (.A0(net12),
    .A1(net30),
    .S(_03_),
    .X(net28));
 sky130_fd_sc_hd__mux2_1 _20_ (.A0(net3),
    .A1(net30),
    .S(_03_),
    .X(net14));
 sky130_fd_sc_hd__mux2_1 _21_ (.A0(net4),
    .A1(net30),
    .S(_03_),
    .X(net15));
 sky130_fd_sc_hd__mux2_1 _22_ (.A0(net5),
    .A1(net30),
    .S(_03_),
    .X(net16));
 sky130_fd_sc_hd__and3b_1 _23_ (.A_N(net1),
    .B(net6),
    .C(net2),
    .X(_04_));
 sky130_fd_sc_hd__a21o_1 _24_ (.A1(net30),
    .A2(_03_),
    .B1(_04_),
    .X(net17));
 sky130_fd_sc_hd__and3b_1 _25_ (.A_N(net31),
    .B(net7),
    .C(net2),
    .X(_05_));
 sky130_fd_sc_hd__a21o_1 _26_ (.A1(net30),
    .A2(_03_),
    .B1(_05_),
    .X(net18));
 sky130_fd_sc_hd__clkbuf_1 _27_ (.A(net8),
    .X(net19));
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_0_Right_0 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_1_Right_1 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_2_Right_2 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_3_Right_3 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_4_Right_4 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_5_Right_5 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_6_Right_6 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_7_Right_7 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_8_Right_8 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_9_Right_9 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_10_Right_10 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_11_Right_11 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_12_Right_12 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_13_Right_13 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_14_Right_14 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_15_Right_15 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_16_Right_16 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_0_Left_17 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_1_Left_18 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_2_Left_19 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_3_Left_20 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_4_Left_21 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_5_Left_22 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_6_Left_23 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_7_Left_24 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_8_Left_25 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_9_Left_26 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_10_Left_27 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_11_Left_28 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_12_Left_29 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_13_Left_30 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_14_Left_31 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_15_Left_32 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_16_Left_33 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_0_34 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_0_35 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_0_36 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_1_37 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_2_38 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_2_39 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_3_40 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_4_41 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_4_42 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_5_43 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_6_44 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_6_45 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_7_46 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_8_47 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_8_48 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_9_49 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_10_50 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_10_51 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_11_52 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_12_53 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_12_54 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_13_55 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_14_56 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_14_57 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_15_58 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_16_59 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_16_60 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_16_61 ();
 sky130_fd_sc_hd__buf_1 input1 (.A(ImmSrc[0]),
    .X(net1));
 sky130_fd_sc_hd__clkbuf_2 input2 (.A(ImmSrc[1]),
    .X(net2));
 sky130_fd_sc_hd__clkbuf_1 input3 (.A(instr[10]),
    .X(net3));
 sky130_fd_sc_hd__clkbuf_1 input4 (.A(instr[11]),
    .X(net4));
 sky130_fd_sc_hd__clkbuf_1 input5 (.A(instr[12]),
    .X(net5));
 sky130_fd_sc_hd__buf_1 input6 (.A(instr[13]),
    .X(net6));
 sky130_fd_sc_hd__buf_1 input7 (.A(instr[14]),
    .X(net7));
 sky130_fd_sc_hd__clkbuf_1 input8 (.A(instr[15]),
    .X(net8));
 sky130_fd_sc_hd__clkbuf_1 input9 (.A(instr[6]),
    .X(net9));
 sky130_fd_sc_hd__clkbuf_1 input10 (.A(instr[7]),
    .X(net10));
 sky130_fd_sc_hd__clkbuf_1 input11 (.A(instr[8]),
    .X(net11));
 sky130_fd_sc_hd__clkbuf_1 input12 (.A(instr[9]),
    .X(net12));
 sky130_fd_sc_hd__buf_2 output13 (.A(net13),
    .X(ImmExt[0]));
 sky130_fd_sc_hd__buf_2 output14 (.A(net14),
    .X(ImmExt[10]));
 sky130_fd_sc_hd__buf_2 output15 (.A(net15),
    .X(ImmExt[11]));
 sky130_fd_sc_hd__buf_2 output16 (.A(net16),
    .X(ImmExt[12]));
 sky130_fd_sc_hd__buf_2 output17 (.A(net17),
    .X(ImmExt[13]));
 sky130_fd_sc_hd__buf_2 output18 (.A(net18),
    .X(ImmExt[14]));
 sky130_fd_sc_hd__buf_2 output19 (.A(net19),
    .X(ImmExt[15]));
 sky130_fd_sc_hd__buf_2 output20 (.A(net20),
    .X(ImmExt[1]));
 sky130_fd_sc_hd__buf_2 output21 (.A(net21),
    .X(ImmExt[2]));
 sky130_fd_sc_hd__buf_2 output22 (.A(net22),
    .X(ImmExt[3]));
 sky130_fd_sc_hd__buf_2 output23 (.A(net23),
    .X(ImmExt[4]));
 sky130_fd_sc_hd__buf_2 output24 (.A(net24),
    .X(ImmExt[5]));
 sky130_fd_sc_hd__buf_2 output25 (.A(net25),
    .X(ImmExt[6]));
 sky130_fd_sc_hd__buf_2 output26 (.A(net26),
    .X(ImmExt[7]));
 sky130_fd_sc_hd__buf_2 output27 (.A(net27),
    .X(ImmExt[8]));
 sky130_fd_sc_hd__buf_2 output28 (.A(net28),
    .X(ImmExt[9]));
 sky130_fd_sc_hd__buf_1 max_cap29 (.A(_02_),
    .X(net29));
 sky130_fd_sc_hd__buf_2 fanout30 (.A(net8),
    .X(net30));
 sky130_fd_sc_hd__buf_2 fanout31 (.A(net1),
    .X(net31));
endmodule
