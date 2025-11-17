module Instruction_Memory_16 (clk,
    instruction,
    pc);
 input clk;
 output [15:0] instruction;
 input [15:0] pc;

 wire _000_;
 wire _001_;
 wire _002_;
 wire _003_;
 wire _004_;
 wire _005_;
 wire _006_;
 wire _007_;
 wire _008_;
 wire _009_;
 wire _010_;
 wire _011_;
 wire _012_;
 wire _013_;
 wire _014_;
 wire _015_;
 wire _016_;
 wire _017_;
 wire _018_;
 wire _019_;
 wire _020_;
 wire _021_;
 wire _022_;
 wire _023_;
 wire _024_;
 wire _025_;
 wire _026_;
 wire _027_;
 wire _028_;
 wire _029_;
 wire _030_;
 wire _031_;
 wire _032_;
 wire _033_;
 wire _034_;
 wire _035_;
 wire _036_;
 wire _037_;
 wire _038_;
 wire _039_;
 wire _040_;
 wire _041_;
 wire _042_;
 wire _043_;
 wire _044_;
 wire _045_;
 wire _046_;
 wire _047_;
 wire _048_;
 wire _049_;
 wire _050_;
 wire _051_;
 wire _052_;
 wire _053_;
 wire _054_;
 wire _055_;
 wire _056_;
 wire _057_;
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
 wire net32;
 wire net33;
 wire net34;
 wire net35;

 sky130_fd_sc_hd__inv_2 _058_ (.A(net35),
    .Y(_014_));
 sky130_fd_sc_hd__inv_2 _059_ (.A(net10),
    .Y(_015_));
 sky130_fd_sc_hd__inv_2 _060_ (.A(net33),
    .Y(_016_));
 sky130_fd_sc_hd__inv_2 _061_ (.A(net11),
    .Y(_017_));
 sky130_fd_sc_hd__or4_1 _062_ (.A(net4),
    .B(net3),
    .C(net6),
    .D(net5),
    .X(_018_));
 sky130_fd_sc_hd__or4_1 _063_ (.A(net15),
    .B(net14),
    .C(net2),
    .D(net1),
    .X(_019_));
 sky130_fd_sc_hd__nor4_1 _064_ (.A(net13),
    .B(net12),
    .C(_018_),
    .D(_019_),
    .Y(_020_));
 sky130_fd_sc_hd__or4_4 _065_ (.A(net13),
    .B(net12),
    .C(_018_),
    .D(_019_),
    .X(_021_));
 sky130_fd_sc_hd__nand2_1 _066_ (.A(_014_),
    .B(net11),
    .Y(_022_));
 sky130_fd_sc_hd__nand2_1 _067_ (.A(net35),
    .B(net8),
    .Y(_023_));
 sky130_fd_sc_hd__or2_1 _068_ (.A(net35),
    .B(net8),
    .X(_024_));
 sky130_fd_sc_hd__xnor2_4 _069_ (.A(net35),
    .B(net8),
    .Y(_025_));
 sky130_fd_sc_hd__or2_1 _070_ (.A(net10),
    .B(net11),
    .X(_026_));
 sky130_fd_sc_hd__nand2b_1 _071_ (.A_N(net10),
    .B(net33),
    .Y(_027_));
 sky130_fd_sc_hd__or3_1 _072_ (.A(net11),
    .B(_025_),
    .C(_027_),
    .X(_028_));
 sky130_fd_sc_hd__a21oi_1 _073_ (.A1(_022_),
    .A2(_028_),
    .B1(_021_),
    .Y(_000_));
 sky130_fd_sc_hd__or3_1 _074_ (.A(net35),
    .B(net11),
    .C(_027_),
    .X(_029_));
 sky130_fd_sc_hd__nand2b_2 _075_ (.A_N(net10),
    .B(net11),
    .Y(_030_));
 sky130_fd_sc_hd__nor2_1 _076_ (.A(_016_),
    .B(_030_),
    .Y(_031_));
 sky130_fd_sc_hd__and4bb_1 _077_ (.A_N(net35),
    .B_N(net10),
    .C(net33),
    .D(net8),
    .X(_032_));
 sky130_fd_sc_hd__a211o_1 _078_ (.A1(_025_),
    .A2(_027_),
    .B1(_032_),
    .C1(_017_),
    .X(_033_));
 sky130_fd_sc_hd__a21oi_1 _079_ (.A1(_029_),
    .A2(_033_),
    .B1(_021_),
    .Y(_001_));
 sky130_fd_sc_hd__a21o_1 _080_ (.A1(net33),
    .A2(_025_),
    .B1(_026_),
    .X(_034_));
 sky130_fd_sc_hd__and2b_1 _081_ (.A_N(net33),
    .B(net35),
    .X(_035_));
 sky130_fd_sc_hd__a211o_1 _082_ (.A1(net33),
    .A2(_025_),
    .B1(_026_),
    .C1(_035_),
    .X(_036_));
 sky130_fd_sc_hd__and2_1 _083_ (.A(net35),
    .B(net33),
    .X(_037_));
 sky130_fd_sc_hd__nor2_1 _084_ (.A(net7),
    .B(net33),
    .Y(_038_));
 sky130_fd_sc_hd__nor2_1 _085_ (.A(net34),
    .B(net8),
    .Y(_039_));
 sky130_fd_sc_hd__a21oi_1 _086_ (.A1(net7),
    .A2(net8),
    .B1(net34),
    .Y(_040_));
 sky130_fd_sc_hd__a311o_1 _087_ (.A1(net10),
    .A2(net8),
    .A3(_037_),
    .B1(_040_),
    .C1(_017_),
    .X(_041_));
 sky130_fd_sc_hd__a21oi_1 _088_ (.A1(_036_),
    .A2(_041_),
    .B1(_021_),
    .Y(_002_));
 sky130_fd_sc_hd__nor2_1 _089_ (.A(net11),
    .B(_037_),
    .Y(_042_));
 sky130_fd_sc_hd__nor2_1 _090_ (.A(_026_),
    .B(_037_),
    .Y(_043_));
 sky130_fd_sc_hd__a211o_1 _091_ (.A1(net35),
    .A2(net33),
    .B1(net11),
    .C1(net10),
    .X(_044_));
 sky130_fd_sc_hd__a21oi_1 _092_ (.A1(_016_),
    .A2(_025_),
    .B1(_044_),
    .Y(_045_));
 sky130_fd_sc_hd__and3_1 _093_ (.A(net8),
    .B(net11),
    .C(_037_),
    .X(_046_));
 sky130_fd_sc_hd__o31a_1 _094_ (.A1(_031_),
    .A2(_045_),
    .A3(_046_),
    .B1(_020_),
    .X(_003_));
 sky130_fd_sc_hd__o21bai_1 _095_ (.A1(_037_),
    .A2(_038_),
    .B1_N(_030_),
    .Y(_047_));
 sky130_fd_sc_hd__or3_1 _096_ (.A(net7),
    .B(net34),
    .C(_030_),
    .X(_048_));
 sky130_fd_sc_hd__a21oi_1 _097_ (.A1(_034_),
    .A2(_047_),
    .B1(_021_),
    .Y(_004_));
 sky130_fd_sc_hd__a211o_1 _098_ (.A1(net34),
    .A2(_025_),
    .B1(_026_),
    .C1(_038_),
    .X(_049_));
 sky130_fd_sc_hd__a211o_1 _099_ (.A1(_014_),
    .A2(net8),
    .B1(_030_),
    .C1(_039_),
    .X(_050_));
 sky130_fd_sc_hd__a21oi_1 _100_ (.A1(_049_),
    .A2(_050_),
    .B1(_021_),
    .Y(_005_));
 sky130_fd_sc_hd__nor2_1 _101_ (.A(_039_),
    .B(_044_),
    .Y(_051_));
 sky130_fd_sc_hd__o21a_1 _102_ (.A1(_031_),
    .A2(_051_),
    .B1(net32),
    .X(_006_));
 sky130_fd_sc_hd__a21oi_1 _103_ (.A1(_028_),
    .A2(_048_),
    .B1(_021_),
    .Y(_007_));
 sky130_fd_sc_hd__o211a_1 _104_ (.A1(net34),
    .A2(_024_),
    .B1(_023_),
    .C1(net11),
    .X(_052_));
 sky130_fd_sc_hd__o211a_1 _105_ (.A1(_042_),
    .A2(_052_),
    .B1(_015_),
    .C1(net32),
    .X(_008_));
 sky130_fd_sc_hd__or4_1 _106_ (.A(_030_),
    .B(_037_),
    .C(_038_),
    .D(_039_),
    .X(_053_));
 sky130_fd_sc_hd__a21oi_1 _107_ (.A1(_049_),
    .A2(_053_),
    .B1(_021_),
    .Y(_009_));
 sky130_fd_sc_hd__o221a_1 _108_ (.A1(_023_),
    .A2(_043_),
    .B1(_051_),
    .B2(_031_),
    .C1(net32),
    .X(_010_));
 sky130_fd_sc_hd__or2_1 _109_ (.A(net7),
    .B(_030_),
    .X(_054_));
 sky130_fd_sc_hd__a21oi_1 _110_ (.A1(_034_),
    .A2(_054_),
    .B1(_021_),
    .Y(_011_));
 sky130_fd_sc_hd__o21a_1 _111_ (.A1(net35),
    .A2(net8),
    .B1(net33),
    .X(_055_));
 sky130_fd_sc_hd__a211o_1 _112_ (.A1(_016_),
    .A2(_025_),
    .B1(_030_),
    .C1(_055_),
    .X(_056_));
 sky130_fd_sc_hd__a21oi_1 _113_ (.A1(_029_),
    .A2(_056_),
    .B1(_021_),
    .Y(_012_));
 sky130_fd_sc_hd__or3b_1 _114_ (.A(_030_),
    .B(_040_),
    .C_N(_024_),
    .X(_057_));
 sky130_fd_sc_hd__a21oi_1 _115_ (.A1(_049_),
    .A2(_057_),
    .B1(_021_),
    .Y(_013_));
 sky130_fd_sc_hd__dfxtp_1 _116_ (.CLK(clk),
    .D(_000_),
    .Q(net16));
 sky130_fd_sc_hd__dfxtp_1 _117_ (.CLK(clk),
    .D(_001_),
    .Q(net23));
 sky130_fd_sc_hd__dfxtp_1 _118_ (.CLK(clk),
    .D(_002_),
    .Q(net24));
 sky130_fd_sc_hd__dfxtp_1 _119_ (.CLK(clk),
    .D(_003_),
    .Q(net25));
 sky130_fd_sc_hd__dfxtp_1 _120_ (.CLK(clk),
    .D(_004_),
    .Q(net26));
 sky130_fd_sc_hd__dfxtp_1 _121_ (.CLK(clk),
    .D(_005_),
    .Q(net28));
 sky130_fd_sc_hd__dfxtp_1 _122_ (.CLK(clk),
    .D(_006_),
    .Q(net22));
 sky130_fd_sc_hd__dfxtp_1 _123_ (.CLK(clk),
    .D(_007_),
    .Q(net30));
 sky130_fd_sc_hd__dfxtp_1 _124_ (.CLK(clk),
    .D(_008_),
    .Q(net31));
 sky130_fd_sc_hd__dfxtp_1 _125_ (.CLK(clk),
    .D(_009_),
    .Q(net17));
 sky130_fd_sc_hd__dfxtp_1 _126_ (.CLK(clk),
    .D(_010_),
    .Q(net18));
 sky130_fd_sc_hd__dfxtp_1 _127_ (.CLK(clk),
    .D(_011_),
    .Q(net19));
 sky130_fd_sc_hd__dfxtp_1 _128_ (.CLK(clk),
    .D(_012_),
    .Q(net20));
 sky130_fd_sc_hd__dfxtp_1 _129_ (.CLK(clk),
    .D(_013_),
    .Q(net21));
 sky130_fd_sc_hd__clkbuf_1 _130_ (.A(net31),
    .X(net27));
 sky130_fd_sc_hd__clkbuf_1 _131_ (.A(net22),
    .X(net29));
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
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_17_Right_17 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_18_Right_18 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_19_Right_19 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_20_Right_20 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_21_Right_21 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_22_Right_22 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_23_Right_23 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_24_Right_24 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_25_Right_25 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_26_Right_26 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_27_Right_27 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_28_Right_28 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_29_Right_29 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_30_Right_30 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_31_Right_31 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_32_Right_32 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_33_Right_33 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_34_Right_34 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_35_Right_35 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_36_Right_36 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_37_Right_37 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_38_Right_38 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_39_Right_39 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_40_Right_40 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_41_Right_41 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_42_Right_42 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_43_Right_43 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_44_Right_44 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_45_Right_45 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_0_Left_46 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_1_Left_47 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_2_Left_48 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_3_Left_49 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_4_Left_50 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_5_Left_51 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_6_Left_52 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_7_Left_53 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_8_Left_54 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_9_Left_55 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_10_Left_56 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_11_Left_57 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_12_Left_58 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_13_Left_59 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_14_Left_60 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_15_Left_61 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_16_Left_62 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_17_Left_63 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_18_Left_64 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_19_Left_65 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_20_Left_66 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_21_Left_67 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_22_Left_68 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_23_Left_69 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_24_Left_70 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_25_Left_71 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_26_Left_72 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_27_Left_73 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_28_Left_74 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_29_Left_75 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_30_Left_76 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_31_Left_77 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_32_Left_78 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_33_Left_79 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_34_Left_80 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_35_Left_81 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_36_Left_82 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_37_Left_83 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_38_Left_84 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_39_Left_85 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_40_Left_86 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_41_Left_87 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_42_Left_88 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_43_Left_89 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_44_Left_90 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_45_Left_91 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_0_92 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_0_93 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_0_94 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_0_95 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_0_96 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_0_97 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_0_98 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_0_99 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_0_100 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_1_101 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_1_102 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_1_103 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_1_104 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_2_105 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_2_106 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_2_107 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_2_108 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_2_109 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_3_110 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_3_111 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_3_112 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_3_113 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_4_114 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_4_115 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_4_116 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_4_117 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_4_118 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_5_119 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_5_120 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_5_121 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_5_122 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_6_123 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_6_124 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_6_125 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_6_126 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_6_127 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_7_128 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_7_129 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_7_130 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_7_131 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_8_132 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_8_133 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_8_134 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_8_135 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_8_136 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_9_137 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_9_138 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_9_139 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_9_140 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_10_141 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_10_142 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_10_143 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_10_144 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_10_145 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_11_146 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_11_147 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_11_148 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_11_149 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_12_150 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_12_151 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_12_152 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_12_153 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_12_154 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_13_155 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_13_156 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_13_157 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_13_158 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_14_159 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_14_160 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_14_161 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_14_162 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_14_163 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_15_164 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_15_165 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_15_166 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_15_167 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_16_168 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_16_169 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_16_170 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_16_171 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_16_172 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_17_173 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_17_174 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_17_175 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_17_176 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_18_177 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_18_178 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_18_179 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_18_180 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_18_181 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_19_182 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_19_183 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_19_184 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_19_185 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_20_186 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_20_187 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_20_188 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_20_189 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_20_190 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_21_191 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_21_192 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_21_193 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_21_194 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_22_195 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_22_196 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_22_197 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_22_198 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_22_199 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_23_200 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_23_201 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_23_202 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_23_203 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_24_204 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_24_205 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_24_206 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_24_207 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_24_208 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_25_209 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_25_210 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_25_211 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_25_212 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_26_213 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_26_214 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_26_215 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_26_216 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_26_217 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_27_218 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_27_219 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_27_220 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_27_221 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_28_222 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_28_223 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_28_224 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_28_225 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_28_226 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_29_227 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_29_228 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_29_229 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_29_230 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_30_231 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_30_232 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_30_233 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_30_234 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_30_235 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_31_236 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_31_237 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_31_238 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_31_239 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_32_240 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_32_241 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_32_242 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_32_243 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_32_244 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_33_245 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_33_246 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_33_247 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_33_248 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_34_249 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_34_250 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_34_251 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_34_252 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_34_253 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_35_254 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_35_255 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_35_256 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_35_257 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_36_258 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_36_259 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_36_260 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_36_261 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_36_262 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_37_263 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_37_264 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_37_265 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_37_266 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_38_267 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_38_268 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_38_269 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_38_270 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_38_271 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_39_272 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_39_273 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_39_274 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_39_275 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_40_276 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_40_277 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_40_278 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_40_279 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_40_280 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_41_281 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_41_282 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_41_283 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_41_284 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_42_285 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_42_286 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_42_287 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_42_288 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_42_289 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_43_290 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_43_291 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_43_292 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_43_293 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_44_294 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_44_295 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_44_296 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_44_297 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_44_298 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_45_299 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_45_300 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_45_301 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_45_302 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_45_303 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_45_304 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_45_305 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_45_306 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_45_307 ();
 sky130_fd_sc_hd__clkbuf_1 input1 (.A(pc[10]),
    .X(net1));
 sky130_fd_sc_hd__clkbuf_1 input2 (.A(pc[11]),
    .X(net2));
 sky130_fd_sc_hd__clkbuf_1 input3 (.A(pc[12]),
    .X(net3));
 sky130_fd_sc_hd__clkbuf_1 input4 (.A(pc[13]),
    .X(net4));
 sky130_fd_sc_hd__clkbuf_1 input5 (.A(pc[14]),
    .X(net5));
 sky130_fd_sc_hd__clkbuf_1 input6 (.A(pc[15]),
    .X(net6));
 sky130_fd_sc_hd__dlymetal6s2s_1 input7 (.A(pc[1]),
    .X(net7));
 sky130_fd_sc_hd__clkbuf_4 input8 (.A(pc[2]),
    .X(net8));
 sky130_fd_sc_hd__buf_1 input9 (.A(pc[3]),
    .X(net9));
 sky130_fd_sc_hd__clkbuf_2 input10 (.A(pc[4]),
    .X(net10));
 sky130_fd_sc_hd__buf_2 input11 (.A(pc[5]),
    .X(net11));
 sky130_fd_sc_hd__buf_1 input12 (.A(pc[6]),
    .X(net12));
 sky130_fd_sc_hd__clkbuf_1 input13 (.A(pc[7]),
    .X(net13));
 sky130_fd_sc_hd__clkbuf_1 input14 (.A(pc[8]),
    .X(net14));
 sky130_fd_sc_hd__clkbuf_1 input15 (.A(pc[9]),
    .X(net15));
 sky130_fd_sc_hd__buf_2 output16 (.A(net16),
    .X(instruction[0]));
 sky130_fd_sc_hd__buf_2 output17 (.A(net17),
    .X(instruction[10]));
 sky130_fd_sc_hd__buf_2 output18 (.A(net18),
    .X(instruction[11]));
 sky130_fd_sc_hd__buf_2 output19 (.A(net19),
    .X(instruction[12]));
 sky130_fd_sc_hd__buf_2 output20 (.A(net20),
    .X(instruction[13]));
 sky130_fd_sc_hd__buf_2 output21 (.A(net21),
    .X(instruction[14]));
 sky130_fd_sc_hd__buf_2 output22 (.A(net22),
    .X(instruction[15]));
 sky130_fd_sc_hd__buf_2 output23 (.A(net23),
    .X(instruction[1]));
 sky130_fd_sc_hd__buf_2 output24 (.A(net24),
    .X(instruction[2]));
 sky130_fd_sc_hd__buf_2 output25 (.A(net25),
    .X(instruction[3]));
 sky130_fd_sc_hd__buf_2 output26 (.A(net26),
    .X(instruction[4]));
 sky130_fd_sc_hd__buf_2 output27 (.A(net27),
    .X(instruction[5]));
 sky130_fd_sc_hd__buf_2 output28 (.A(net28),
    .X(instruction[6]));
 sky130_fd_sc_hd__buf_2 output29 (.A(net29),
    .X(instruction[7]));
 sky130_fd_sc_hd__buf_2 output30 (.A(net30),
    .X(instruction[8]));
 sky130_fd_sc_hd__buf_2 output31 (.A(net31),
    .X(instruction[9]));
 sky130_fd_sc_hd__buf_1 max_cap32 (.A(_020_),
    .X(net32));
 sky130_fd_sc_hd__buf_2 fanout33 (.A(net9),
    .X(net33));
 sky130_fd_sc_hd__buf_1 fanout34 (.A(net9),
    .X(net34));
 sky130_fd_sc_hd__clkbuf_4 fanout35 (.A(net7),
    .X(net35));
endmodule
