module Data_Memory (clk,
    mem_read,
    mem_write_en,
    mem_access_addr,
    mem_read_data,
    mem_write_data);
 input clk;
 input mem_read;
 input mem_write_en;
 input [15:0] mem_access_addr;
 output [15:0] mem_read_data;
 input [15:0] mem_write_data;

 wire _000_;
 wire _001_;
 wire _002_;
 wire _003_;
 wire _004_;
 wire _005_;
 wire _006_;
 wire _007_;
 wire net16;
 wire net15;
 wire net14;
 wire net13;
 wire _012_;
 wire net12;
 wire _014_;
 wire _015_;
 wire net11;
 wire _017_;
 wire _018_;
 wire net10;
 wire _020_;
 wire net9;
 wire net8;
 wire net7;
 wire _024_;
 wire _025_;
 wire _026_;
 wire net6;
 wire net5;
 wire _029_;
 wire net4;
 wire _031_;
 wire _032_;
 wire _033_;
 wire _034_;
 wire net3;
 wire net2;
 wire _037_;
 wire _038_;
 wire _039_;
 wire net1;
 wire _042_;
 wire _043_;
 wire _044_;
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
 wire _058_;
 wire _059_;
 wire _060_;
 wire _061_;
 wire _062_;
 wire _063_;
 wire _064_;
 wire _065_;
 wire _066_;
 wire _067_;
 wire _068_;
 wire _069_;
 wire _070_;
 wire _071_;
 wire _072_;
 wire _073_;
 wire _074_;
 wire _075_;
 wire _076_;
 wire _077_;
 wire _078_;
 wire _079_;
 wire _080_;
 wire _081_;
 wire _082_;
 wire _083_;
 wire _084_;
 wire _085_;
 wire _086_;
 wire _087_;
 wire _088_;
 wire _089_;
 wire _090_;
 wire _091_;
 wire _092_;
 wire _093_;
 wire _094_;
 wire _095_;
 wire _096_;
 wire _097_;
 wire _098_;
 wire _099_;
 wire _100_;
 wire _101_;
 wire _102_;
 wire _103_;
 wire _104_;
 wire _105_;
 wire _106_;
 wire _107_;
 wire _108_;
 wire _109_;
 wire _110_;
 wire _111_;
 wire _112_;
 wire _113_;
 wire _114_;
 wire _115_;
 wire _116_;
 wire _117_;
 wire _118_;
 wire _119_;
 wire _120_;
 wire _121_;
 wire _122_;
 wire _123_;
 wire _124_;
 wire _125_;
 wire _126_;
 wire _127_;
 wire _128_;
 wire _129_;
 wire _130_;
 wire _131_;
 wire _132_;
 wire _133_;
 wire _134_;
 wire _135_;
 wire _136_;
 wire _137_;
 wire _138_;
 wire _139_;
 wire _140_;
 wire _141_;
 wire _142_;
 wire _143_;
 wire _144_;
 wire _145_;
 wire _146_;
 wire _147_;
 wire _148_;
 wire _149_;
 wire _150_;
 wire _151_;
 wire _152_;
 wire _153_;
 wire _154_;
 wire _155_;
 wire _156_;
 wire _157_;
 wire _158_;
 wire _159_;
 wire _160_;
 wire _161_;
 wire _162_;
 wire _163_;
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
 wire net36;
 wire net37;
 wire \memory[0][0] ;
 wire \memory[0][10] ;
 wire \memory[0][11] ;
 wire \memory[0][12] ;
 wire \memory[0][13] ;
 wire \memory[0][14] ;
 wire \memory[0][15] ;
 wire \memory[0][1] ;
 wire \memory[0][2] ;
 wire \memory[0][3] ;
 wire \memory[0][4] ;
 wire \memory[0][5] ;
 wire \memory[0][6] ;
 wire \memory[0][7] ;
 wire \memory[0][8] ;
 wire \memory[0][9] ;
 wire \memory[1][0] ;
 wire \memory[1][10] ;
 wire \memory[1][11] ;
 wire \memory[1][12] ;
 wire \memory[1][13] ;
 wire \memory[1][14] ;
 wire \memory[1][15] ;
 wire \memory[1][1] ;
 wire \memory[1][2] ;
 wire \memory[1][3] ;
 wire \memory[1][4] ;
 wire \memory[1][5] ;
 wire \memory[1][6] ;
 wire \memory[1][7] ;
 wire \memory[1][8] ;
 wire \memory[1][9] ;
 wire \memory[2][0] ;
 wire \memory[2][10] ;
 wire \memory[2][11] ;
 wire \memory[2][12] ;
 wire \memory[2][13] ;
 wire \memory[2][14] ;
 wire \memory[2][15] ;
 wire \memory[2][1] ;
 wire \memory[2][2] ;
 wire \memory[2][3] ;
 wire \memory[2][4] ;
 wire \memory[2][5] ;
 wire \memory[2][6] ;
 wire \memory[2][7] ;
 wire \memory[2][8] ;
 wire \memory[2][9] ;
 wire \memory[3][0] ;
 wire \memory[3][10] ;
 wire \memory[3][11] ;
 wire \memory[3][12] ;
 wire \memory[3][13] ;
 wire \memory[3][14] ;
 wire \memory[3][15] ;
 wire \memory[3][1] ;
 wire \memory[3][2] ;
 wire \memory[3][3] ;
 wire \memory[3][4] ;
 wire \memory[3][5] ;
 wire \memory[3][6] ;
 wire \memory[3][7] ;
 wire \memory[3][8] ;
 wire \memory[3][9] ;
 wire \memory[4][0] ;
 wire \memory[4][10] ;
 wire \memory[4][11] ;
 wire \memory[4][12] ;
 wire \memory[4][13] ;
 wire \memory[4][14] ;
 wire \memory[4][15] ;
 wire \memory[4][1] ;
 wire \memory[4][2] ;
 wire \memory[4][3] ;
 wire \memory[4][4] ;
 wire \memory[4][5] ;
 wire \memory[4][6] ;
 wire \memory[4][7] ;
 wire \memory[4][8] ;
 wire \memory[4][9] ;
 wire \memory[5][0] ;
 wire \memory[5][10] ;
 wire \memory[5][11] ;
 wire \memory[5][12] ;
 wire \memory[5][13] ;
 wire \memory[5][14] ;
 wire \memory[5][15] ;
 wire \memory[5][1] ;
 wire \memory[5][2] ;
 wire \memory[5][3] ;
 wire \memory[5][4] ;
 wire \memory[5][5] ;
 wire \memory[5][6] ;
 wire \memory[5][7] ;
 wire \memory[5][8] ;
 wire \memory[5][9] ;
 wire \memory[6][0] ;
 wire \memory[6][10] ;
 wire \memory[6][11] ;
 wire \memory[6][12] ;
 wire \memory[6][13] ;
 wire \memory[6][14] ;
 wire \memory[6][15] ;
 wire \memory[6][1] ;
 wire \memory[6][2] ;
 wire \memory[6][3] ;
 wire \memory[6][4] ;
 wire \memory[6][5] ;
 wire \memory[6][6] ;
 wire \memory[6][7] ;
 wire \memory[6][8] ;
 wire \memory[6][9] ;
 wire \memory[7][0] ;
 wire \memory[7][10] ;
 wire \memory[7][11] ;
 wire \memory[7][12] ;
 wire \memory[7][13] ;
 wire \memory[7][14] ;
 wire \memory[7][15] ;
 wire \memory[7][1] ;
 wire \memory[7][2] ;
 wire \memory[7][3] ;
 wire \memory[7][4] ;
 wire \memory[7][5] ;
 wire \memory[7][6] ;
 wire \memory[7][7] ;
 wire \memory[7][8] ;
 wire \memory[7][9] ;
 wire net17;
 wire net18;
 wire net19;
 wire net20;
 wire net21;
 wire net59;
 wire net61;
 wire net51;
 wire net52;
 wire net53;
 wire net54;
 wire net55;
 wire net56;
 wire net57;
 wire net58;
 wire clknet_0_clk;
 wire net60;
 wire net62;
 wire clknet_4_0_0_clk;
 wire clknet_4_1_0_clk;
 wire clknet_4_2_0_clk;
 wire clknet_4_3_0_clk;
 wire clknet_4_4_0_clk;
 wire clknet_4_5_0_clk;
 wire clknet_4_6_0_clk;
 wire clknet_4_7_0_clk;
 wire clknet_4_8_0_clk;
 wire clknet_4_9_0_clk;
 wire clknet_4_10_0_clk;
 wire clknet_4_11_0_clk;
 wire clknet_4_12_0_clk;
 wire clknet_4_13_0_clk;
 wire clknet_4_14_0_clk;
 wire clknet_4_15_0_clk;

 sky130_fd_sc_hd__nand2b_1 _168_ (.A_N(net1),
    .B(net61),
    .Y(_012_));
 sky130_fd_sc_hd__nor3_2 _169_ (.A(net2),
    .B(net3),
    .C(_012_),
    .Y(_000_));
 sky130_fd_sc_hd__nand2_1 _171_ (.A(net1),
    .B(net61),
    .Y(_014_));
 sky130_fd_sc_hd__nor3_2 _172_ (.A(net2),
    .B(net3),
    .C(_014_),
    .Y(_001_));
 sky130_fd_sc_hd__nand2b_1 _173_ (.A_N(net3),
    .B(net2),
    .Y(_015_));
 sky130_fd_sc_hd__nor2_2 _175_ (.A(_012_),
    .B(_015_),
    .Y(_002_));
 sky130_fd_sc_hd__nor2_2 _176_ (.A(_014_),
    .B(_015_),
    .Y(_003_));
 sky130_fd_sc_hd__nand2b_1 _177_ (.A_N(net2),
    .B(net3),
    .Y(_017_));
 sky130_fd_sc_hd__nor2_2 _178_ (.A(_012_),
    .B(_017_),
    .Y(_004_));
 sky130_fd_sc_hd__nor2_2 _179_ (.A(_014_),
    .B(_017_),
    .Y(_005_));
 sky130_fd_sc_hd__nand2_1 _180_ (.A(net2),
    .B(net3),
    .Y(_018_));
 sky130_fd_sc_hd__nor2_2 _182_ (.A(_012_),
    .B(_018_),
    .Y(_006_));
 sky130_fd_sc_hd__nor2_2 _183_ (.A(_014_),
    .B(_018_),
    .Y(_007_));
 sky130_fd_sc_hd__nor2b_1 _184_ (.A(net2),
    .B_N(net3),
    .Y(_020_));
 sky130_fd_sc_hd__mux2_2 _188_ (.A0(\memory[4][0] ),
    .A1(\memory[5][0] ),
    .S(net62),
    .X(_024_));
 sky130_fd_sc_hd__nand2_1 _189_ (.A(net60),
    .B(_024_),
    .Y(_025_));
 sky130_fd_sc_hd__nor2_2 _190_ (.A(net2),
    .B(net3),
    .Y(_026_));
 sky130_fd_sc_hd__mux2_2 _193_ (.A0(\memory[0][0] ),
    .A1(\memory[1][0] ),
    .S(net62),
    .X(_029_));
 sky130_fd_sc_hd__mux2_2 _195_ (.A0(\memory[2][0] ),
    .A1(\memory[3][0] ),
    .S(net62),
    .X(_031_));
 sky130_fd_sc_hd__nor2b_1 _196_ (.A(net3),
    .B_N(net2),
    .Y(_032_));
 sky130_fd_sc_hd__a22oi_1 _197_ (.A1(_026_),
    .A2(_029_),
    .B1(_031_),
    .B2(_032_),
    .Y(_033_));
 sky130_fd_sc_hd__and2_1 _198_ (.A(net2),
    .B(net3),
    .X(_034_));
 sky130_fd_sc_hd__mux2_2 _201_ (.A0(\memory[6][0] ),
    .A1(\memory[7][0] ),
    .S(net62),
    .X(_037_));
 sky130_fd_sc_hd__a21oi_1 _202_ (.A1(_034_),
    .A2(_037_),
    .B1(net61),
    .Y(_038_));
 sky130_fd_sc_hd__inv_1 _203_ (.A(net61),
    .Y(_039_));
 sky130_fd_sc_hd__o21ai_0 _206_ (.A1(net5),
    .A2(_039_),
    .B1(net4),
    .Y(_042_));
 sky130_fd_sc_hd__a31oi_1 _207_ (.A1(_025_),
    .A2(_033_),
    .A3(_038_),
    .B1(_042_),
    .Y(net22));
 sky130_fd_sc_hd__mux2_2 _208_ (.A0(\memory[4][10] ),
    .A1(\memory[5][10] ),
    .S(net1),
    .X(_043_));
 sky130_fd_sc_hd__nand2_1 _209_ (.A(net60),
    .B(_043_),
    .Y(_044_));
 sky130_fd_sc_hd__mux2i_1 _211_ (.A0(\memory[2][10] ),
    .A1(\memory[3][10] ),
    .S(net1),
    .Y(_046_));
 sky130_fd_sc_hd__mux2i_1 _212_ (.A0(\memory[6][10] ),
    .A1(\memory[7][10] ),
    .S(net1),
    .Y(_047_));
 sky130_fd_sc_hd__o22a_1 _213_ (.A1(_015_),
    .A2(_046_),
    .B1(_047_),
    .B2(_018_),
    .X(_048_));
 sky130_fd_sc_hd__mux2_2 _214_ (.A0(\memory[0][10] ),
    .A1(\memory[1][10] ),
    .S(net1),
    .X(_049_));
 sky130_fd_sc_hd__a21oi_1 _215_ (.A1(net59),
    .A2(_049_),
    .B1(net61),
    .Y(_050_));
 sky130_fd_sc_hd__o21ai_0 _216_ (.A1(_039_),
    .A2(net6),
    .B1(net4),
    .Y(_051_));
 sky130_fd_sc_hd__a31oi_1 _217_ (.A1(_044_),
    .A2(_048_),
    .A3(_050_),
    .B1(_051_),
    .Y(net23));
 sky130_fd_sc_hd__mux2_2 _218_ (.A0(\memory[4][11] ),
    .A1(\memory[5][11] ),
    .S(net62),
    .X(_052_));
 sky130_fd_sc_hd__nand2_1 _219_ (.A(net60),
    .B(_052_),
    .Y(_053_));
 sky130_fd_sc_hd__mux2i_1 _220_ (.A0(\memory[2][11] ),
    .A1(\memory[3][11] ),
    .S(net62),
    .Y(_054_));
 sky130_fd_sc_hd__mux2i_1 _221_ (.A0(\memory[6][11] ),
    .A1(\memory[7][11] ),
    .S(net62),
    .Y(_055_));
 sky130_fd_sc_hd__o22a_1 _222_ (.A1(_015_),
    .A2(_054_),
    .B1(_055_),
    .B2(_018_),
    .X(_056_));
 sky130_fd_sc_hd__mux2_2 _223_ (.A0(\memory[0][11] ),
    .A1(\memory[1][11] ),
    .S(net62),
    .X(_057_));
 sky130_fd_sc_hd__a21oi_1 _224_ (.A1(net59),
    .A2(_057_),
    .B1(net61),
    .Y(_058_));
 sky130_fd_sc_hd__o21ai_0 _225_ (.A1(_039_),
    .A2(net7),
    .B1(net4),
    .Y(_059_));
 sky130_fd_sc_hd__a31oi_1 _226_ (.A1(_053_),
    .A2(_056_),
    .A3(_058_),
    .B1(_059_),
    .Y(net24));
 sky130_fd_sc_hd__mux2_2 _227_ (.A0(\memory[4][12] ),
    .A1(\memory[5][12] ),
    .S(net62),
    .X(_060_));
 sky130_fd_sc_hd__nand2_1 _228_ (.A(net60),
    .B(_060_),
    .Y(_061_));
 sky130_fd_sc_hd__mux2_2 _229_ (.A0(\memory[0][12] ),
    .A1(\memory[1][12] ),
    .S(net62),
    .X(_062_));
 sky130_fd_sc_hd__mux2_2 _230_ (.A0(\memory[2][12] ),
    .A1(\memory[3][12] ),
    .S(net62),
    .X(_063_));
 sky130_fd_sc_hd__a22oi_1 _231_ (.A1(_026_),
    .A2(_062_),
    .B1(_063_),
    .B2(_032_),
    .Y(_064_));
 sky130_fd_sc_hd__mux2_2 _232_ (.A0(\memory[6][12] ),
    .A1(\memory[7][12] ),
    .S(net62),
    .X(_065_));
 sky130_fd_sc_hd__a21oi_1 _233_ (.A1(_034_),
    .A2(_065_),
    .B1(net61),
    .Y(_066_));
 sky130_fd_sc_hd__o21ai_0 _234_ (.A1(_039_),
    .A2(net8),
    .B1(net4),
    .Y(_067_));
 sky130_fd_sc_hd__a31oi_1 _235_ (.A1(_061_),
    .A2(_064_),
    .A3(_066_),
    .B1(_067_),
    .Y(net25));
 sky130_fd_sc_hd__mux2_2 _236_ (.A0(\memory[4][13] ),
    .A1(\memory[5][13] ),
    .S(net62),
    .X(_068_));
 sky130_fd_sc_hd__nand2_1 _237_ (.A(net60),
    .B(_068_),
    .Y(_069_));
 sky130_fd_sc_hd__mux2i_1 _238_ (.A0(\memory[2][13] ),
    .A1(\memory[3][13] ),
    .S(net62),
    .Y(_070_));
 sky130_fd_sc_hd__mux2i_1 _239_ (.A0(\memory[6][13] ),
    .A1(\memory[7][13] ),
    .S(net62),
    .Y(_071_));
 sky130_fd_sc_hd__o22a_1 _240_ (.A1(_015_),
    .A2(_070_),
    .B1(_071_),
    .B2(_018_),
    .X(_072_));
 sky130_fd_sc_hd__mux2_2 _241_ (.A0(\memory[0][13] ),
    .A1(\memory[1][13] ),
    .S(net62),
    .X(_073_));
 sky130_fd_sc_hd__a21oi_1 _242_ (.A1(net59),
    .A2(_073_),
    .B1(net61),
    .Y(_074_));
 sky130_fd_sc_hd__o21ai_0 _243_ (.A1(_039_),
    .A2(net9),
    .B1(net4),
    .Y(_075_));
 sky130_fd_sc_hd__a31oi_1 _244_ (.A1(_069_),
    .A2(_072_),
    .A3(_074_),
    .B1(_075_),
    .Y(net26));
 sky130_fd_sc_hd__mux2_2 _245_ (.A0(\memory[4][14] ),
    .A1(\memory[5][14] ),
    .S(net1),
    .X(_076_));
 sky130_fd_sc_hd__nand2_1 _246_ (.A(net60),
    .B(_076_),
    .Y(_077_));
 sky130_fd_sc_hd__mux2i_1 _247_ (.A0(\memory[2][14] ),
    .A1(\memory[3][14] ),
    .S(net62),
    .Y(_078_));
 sky130_fd_sc_hd__mux2i_1 _248_ (.A0(\memory[6][14] ),
    .A1(\memory[7][14] ),
    .S(net62),
    .Y(_079_));
 sky130_fd_sc_hd__o22a_1 _249_ (.A1(_015_),
    .A2(_078_),
    .B1(_079_),
    .B2(_018_),
    .X(_080_));
 sky130_fd_sc_hd__mux2_2 _250_ (.A0(\memory[0][14] ),
    .A1(\memory[1][14] ),
    .S(net1),
    .X(_081_));
 sky130_fd_sc_hd__a21oi_1 _251_ (.A1(net59),
    .A2(_081_),
    .B1(net61),
    .Y(_082_));
 sky130_fd_sc_hd__o21ai_0 _252_ (.A1(_039_),
    .A2(net10),
    .B1(net4),
    .Y(_083_));
 sky130_fd_sc_hd__a31oi_1 _253_ (.A1(_077_),
    .A2(_080_),
    .A3(_082_),
    .B1(_083_),
    .Y(net27));
 sky130_fd_sc_hd__mux2_2 _254_ (.A0(\memory[4][15] ),
    .A1(\memory[5][15] ),
    .S(net62),
    .X(_084_));
 sky130_fd_sc_hd__nand2_1 _255_ (.A(net60),
    .B(_084_),
    .Y(_085_));
 sky130_fd_sc_hd__mux2i_1 _256_ (.A0(\memory[2][15] ),
    .A1(\memory[3][15] ),
    .S(net62),
    .Y(_086_));
 sky130_fd_sc_hd__mux2i_1 _257_ (.A0(\memory[6][15] ),
    .A1(\memory[7][15] ),
    .S(net62),
    .Y(_087_));
 sky130_fd_sc_hd__o22a_1 _258_ (.A1(_015_),
    .A2(_086_),
    .B1(_087_),
    .B2(_018_),
    .X(_088_));
 sky130_fd_sc_hd__mux2_2 _259_ (.A0(\memory[0][15] ),
    .A1(\memory[1][15] ),
    .S(net62),
    .X(_089_));
 sky130_fd_sc_hd__a21oi_1 _260_ (.A1(net59),
    .A2(_089_),
    .B1(net61),
    .Y(_090_));
 sky130_fd_sc_hd__o21ai_0 _261_ (.A1(_039_),
    .A2(net11),
    .B1(net4),
    .Y(_091_));
 sky130_fd_sc_hd__a31oi_1 _262_ (.A1(_085_),
    .A2(_088_),
    .A3(_090_),
    .B1(_091_),
    .Y(net28));
 sky130_fd_sc_hd__mux2_2 _263_ (.A0(\memory[4][1] ),
    .A1(\memory[5][1] ),
    .S(net1),
    .X(_092_));
 sky130_fd_sc_hd__nand2_1 _264_ (.A(_020_),
    .B(_092_),
    .Y(_093_));
 sky130_fd_sc_hd__mux2_2 _265_ (.A0(\memory[0][1] ),
    .A1(\memory[1][1] ),
    .S(net1),
    .X(_094_));
 sky130_fd_sc_hd__mux2_2 _266_ (.A0(\memory[2][1] ),
    .A1(\memory[3][1] ),
    .S(net1),
    .X(_095_));
 sky130_fd_sc_hd__a22oi_1 _267_ (.A1(_026_),
    .A2(_094_),
    .B1(_095_),
    .B2(_032_),
    .Y(_096_));
 sky130_fd_sc_hd__mux2_2 _268_ (.A0(\memory[6][1] ),
    .A1(\memory[7][1] ),
    .S(net1),
    .X(_097_));
 sky130_fd_sc_hd__a21oi_1 _269_ (.A1(_034_),
    .A2(_097_),
    .B1(net61),
    .Y(_098_));
 sky130_fd_sc_hd__o21ai_0 _270_ (.A1(_039_),
    .A2(net12),
    .B1(net4),
    .Y(_099_));
 sky130_fd_sc_hd__a31oi_1 _271_ (.A1(_093_),
    .A2(_096_),
    .A3(_098_),
    .B1(_099_),
    .Y(net29));
 sky130_fd_sc_hd__mux2_2 _272_ (.A0(\memory[4][2] ),
    .A1(\memory[5][2] ),
    .S(net62),
    .X(_100_));
 sky130_fd_sc_hd__nand2_1 _273_ (.A(net60),
    .B(_100_),
    .Y(_101_));
 sky130_fd_sc_hd__mux2i_1 _274_ (.A0(\memory[2][2] ),
    .A1(\memory[3][2] ),
    .S(net62),
    .Y(_102_));
 sky130_fd_sc_hd__mux2i_1 _275_ (.A0(\memory[6][2] ),
    .A1(\memory[7][2] ),
    .S(net62),
    .Y(_103_));
 sky130_fd_sc_hd__o22a_1 _276_ (.A1(_015_),
    .A2(_102_),
    .B1(_103_),
    .B2(_018_),
    .X(_104_));
 sky130_fd_sc_hd__mux2_2 _277_ (.A0(\memory[0][2] ),
    .A1(\memory[1][2] ),
    .S(net62),
    .X(_105_));
 sky130_fd_sc_hd__a21oi_1 _278_ (.A1(net59),
    .A2(_105_),
    .B1(net61),
    .Y(_106_));
 sky130_fd_sc_hd__o21ai_0 _279_ (.A1(_039_),
    .A2(net13),
    .B1(net4),
    .Y(_107_));
 sky130_fd_sc_hd__a31oi_1 _280_ (.A1(_101_),
    .A2(_104_),
    .A3(_106_),
    .B1(_107_),
    .Y(net30));
 sky130_fd_sc_hd__mux2_2 _281_ (.A0(\memory[4][3] ),
    .A1(\memory[5][3] ),
    .S(net1),
    .X(_108_));
 sky130_fd_sc_hd__nand2_1 _282_ (.A(_020_),
    .B(_108_),
    .Y(_109_));
 sky130_fd_sc_hd__mux2i_1 _283_ (.A0(\memory[2][3] ),
    .A1(\memory[3][3] ),
    .S(net1),
    .Y(_110_));
 sky130_fd_sc_hd__mux2i_1 _284_ (.A0(\memory[6][3] ),
    .A1(\memory[7][3] ),
    .S(net1),
    .Y(_111_));
 sky130_fd_sc_hd__o22a_1 _285_ (.A1(_015_),
    .A2(_110_),
    .B1(_111_),
    .B2(_018_),
    .X(_112_));
 sky130_fd_sc_hd__mux2_2 _286_ (.A0(\memory[0][3] ),
    .A1(\memory[1][3] ),
    .S(net1),
    .X(_113_));
 sky130_fd_sc_hd__a21oi_1 _287_ (.A1(net59),
    .A2(_113_),
    .B1(net61),
    .Y(_114_));
 sky130_fd_sc_hd__o21ai_0 _288_ (.A1(_039_),
    .A2(net14),
    .B1(net4),
    .Y(_115_));
 sky130_fd_sc_hd__a31oi_1 _289_ (.A1(_109_),
    .A2(_112_),
    .A3(_114_),
    .B1(_115_),
    .Y(net31));
 sky130_fd_sc_hd__mux2_2 _290_ (.A0(\memory[4][4] ),
    .A1(\memory[5][4] ),
    .S(net1),
    .X(_116_));
 sky130_fd_sc_hd__nand2_1 _291_ (.A(_020_),
    .B(_116_),
    .Y(_117_));
 sky130_fd_sc_hd__mux2_2 _292_ (.A0(\memory[0][4] ),
    .A1(\memory[1][4] ),
    .S(net1),
    .X(_118_));
 sky130_fd_sc_hd__mux2_2 _293_ (.A0(\memory[2][4] ),
    .A1(\memory[3][4] ),
    .S(net1),
    .X(_119_));
 sky130_fd_sc_hd__a22oi_1 _294_ (.A1(_026_),
    .A2(_118_),
    .B1(_119_),
    .B2(_032_),
    .Y(_120_));
 sky130_fd_sc_hd__mux2_2 _295_ (.A0(\memory[6][4] ),
    .A1(\memory[7][4] ),
    .S(net1),
    .X(_121_));
 sky130_fd_sc_hd__a21oi_1 _296_ (.A1(_034_),
    .A2(_121_),
    .B1(net61),
    .Y(_122_));
 sky130_fd_sc_hd__o21ai_0 _297_ (.A1(_039_),
    .A2(net15),
    .B1(net4),
    .Y(_123_));
 sky130_fd_sc_hd__a31oi_1 _298_ (.A1(_117_),
    .A2(_120_),
    .A3(_122_),
    .B1(_123_),
    .Y(net32));
 sky130_fd_sc_hd__mux2_2 _299_ (.A0(\memory[4][5] ),
    .A1(\memory[5][5] ),
    .S(net62),
    .X(_124_));
 sky130_fd_sc_hd__nand2_1 _300_ (.A(_020_),
    .B(_124_),
    .Y(_125_));
 sky130_fd_sc_hd__mux2_2 _301_ (.A0(\memory[0][5] ),
    .A1(\memory[1][5] ),
    .S(net62),
    .X(_126_));
 sky130_fd_sc_hd__mux2_2 _302_ (.A0(\memory[2][5] ),
    .A1(\memory[3][5] ),
    .S(net62),
    .X(_127_));
 sky130_fd_sc_hd__a22oi_1 _303_ (.A1(_026_),
    .A2(_126_),
    .B1(_127_),
    .B2(_032_),
    .Y(_128_));
 sky130_fd_sc_hd__mux2_2 _304_ (.A0(\memory[6][5] ),
    .A1(\memory[7][5] ),
    .S(net62),
    .X(_129_));
 sky130_fd_sc_hd__a21oi_1 _305_ (.A1(_034_),
    .A2(_129_),
    .B1(net61),
    .Y(_130_));
 sky130_fd_sc_hd__o21ai_0 _306_ (.A1(_039_),
    .A2(net16),
    .B1(net4),
    .Y(_131_));
 sky130_fd_sc_hd__a31oi_1 _307_ (.A1(_125_),
    .A2(_128_),
    .A3(_130_),
    .B1(_131_),
    .Y(net33));
 sky130_fd_sc_hd__mux2_2 _308_ (.A0(\memory[4][6] ),
    .A1(\memory[5][6] ),
    .S(net62),
    .X(_132_));
 sky130_fd_sc_hd__nand2_1 _309_ (.A(net60),
    .B(_132_),
    .Y(_133_));
 sky130_fd_sc_hd__mux2i_1 _310_ (.A0(\memory[2][6] ),
    .A1(\memory[3][6] ),
    .S(net62),
    .Y(_134_));
 sky130_fd_sc_hd__mux2i_1 _311_ (.A0(\memory[6][6] ),
    .A1(\memory[7][6] ),
    .S(net62),
    .Y(_135_));
 sky130_fd_sc_hd__o22a_1 _312_ (.A1(_015_),
    .A2(_134_),
    .B1(_135_),
    .B2(_018_),
    .X(_136_));
 sky130_fd_sc_hd__mux2_2 _313_ (.A0(\memory[0][6] ),
    .A1(\memory[1][6] ),
    .S(net62),
    .X(_137_));
 sky130_fd_sc_hd__a21oi_1 _314_ (.A1(net59),
    .A2(_137_),
    .B1(net61),
    .Y(_138_));
 sky130_fd_sc_hd__o21ai_0 _315_ (.A1(_039_),
    .A2(net17),
    .B1(net4),
    .Y(_139_));
 sky130_fd_sc_hd__a31oi_1 _316_ (.A1(_133_),
    .A2(_136_),
    .A3(_138_),
    .B1(_139_),
    .Y(net34));
 sky130_fd_sc_hd__mux2_2 _317_ (.A0(\memory[4][7] ),
    .A1(\memory[5][7] ),
    .S(net1),
    .X(_140_));
 sky130_fd_sc_hd__nand2_1 _318_ (.A(_020_),
    .B(_140_),
    .Y(_141_));
 sky130_fd_sc_hd__mux2_2 _319_ (.A0(\memory[0][7] ),
    .A1(\memory[1][7] ),
    .S(net1),
    .X(_142_));
 sky130_fd_sc_hd__mux2_2 _320_ (.A0(\memory[2][7] ),
    .A1(\memory[3][7] ),
    .S(net1),
    .X(_143_));
 sky130_fd_sc_hd__a22oi_1 _321_ (.A1(_026_),
    .A2(_142_),
    .B1(_143_),
    .B2(_032_),
    .Y(_144_));
 sky130_fd_sc_hd__mux2_2 _322_ (.A0(\memory[6][7] ),
    .A1(\memory[7][7] ),
    .S(net1),
    .X(_145_));
 sky130_fd_sc_hd__a21oi_1 _323_ (.A1(_034_),
    .A2(_145_),
    .B1(net61),
    .Y(_146_));
 sky130_fd_sc_hd__o21ai_0 _324_ (.A1(_039_),
    .A2(net18),
    .B1(net4),
    .Y(_147_));
 sky130_fd_sc_hd__a31oi_1 _325_ (.A1(_141_),
    .A2(_144_),
    .A3(_146_),
    .B1(_147_),
    .Y(net35));
 sky130_fd_sc_hd__mux2_2 _326_ (.A0(\memory[4][8] ),
    .A1(\memory[5][8] ),
    .S(net62),
    .X(_148_));
 sky130_fd_sc_hd__nand2_1 _327_ (.A(net60),
    .B(_148_),
    .Y(_149_));
 sky130_fd_sc_hd__mux2i_1 _328_ (.A0(\memory[2][8] ),
    .A1(\memory[3][8] ),
    .S(net62),
    .Y(_150_));
 sky130_fd_sc_hd__mux2i_1 _329_ (.A0(\memory[6][8] ),
    .A1(\memory[7][8] ),
    .S(net62),
    .Y(_151_));
 sky130_fd_sc_hd__o22a_1 _330_ (.A1(_015_),
    .A2(_150_),
    .B1(_151_),
    .B2(_018_),
    .X(_152_));
 sky130_fd_sc_hd__mux2_2 _331_ (.A0(\memory[0][8] ),
    .A1(\memory[1][8] ),
    .S(net62),
    .X(_153_));
 sky130_fd_sc_hd__a21oi_1 _332_ (.A1(net59),
    .A2(_153_),
    .B1(net61),
    .Y(_154_));
 sky130_fd_sc_hd__o21ai_0 _333_ (.A1(_039_),
    .A2(net19),
    .B1(net4),
    .Y(_155_));
 sky130_fd_sc_hd__a31oi_1 _334_ (.A1(_149_),
    .A2(_152_),
    .A3(_154_),
    .B1(_155_),
    .Y(net36));
 sky130_fd_sc_hd__mux2_2 _335_ (.A0(\memory[4][9] ),
    .A1(\memory[5][9] ),
    .S(net1),
    .X(_156_));
 sky130_fd_sc_hd__nand2_1 _336_ (.A(_020_),
    .B(_156_),
    .Y(_157_));
 sky130_fd_sc_hd__mux2_2 _337_ (.A0(\memory[0][9] ),
    .A1(\memory[1][9] ),
    .S(net62),
    .X(_158_));
 sky130_fd_sc_hd__mux2_2 _338_ (.A0(\memory[2][9] ),
    .A1(\memory[3][9] ),
    .S(net62),
    .X(_159_));
 sky130_fd_sc_hd__a22oi_1 _339_ (.A1(_026_),
    .A2(_158_),
    .B1(_159_),
    .B2(_032_),
    .Y(_160_));
 sky130_fd_sc_hd__mux2_2 _340_ (.A0(\memory[6][9] ),
    .A1(\memory[7][9] ),
    .S(net1),
    .X(_161_));
 sky130_fd_sc_hd__a21oi_1 _341_ (.A1(_034_),
    .A2(_161_),
    .B1(net61),
    .Y(_162_));
 sky130_fd_sc_hd__o21ai_0 _342_ (.A1(_039_),
    .A2(net20),
    .B1(net4),
    .Y(_163_));
 sky130_fd_sc_hd__a31oi_1 _343_ (.A1(_157_),
    .A2(_160_),
    .A3(_162_),
    .B1(_163_),
    .Y(net37));
 sky130_fd_sc_hd__edfxtp_1 \memory[0][0]$_DFFE_PP_  (.D(net5),
    .DE(net58),
    .Q(\memory[0][0] ),
    .CLK(clknet_4_8_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[0][10]$_DFFE_PP_  (.D(net6),
    .DE(net58),
    .Q(\memory[0][10] ),
    .CLK(clknet_4_7_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[0][11]$_DFFE_PP_  (.D(net7),
    .DE(net58),
    .Q(\memory[0][11] ),
    .CLK(clknet_4_4_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[0][12]$_DFFE_PP_  (.D(net8),
    .DE(_000_),
    .Q(\memory[0][12] ),
    .CLK(clknet_4_9_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[0][13]$_DFFE_PP_  (.D(net9),
    .DE(net58),
    .Q(\memory[0][13] ),
    .CLK(clknet_4_0_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[0][14]$_DFFE_PP_  (.D(net10),
    .DE(net58),
    .Q(\memory[0][14] ),
    .CLK(clknet_4_5_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[0][15]$_DFFE_PP_  (.D(net11),
    .DE(net58),
    .Q(\memory[0][15] ),
    .CLK(clknet_4_8_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[0][1]$_DFFE_PP_  (.D(net12),
    .DE(_000_),
    .Q(\memory[0][1] ),
    .CLK(clknet_4_15_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[0][2]$_DFFE_PP_  (.D(net13),
    .DE(net58),
    .Q(\memory[0][2] ),
    .CLK(clknet_4_2_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[0][3]$_DFFE_PP_  (.D(net14),
    .DE(net58),
    .Q(\memory[0][3] ),
    .CLK(clknet_4_7_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[0][4]$_DFFE_PP_  (.D(net15),
    .DE(_000_),
    .Q(\memory[0][4] ),
    .CLK(clknet_4_14_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[0][5]$_DFFE_PP_  (.D(net16),
    .DE(_000_),
    .Q(\memory[0][5] ),
    .CLK(clknet_4_11_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[0][6]$_DFFE_PP_  (.D(net17),
    .DE(net58),
    .Q(\memory[0][6] ),
    .CLK(clknet_4_1_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[0][7]$_DFFE_PP_  (.D(net18),
    .DE(_000_),
    .Q(\memory[0][7] ),
    .CLK(clknet_4_13_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[0][8]$_DFFE_PP_  (.D(net19),
    .DE(net58),
    .Q(\memory[0][8] ),
    .CLK(clknet_4_1_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[0][9]$_DFFE_PP_  (.D(net20),
    .DE(_000_),
    .Q(\memory[0][9] ),
    .CLK(clknet_4_14_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[1][0]$_DFFE_PP_  (.D(net5),
    .DE(net57),
    .Q(\memory[1][0] ),
    .CLK(clknet_4_8_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[1][10]$_DFFE_PP_  (.D(net6),
    .DE(net57),
    .Q(\memory[1][10] ),
    .CLK(clknet_4_7_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[1][11]$_DFFE_PP_  (.D(net7),
    .DE(net57),
    .Q(\memory[1][11] ),
    .CLK(clknet_4_1_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[1][12]$_DFFE_PP_  (.D(net8),
    .DE(net57),
    .Q(\memory[1][12] ),
    .CLK(clknet_4_9_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[1][13]$_DFFE_PP_  (.D(net9),
    .DE(net57),
    .Q(\memory[1][13] ),
    .CLK(clknet_4_0_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[1][14]$_DFFE_PP_  (.D(net10),
    .DE(net57),
    .Q(\memory[1][14] ),
    .CLK(clknet_4_5_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[1][15]$_DFFE_PP_  (.D(net11),
    .DE(net57),
    .Q(\memory[1][15] ),
    .CLK(clknet_4_8_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[1][1]$_DFFE_PP_  (.D(net12),
    .DE(net57),
    .Q(\memory[1][1] ),
    .CLK(clknet_4_15_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[1][2]$_DFFE_PP_  (.D(net13),
    .DE(net57),
    .Q(\memory[1][2] ),
    .CLK(clknet_4_2_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[1][3]$_DFFE_PP_  (.D(net14),
    .DE(net57),
    .Q(\memory[1][3] ),
    .CLK(clknet_4_7_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[1][4]$_DFFE_PP_  (.D(net15),
    .DE(net57),
    .Q(\memory[1][4] ),
    .CLK(clknet_4_14_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[1][5]$_DFFE_PP_  (.D(net16),
    .DE(net57),
    .Q(\memory[1][5] ),
    .CLK(clknet_4_11_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[1][6]$_DFFE_PP_  (.D(net17),
    .DE(net57),
    .Q(\memory[1][6] ),
    .CLK(clknet_4_3_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[1][7]$_DFFE_PP_  (.D(net18),
    .DE(net57),
    .Q(\memory[1][7] ),
    .CLK(clknet_4_13_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[1][8]$_DFFE_PP_  (.D(net19),
    .DE(net57),
    .Q(\memory[1][8] ),
    .CLK(clknet_4_1_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[1][9]$_DFFE_PP_  (.D(net20),
    .DE(net57),
    .Q(\memory[1][9] ),
    .CLK(clknet_4_14_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[2][0]$_DFFE_PP_  (.D(net5),
    .DE(net56),
    .Q(\memory[2][0] ),
    .CLK(clknet_4_8_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[2][10]$_DFFE_PP_  (.D(net6),
    .DE(net56),
    .Q(\memory[2][10] ),
    .CLK(clknet_4_6_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[2][11]$_DFFE_PP_  (.D(net7),
    .DE(net56),
    .Q(\memory[2][11] ),
    .CLK(clknet_4_4_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[2][12]$_DFFE_PP_  (.D(net8),
    .DE(net56),
    .Q(\memory[2][12] ),
    .CLK(clknet_4_9_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[2][13]$_DFFE_PP_  (.D(net9),
    .DE(net56),
    .Q(\memory[2][13] ),
    .CLK(clknet_4_0_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[2][14]$_DFFE_PP_  (.D(net10),
    .DE(net56),
    .Q(\memory[2][14] ),
    .CLK(clknet_4_5_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[2][15]$_DFFE_PP_  (.D(net11),
    .DE(net56),
    .Q(\memory[2][15] ),
    .CLK(clknet_4_2_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[2][1]$_DFFE_PP_  (.D(net12),
    .DE(_002_),
    .Q(\memory[2][1] ),
    .CLK(clknet_4_15_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[2][2]$_DFFE_PP_  (.D(net13),
    .DE(net56),
    .Q(\memory[2][2] ),
    .CLK(clknet_4_3_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[2][3]$_DFFE_PP_  (.D(net14),
    .DE(net56),
    .Q(\memory[2][3] ),
    .CLK(clknet_4_6_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[2][4]$_DFFE_PP_  (.D(net15),
    .DE(_002_),
    .Q(\memory[2][4] ),
    .CLK(clknet_4_13_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[2][5]$_DFFE_PP_  (.D(net16),
    .DE(net56),
    .Q(\memory[2][5] ),
    .CLK(clknet_4_9_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[2][6]$_DFFE_PP_  (.D(net17),
    .DE(net56),
    .Q(\memory[2][6] ),
    .CLK(clknet_4_3_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[2][7]$_DFFE_PP_  (.D(net18),
    .DE(_002_),
    .Q(\memory[2][7] ),
    .CLK(clknet_4_13_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[2][8]$_DFFE_PP_  (.D(net19),
    .DE(net56),
    .Q(\memory[2][8] ),
    .CLK(clknet_4_1_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[2][9]$_DFFE_PP_  (.D(net20),
    .DE(net56),
    .Q(\memory[2][9] ),
    .CLK(clknet_4_12_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[3][0]$_DFFE_PP_  (.D(net5),
    .DE(net55),
    .Q(\memory[3][0] ),
    .CLK(clknet_4_8_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[3][10]$_DFFE_PP_  (.D(net6),
    .DE(net55),
    .Q(\memory[3][10] ),
    .CLK(clknet_4_6_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[3][11]$_DFFE_PP_  (.D(net7),
    .DE(net55),
    .Q(\memory[3][11] ),
    .CLK(clknet_4_4_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[3][12]$_DFFE_PP_  (.D(net8),
    .DE(net55),
    .Q(\memory[3][12] ),
    .CLK(clknet_4_9_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[3][13]$_DFFE_PP_  (.D(net9),
    .DE(net55),
    .Q(\memory[3][13] ),
    .CLK(clknet_4_0_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[3][14]$_DFFE_PP_  (.D(net10),
    .DE(net55),
    .Q(\memory[3][14] ),
    .CLK(clknet_4_5_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[3][15]$_DFFE_PP_  (.D(net11),
    .DE(net55),
    .Q(\memory[3][15] ),
    .CLK(clknet_4_8_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[3][1]$_DFFE_PP_  (.D(net12),
    .DE(_003_),
    .Q(\memory[3][1] ),
    .CLK(clknet_4_15_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[3][2]$_DFFE_PP_  (.D(net13),
    .DE(net55),
    .Q(\memory[3][2] ),
    .CLK(clknet_4_3_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[3][3]$_DFFE_PP_  (.D(net14),
    .DE(net55),
    .Q(\memory[3][3] ),
    .CLK(clknet_4_6_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[3][4]$_DFFE_PP_  (.D(net15),
    .DE(_003_),
    .Q(\memory[3][4] ),
    .CLK(clknet_4_12_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[3][5]$_DFFE_PP_  (.D(net16),
    .DE(net55),
    .Q(\memory[3][5] ),
    .CLK(clknet_4_11_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[3][6]$_DFFE_PP_  (.D(net17),
    .DE(net55),
    .Q(\memory[3][6] ),
    .CLK(clknet_4_3_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[3][7]$_DFFE_PP_  (.D(net18),
    .DE(_003_),
    .Q(\memory[3][7] ),
    .CLK(clknet_4_13_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[3][8]$_DFFE_PP_  (.D(net19),
    .DE(net55),
    .Q(\memory[3][8] ),
    .CLK(clknet_4_0_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[3][9]$_DFFE_PP_  (.D(net20),
    .DE(net55),
    .Q(\memory[3][9] ),
    .CLK(clknet_4_12_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[4][0]$_DFFE_PP_  (.D(net5),
    .DE(_004_),
    .Q(\memory[4][0] ),
    .CLK(clknet_4_8_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[4][10]$_DFFE_PP_  (.D(net6),
    .DE(net54),
    .Q(\memory[4][10] ),
    .CLK(clknet_4_5_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[4][11]$_DFFE_PP_  (.D(net7),
    .DE(net54),
    .Q(\memory[4][11] ),
    .CLK(clknet_4_1_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[4][12]$_DFFE_PP_  (.D(net8),
    .DE(_004_),
    .Q(\memory[4][12] ),
    .CLK(clknet_4_10_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[4][13]$_DFFE_PP_  (.D(net9),
    .DE(net54),
    .Q(\memory[4][13] ),
    .CLK(clknet_4_0_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[4][14]$_DFFE_PP_  (.D(net10),
    .DE(net54),
    .Q(\memory[4][14] ),
    .CLK(clknet_4_5_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[4][15]$_DFFE_PP_  (.D(net11),
    .DE(net54),
    .Q(\memory[4][15] ),
    .CLK(clknet_4_2_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[4][1]$_DFFE_PP_  (.D(net12),
    .DE(_004_),
    .Q(\memory[4][1] ),
    .CLK(clknet_4_15_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[4][2]$_DFFE_PP_  (.D(net13),
    .DE(net54),
    .Q(\memory[4][2] ),
    .CLK(clknet_4_2_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[4][3]$_DFFE_PP_  (.D(net14),
    .DE(_004_),
    .Q(\memory[4][3] ),
    .CLK(clknet_4_7_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[4][4]$_DFFE_PP_  (.D(net15),
    .DE(_004_),
    .Q(\memory[4][4] ),
    .CLK(clknet_4_14_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[4][5]$_DFFE_PP_  (.D(net16),
    .DE(_004_),
    .Q(\memory[4][5] ),
    .CLK(clknet_4_11_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[4][6]$_DFFE_PP_  (.D(net17),
    .DE(net54),
    .Q(\memory[4][6] ),
    .CLK(clknet_4_4_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[4][7]$_DFFE_PP_  (.D(net18),
    .DE(_004_),
    .Q(\memory[4][7] ),
    .CLK(clknet_4_13_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[4][8]$_DFFE_PP_  (.D(net19),
    .DE(net54),
    .Q(\memory[4][8] ),
    .CLK(clknet_4_1_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[4][9]$_DFFE_PP_  (.D(net20),
    .DE(_004_),
    .Q(\memory[4][9] ),
    .CLK(clknet_4_11_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[5][0]$_DFFE_PP_  (.D(net5),
    .DE(_005_),
    .Q(\memory[5][0] ),
    .CLK(clknet_4_10_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[5][10]$_DFFE_PP_  (.D(net6),
    .DE(net53),
    .Q(\memory[5][10] ),
    .CLK(clknet_4_5_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[5][11]$_DFFE_PP_  (.D(net7),
    .DE(net53),
    .Q(\memory[5][11] ),
    .CLK(clknet_4_1_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[5][12]$_DFFE_PP_  (.D(net8),
    .DE(_005_),
    .Q(\memory[5][12] ),
    .CLK(clknet_4_10_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[5][13]$_DFFE_PP_  (.D(net9),
    .DE(net53),
    .Q(\memory[5][13] ),
    .CLK(clknet_4_0_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[5][14]$_DFFE_PP_  (.D(net10),
    .DE(net53),
    .Q(\memory[5][14] ),
    .CLK(clknet_4_5_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[5][15]$_DFFE_PP_  (.D(net11),
    .DE(net53),
    .Q(\memory[5][15] ),
    .CLK(clknet_4_2_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[5][1]$_DFFE_PP_  (.D(net12),
    .DE(_005_),
    .Q(\memory[5][1] ),
    .CLK(clknet_4_15_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[5][2]$_DFFE_PP_  (.D(net13),
    .DE(net53),
    .Q(\memory[5][2] ),
    .CLK(clknet_4_2_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[5][3]$_DFFE_PP_  (.D(net14),
    .DE(_005_),
    .Q(\memory[5][3] ),
    .CLK(clknet_4_7_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[5][4]$_DFFE_PP_  (.D(net15),
    .DE(_005_),
    .Q(\memory[5][4] ),
    .CLK(clknet_4_14_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[5][5]$_DFFE_PP_  (.D(net16),
    .DE(_005_),
    .Q(\memory[5][5] ),
    .CLK(clknet_4_11_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[5][6]$_DFFE_PP_  (.D(net17),
    .DE(net53),
    .Q(\memory[5][6] ),
    .CLK(clknet_4_4_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[5][7]$_DFFE_PP_  (.D(net18),
    .DE(_005_),
    .Q(\memory[5][7] ),
    .CLK(clknet_4_13_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[5][8]$_DFFE_PP_  (.D(net19),
    .DE(net53),
    .Q(\memory[5][8] ),
    .CLK(clknet_4_1_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[5][9]$_DFFE_PP_  (.D(net20),
    .DE(_005_),
    .Q(\memory[5][9] ),
    .CLK(clknet_4_11_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[6][0]$_DFFE_PP_  (.D(net5),
    .DE(net52),
    .Q(\memory[6][0] ),
    .CLK(clknet_4_10_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[6][10]$_DFFE_PP_  (.D(net6),
    .DE(net52),
    .Q(\memory[6][10] ),
    .CLK(clknet_4_7_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[6][11]$_DFFE_PP_  (.D(net7),
    .DE(net52),
    .Q(\memory[6][11] ),
    .CLK(clknet_4_4_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[6][12]$_DFFE_PP_  (.D(net8),
    .DE(net52),
    .Q(\memory[6][12] ),
    .CLK(clknet_4_10_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[6][13]$_DFFE_PP_  (.D(net9),
    .DE(net52),
    .Q(\memory[6][13] ),
    .CLK(clknet_4_0_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[6][14]$_DFFE_PP_  (.D(net10),
    .DE(net52),
    .Q(\memory[6][14] ),
    .CLK(clknet_4_5_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[6][15]$_DFFE_PP_  (.D(net11),
    .DE(net52),
    .Q(\memory[6][15] ),
    .CLK(clknet_4_2_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[6][1]$_DFFE_PP_  (.D(net12),
    .DE(net52),
    .Q(\memory[6][1] ),
    .CLK(clknet_4_15_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[6][2]$_DFFE_PP_  (.D(net13),
    .DE(net52),
    .Q(\memory[6][2] ),
    .CLK(clknet_4_2_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[6][3]$_DFFE_PP_  (.D(net14),
    .DE(net52),
    .Q(\memory[6][3] ),
    .CLK(clknet_4_6_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[6][4]$_DFFE_PP_  (.D(net15),
    .DE(net52),
    .Q(\memory[6][4] ),
    .CLK(clknet_4_15_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[6][5]$_DFFE_PP_  (.D(net16),
    .DE(net52),
    .Q(\memory[6][5] ),
    .CLK(clknet_4_10_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[6][6]$_DFFE_PP_  (.D(net17),
    .DE(net52),
    .Q(\memory[6][6] ),
    .CLK(clknet_4_6_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[6][7]$_DFFE_PP_  (.D(net18),
    .DE(net52),
    .Q(\memory[6][7] ),
    .CLK(clknet_4_12_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[6][8]$_DFFE_PP_  (.D(net19),
    .DE(net52),
    .Q(\memory[6][8] ),
    .CLK(clknet_4_0_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[6][9]$_DFFE_PP_  (.D(net20),
    .DE(net52),
    .Q(\memory[6][9] ),
    .CLK(clknet_4_11_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[7][0]$_DFFE_PP_  (.D(net5),
    .DE(net51),
    .Q(\memory[7][0] ),
    .CLK(clknet_4_10_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[7][10]$_DFFE_PP_  (.D(net6),
    .DE(net51),
    .Q(\memory[7][10] ),
    .CLK(clknet_4_7_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[7][11]$_DFFE_PP_  (.D(net7),
    .DE(net51),
    .Q(\memory[7][11] ),
    .CLK(clknet_4_4_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[7][12]$_DFFE_PP_  (.D(net8),
    .DE(net51),
    .Q(\memory[7][12] ),
    .CLK(clknet_4_10_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[7][13]$_DFFE_PP_  (.D(net9),
    .DE(net51),
    .Q(\memory[7][13] ),
    .CLK(clknet_4_0_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[7][14]$_DFFE_PP_  (.D(net10),
    .DE(net51),
    .Q(\memory[7][14] ),
    .CLK(clknet_4_5_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[7][15]$_DFFE_PP_  (.D(net11),
    .DE(net51),
    .Q(\memory[7][15] ),
    .CLK(clknet_4_2_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[7][1]$_DFFE_PP_  (.D(net12),
    .DE(net51),
    .Q(\memory[7][1] ),
    .CLK(clknet_4_15_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[7][2]$_DFFE_PP_  (.D(net13),
    .DE(net51),
    .Q(\memory[7][2] ),
    .CLK(clknet_4_2_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[7][3]$_DFFE_PP_  (.D(net14),
    .DE(net51),
    .Q(\memory[7][3] ),
    .CLK(clknet_4_6_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[7][4]$_DFFE_PP_  (.D(net15),
    .DE(net51),
    .Q(\memory[7][4] ),
    .CLK(clknet_4_14_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[7][5]$_DFFE_PP_  (.D(net16),
    .DE(net51),
    .Q(\memory[7][5] ),
    .CLK(clknet_4_10_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[7][6]$_DFFE_PP_  (.D(net17),
    .DE(net51),
    .Q(\memory[7][6] ),
    .CLK(clknet_4_3_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[7][7]$_DFFE_PP_  (.D(net18),
    .DE(net51),
    .Q(\memory[7][7] ),
    .CLK(clknet_4_12_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[7][8]$_DFFE_PP_  (.D(net19),
    .DE(net51),
    .Q(\memory[7][8] ),
    .CLK(clknet_4_0_0_clk));
 sky130_fd_sc_hd__edfxtp_1 \memory[7][9]$_DFFE_PP_  (.D(net20),
    .DE(net51),
    .Q(\memory[7][9] ),
    .CLK(clknet_4_11_0_clk));
 sky130_fd_sc_hd__buf_2 input1 (.A(mem_access_addr[1]),
    .X(net1));
 sky130_fd_sc_hd__clkdlybuf4s50_1 input2 (.A(mem_access_addr[2]),
    .X(net2));
 sky130_fd_sc_hd__clkdlybuf4s50_1 input3 (.A(mem_access_addr[3]),
    .X(net3));
 sky130_fd_sc_hd__clkdlybuf4s50_1 input4 (.A(mem_read),
    .X(net4));
 sky130_fd_sc_hd__clkdlybuf4s50_1 input5 (.A(mem_write_data[0]),
    .X(net5));
 sky130_fd_sc_hd__clkdlybuf4s50_1 input6 (.A(mem_write_data[10]),
    .X(net6));
 sky130_fd_sc_hd__clkdlybuf4s50_1 input7 (.A(mem_write_data[11]),
    .X(net7));
 sky130_fd_sc_hd__clkdlybuf4s50_1 input8 (.A(mem_write_data[12]),
    .X(net8));
 sky130_fd_sc_hd__clkdlybuf4s50_1 input9 (.A(mem_write_data[13]),
    .X(net9));
 sky130_fd_sc_hd__clkdlybuf4s50_1 input10 (.A(mem_write_data[14]),
    .X(net10));
 sky130_fd_sc_hd__clkdlybuf4s50_1 input11 (.A(mem_write_data[15]),
    .X(net11));
 sky130_fd_sc_hd__clkdlybuf4s50_1 input12 (.A(mem_write_data[1]),
    .X(net12));
 sky130_fd_sc_hd__clkdlybuf4s50_1 input13 (.A(mem_write_data[2]),
    .X(net13));
 sky130_fd_sc_hd__clkdlybuf4s50_1 input14 (.A(mem_write_data[3]),
    .X(net14));
 sky130_fd_sc_hd__clkdlybuf4s50_1 input15 (.A(mem_write_data[4]),
    .X(net15));
 sky130_fd_sc_hd__clkdlybuf4s50_1 input16 (.A(mem_write_data[5]),
    .X(net16));
 sky130_fd_sc_hd__clkdlybuf4s50_1 input17 (.A(mem_write_data[6]),
    .X(net17));
 sky130_fd_sc_hd__clkdlybuf4s50_1 input18 (.A(mem_write_data[7]),
    .X(net18));
 sky130_fd_sc_hd__clkdlybuf4s50_1 input19 (.A(mem_write_data[8]),
    .X(net19));
 sky130_fd_sc_hd__clkdlybuf4s50_1 input20 (.A(mem_write_data[9]),
    .X(net20));
 sky130_fd_sc_hd__clkdlybuf4s50_1 input21 (.A(mem_write_en),
    .X(net21));
 sky130_fd_sc_hd__clkdlybuf4s50_1 output22 (.A(net22),
    .X(mem_read_data[0]));
 sky130_fd_sc_hd__clkdlybuf4s50_1 output23 (.A(net23),
    .X(mem_read_data[10]));
 sky130_fd_sc_hd__clkdlybuf4s50_1 output24 (.A(net24),
    .X(mem_read_data[11]));
 sky130_fd_sc_hd__clkdlybuf4s50_1 output25 (.A(net25),
    .X(mem_read_data[12]));
 sky130_fd_sc_hd__clkdlybuf4s50_1 output26 (.A(net26),
    .X(mem_read_data[13]));
 sky130_fd_sc_hd__clkdlybuf4s50_1 output27 (.A(net27),
    .X(mem_read_data[14]));
 sky130_fd_sc_hd__clkdlybuf4s50_1 output28 (.A(net28),
    .X(mem_read_data[15]));
 sky130_fd_sc_hd__clkdlybuf4s50_1 output29 (.A(net29),
    .X(mem_read_data[1]));
 sky130_fd_sc_hd__clkdlybuf4s50_1 output30 (.A(net30),
    .X(mem_read_data[2]));
 sky130_fd_sc_hd__clkdlybuf4s50_1 output31 (.A(net31),
    .X(mem_read_data[3]));
 sky130_fd_sc_hd__clkdlybuf4s50_1 output32 (.A(net32),
    .X(mem_read_data[4]));
 sky130_fd_sc_hd__clkdlybuf4s50_1 output33 (.A(net33),
    .X(mem_read_data[5]));
 sky130_fd_sc_hd__clkdlybuf4s50_1 output34 (.A(net34),
    .X(mem_read_data[6]));
 sky130_fd_sc_hd__clkdlybuf4s50_1 output35 (.A(net35),
    .X(mem_read_data[7]));
 sky130_fd_sc_hd__clkdlybuf4s50_1 output36 (.A(net36),
    .X(mem_read_data[8]));
 sky130_fd_sc_hd__clkdlybuf4s50_1 output37 (.A(net37),
    .X(mem_read_data[9]));
 sky130_fd_sc_hd__buf_4 place59 (.A(_026_),
    .X(net59));
 sky130_fd_sc_hd__buf_4 place61 (.A(net21),
    .X(net61));
 sky130_fd_sc_hd__buf_4 place51 (.A(_007_),
    .X(net51));
 sky130_fd_sc_hd__buf_4 place52 (.A(_006_),
    .X(net52));
 sky130_fd_sc_hd__buf_4 place53 (.A(_005_),
    .X(net53));
 sky130_fd_sc_hd__buf_4 place54 (.A(_004_),
    .X(net54));
 sky130_fd_sc_hd__buf_4 place55 (.A(_003_),
    .X(net55));
 sky130_fd_sc_hd__buf_4 place56 (.A(_002_),
    .X(net56));
 sky130_fd_sc_hd__buf_4 place57 (.A(_001_),
    .X(net57));
 sky130_fd_sc_hd__buf_4 place58 (.A(_000_),
    .X(net58));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_0_clk (.A(clk),
    .X(clknet_0_clk));
 sky130_fd_sc_hd__buf_4 place60 (.A(_020_),
    .X(net60));
 sky130_fd_sc_hd__buf_4 place62 (.A(net1),
    .X(net62));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_4_0_0_clk (.A(clknet_0_clk),
    .X(clknet_4_0_0_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_4_1_0_clk (.A(clknet_0_clk),
    .X(clknet_4_1_0_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_4_2_0_clk (.A(clknet_0_clk),
    .X(clknet_4_2_0_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_4_3_0_clk (.A(clknet_0_clk),
    .X(clknet_4_3_0_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_4_4_0_clk (.A(clknet_0_clk),
    .X(clknet_4_4_0_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_4_5_0_clk (.A(clknet_0_clk),
    .X(clknet_4_5_0_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_4_6_0_clk (.A(clknet_0_clk),
    .X(clknet_4_6_0_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_4_7_0_clk (.A(clknet_0_clk),
    .X(clknet_4_7_0_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_4_8_0_clk (.A(clknet_0_clk),
    .X(clknet_4_8_0_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_4_9_0_clk (.A(clknet_0_clk),
    .X(clknet_4_9_0_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_4_10_0_clk (.A(clknet_0_clk),
    .X(clknet_4_10_0_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_4_11_0_clk (.A(clknet_0_clk),
    .X(clknet_4_11_0_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_4_12_0_clk (.A(clknet_0_clk),
    .X(clknet_4_12_0_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_4_13_0_clk (.A(clknet_0_clk),
    .X(clknet_4_13_0_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_4_14_0_clk (.A(clknet_0_clk),
    .X(clknet_4_14_0_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_4_15_0_clk (.A(clknet_0_clk),
    .X(clknet_4_15_0_clk));
 sky130_fd_sc_hd__clkinv_1 clkload0 (.A(clknet_4_1_0_clk));
 sky130_fd_sc_hd__clkinvlp_4 clkload1 (.A(clknet_4_3_0_clk));
 sky130_fd_sc_hd__bufinv_16 clkload2 (.A(clknet_4_4_0_clk));
 sky130_fd_sc_hd__clkbuf_1 clkload3 (.A(clknet_4_5_0_clk));
 sky130_fd_sc_hd__bufinv_16 clkload4 (.A(clknet_4_6_0_clk));
 sky130_fd_sc_hd__clkinv_2 clkload5 (.A(clknet_4_7_0_clk));
 sky130_fd_sc_hd__clkinv_2 clkload6 (.A(clknet_4_8_0_clk));
 sky130_fd_sc_hd__clkinv_4 clkload7 (.A(clknet_4_9_0_clk));
 sky130_fd_sc_hd__clkinv_1 clkload8 (.A(clknet_4_10_0_clk));
 sky130_fd_sc_hd__clkinv_1 clkload9 (.A(clknet_4_11_0_clk));
 sky130_fd_sc_hd__clkinv_4 clkload10 (.A(clknet_4_12_0_clk));
 sky130_fd_sc_hd__bufinv_16 clkload11 (.A(clknet_4_13_0_clk));
 sky130_fd_sc_hd__bufinv_16 clkload12 (.A(clknet_4_14_0_clk));
 sky130_fd_sc_hd__clkinv_1 clkload13 (.A(clknet_4_15_0_clk));
endmodule
