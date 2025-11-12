module Control_Unit (ALUSrc,
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
 wire _02_;
 wire _03_;
 wire _04_;
 wire _05_;
 wire _06_;
 wire _07_;
 wire _08_;
 wire _09_;
 wire _10_;
 wire _11_;
 wire _12_;
 wire _13_;
 wire _14_;
 wire _15_;
 wire _16_;
 wire _17_;
 wire net1;
 wire net2;
 wire net3;
 wire net4;
 wire net5;
 wire net6;
 wire net7;
 wire net8;

 sky130_fd_sc_hd__nor3b_1 _20_ (.A(net5),
    .B(net6),
    .C_N(net7),
    .Y(net14));
 sky130_fd_sc_hd__inv_1 _21_ (.A(net5),
    .Y(_02_));
 sky130_fd_sc_hd__nor3b_1 _22_ (.A(net6),
    .B(_02_),
    .C_N(net7),
    .Y(net15));
 sky130_fd_sc_hd__nor2_1 _23_ (.A(net7),
    .B(net1),
    .Y(_03_));
 sky130_fd_sc_hd__nor3b_4 _24_ (.A(net7),
    .B(net3),
    .C_N(net5),
    .Y(_04_));
 sky130_fd_sc_hd__nor2_1 _25_ (.A(net6),
    .B(net4),
    .Y(_05_));
 sky130_fd_sc_hd__nand4b_1 _26_ (.A_N(net1),
    .B(_04_),
    .C(_05_),
    .D(net2),
    .Y(_06_));
 sky130_fd_sc_hd__o31ai_1 _27_ (.A1(net5),
    .A2(net6),
    .A3(_03_),
    .B1(_06_),
    .Y(net9));
 sky130_fd_sc_hd__nand3_1 _28_ (.A(net1),
    .B(_04_),
    .C(_05_),
    .Y(_07_));
 sky130_fd_sc_hd__nor3_1 _29_ (.A(net6),
    .B(net1),
    .C(net4),
    .Y(_08_));
 sky130_fd_sc_hd__nor3_1 _30_ (.A(net7),
    .B(net5),
    .C(net6),
    .Y(_09_));
 sky130_fd_sc_hd__a21oi_1 _31_ (.A1(_04_),
    .A2(_08_),
    .B1(_09_),
    .Y(_10_));
 sky130_fd_sc_hd__mux2i_1 _32_ (.A0(_07_),
    .A1(_10_),
    .S(net2),
    .Y(net10));
 sky130_fd_sc_hd__nand2_1 _33_ (.A(net3),
    .B(_09_),
    .Y(_11_));
 sky130_fd_sc_hd__nand4_1 _34_ (.A(net2),
    .B(net1),
    .C(_04_),
    .D(_05_),
    .Y(_12_));
 sky130_fd_sc_hd__nand2_1 _35_ (.A(_11_),
    .B(_12_),
    .Y(net11));
 sky130_fd_sc_hd__and2_1 _36_ (.A(net4),
    .B(_09_),
    .X(net12));
 sky130_fd_sc_hd__nand2b_1 _37_ (.A_N(net7),
    .B(net6),
    .Y(_13_));
 sky130_fd_sc_hd__o21ai_0 _38_ (.A1(_02_),
    .A2(net6),
    .B1(_13_),
    .Y(net13));
 sky130_fd_sc_hd__nor2_1 _39_ (.A(_02_),
    .B(_13_),
    .Y(net16));
 sky130_fd_sc_hd__nor2b_1 _40_ (.A(net2),
    .B_N(net1),
    .Y(_14_));
 sky130_fd_sc_hd__nand4_1 _41_ (.A(net5),
    .B(net4),
    .C(net3),
    .D(_14_),
    .Y(_15_));
 sky130_fd_sc_hd__xor2_1 _42_ (.A(net1),
    .B(net8),
    .X(_16_));
 sky130_fd_sc_hd__o21ai_0 _43_ (.A1(net5),
    .A2(_16_),
    .B1(net7),
    .Y(_17_));
 sky130_fd_sc_hd__a21oi_1 _44_ (.A1(_15_),
    .A2(_17_),
    .B1(net6),
    .Y(net17));
 sky130_fd_sc_hd__mux2i_1 _45_ (.A0(net7),
    .A1(net6),
    .S(net5),
    .Y(net18));
 sky130_fd_sc_hd__nor2_1 _46_ (.A(net5),
    .B(_13_),
    .Y(net19));
 sky130_fd_sc_hd__clkdlybuf4s50_1 input1 (.A(func[0]),
    .X(net1));
 sky130_fd_sc_hd__clkdlybuf4s50_1 input2 (.A(func[1]),
    .X(net2));
 sky130_fd_sc_hd__clkdlybuf4s50_1 input3 (.A(func[2]),
    .X(net3));
 sky130_fd_sc_hd__clkdlybuf4s50_1 input4 (.A(func[3]),
    .X(net4));
 sky130_fd_sc_hd__clkdlybuf4s50_1 input5 (.A(opcode[0]),
    .X(net5));
 sky130_fd_sc_hd__clkdlybuf4s50_1 input6 (.A(opcode[1]),
    .X(net6));
 sky130_fd_sc_hd__clkdlybuf4s50_1 input7 (.A(opcode[2]),
    .X(net7));
 sky130_fd_sc_hd__clkdlybuf4s50_1 input8 (.A(zero),
    .X(net8));
 sky130_fd_sc_hd__clkdlybuf4s50_1 output9 (.A(net9),
    .X(ALUControl[0]));
 sky130_fd_sc_hd__clkdlybuf4s50_1 output10 (.A(net10),
    .X(ALUControl[1]));
 sky130_fd_sc_hd__clkdlybuf4s50_1 output11 (.A(net11),
    .X(ALUControl[2]));
 sky130_fd_sc_hd__clkdlybuf4s50_1 output12 (.A(net12),
    .X(ALUControl[3]));
 sky130_fd_sc_hd__clkdlybuf4s50_1 output13 (.A(net13),
    .X(ALUSrc));
 sky130_fd_sc_hd__clkdlybuf4s50_1 output14 (.A(net14),
    .X(ImmSrc[0]));
 sky130_fd_sc_hd__clkdlybuf4s50_1 output15 (.A(net15),
    .X(ImmSrc[1]));
 sky130_fd_sc_hd__clkdlybuf4s50_1 output16 (.A(net16),
    .X(MemWrite));
 sky130_fd_sc_hd__clkdlybuf4s50_1 output17 (.A(net17),
    .X(PCSrc));
 sky130_fd_sc_hd__clkdlybuf4s50_1 output18 (.A(net18),
    .X(RegWrite));
 sky130_fd_sc_hd__clkdlybuf4s50_1 output19 (.A(net19),
    .X(ResultSrc));
endmodule
