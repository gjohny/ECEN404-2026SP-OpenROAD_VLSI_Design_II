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

 sky130_fd_sc_hd__or3b_2 _06_ (.A(ImmSrc[1]),
    .B(ImmSrc[0]),
    .C_N(instr[13]),
    .X(_00_));
 sky130_fd_sc_hd__a21bo_2 _07_ (.A1(ImmSrc[0]),
    .A2(instr[9]),
    .B1_N(_00_),
    .X(ImmExt[0]));
 sky130_fd_sc_hd__or3b_2 _08_ (.A(ImmSrc[1]),
    .B(ImmSrc[0]),
    .C_N(instr[14]),
    .X(_01_));
 sky130_fd_sc_hd__a21bo_2 _09_ (.A1(ImmSrc[0]),
    .A2(instr[10]),
    .B1_N(_01_),
    .X(ImmExt[1]));
 sky130_fd_sc_hd__nor3b_2 _10_ (.A(ImmSrc[1]),
    .B(ImmSrc[0]),
    .C_N(instr[15]),
    .Y(_02_));
 sky130_fd_sc_hd__a21o_2 _11_ (.A1(ImmSrc[0]),
    .A2(instr[11]),
    .B1(_02_),
    .X(ImmExt[2]));
 sky130_fd_sc_hd__a21o_2 _12_ (.A1(ImmSrc[0]),
    .A2(instr[12]),
    .B1(_02_),
    .X(ImmExt[3]));
 sky130_fd_sc_hd__a21o_2 _13_ (.A1(ImmSrc[0]),
    .A2(instr[13]),
    .B1(_02_),
    .X(ImmExt[4]));
 sky130_fd_sc_hd__a21o_2 _14_ (.A1(ImmSrc[0]),
    .A2(instr[14]),
    .B1(_02_),
    .X(ImmExt[5]));
 sky130_fd_sc_hd__nand2b_2 _15_ (.A_N(ImmSrc[0]),
    .B(ImmSrc[1]),
    .Y(_03_));
 sky130_fd_sc_hd__mux2_1 _16_ (.A0(instr[6]),
    .A1(instr[15]),
    .S(_03_),
    .X(ImmExt[6]));
 sky130_fd_sc_hd__mux2_1 _17_ (.A0(instr[7]),
    .A1(instr[15]),
    .S(_03_),
    .X(ImmExt[7]));
 sky130_fd_sc_hd__mux2_1 _18_ (.A0(instr[8]),
    .A1(instr[15]),
    .S(_03_),
    .X(ImmExt[8]));
 sky130_fd_sc_hd__mux2_1 _19_ (.A0(instr[9]),
    .A1(instr[15]),
    .S(_03_),
    .X(ImmExt[9]));
 sky130_fd_sc_hd__mux2_1 _20_ (.A0(instr[10]),
    .A1(instr[15]),
    .S(_03_),
    .X(ImmExt[10]));
 sky130_fd_sc_hd__mux2_1 _21_ (.A0(instr[11]),
    .A1(instr[15]),
    .S(_03_),
    .X(ImmExt[11]));
 sky130_fd_sc_hd__mux2_1 _22_ (.A0(instr[12]),
    .A1(instr[15]),
    .S(_03_),
    .X(ImmExt[12]));
 sky130_fd_sc_hd__and3b_2 _23_ (.A_N(ImmSrc[0]),
    .B(instr[13]),
    .C(ImmSrc[1]),
    .X(_04_));
 sky130_fd_sc_hd__a21o_2 _24_ (.A1(instr[15]),
    .A2(_03_),
    .B1(_04_),
    .X(ImmExt[13]));
 sky130_fd_sc_hd__and3b_2 _25_ (.A_N(ImmSrc[0]),
    .B(instr[14]),
    .C(ImmSrc[1]),
    .X(_05_));
 sky130_fd_sc_hd__a21o_2 _26_ (.A1(instr[15]),
    .A2(_03_),
    .B1(_05_),
    .X(ImmExt[14]));
 sky130_fd_sc_hd__buf_2 _27_ (.A(instr[15]),
    .X(ImmExt[15]));
endmodule
