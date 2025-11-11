module Register_file (RegWrite,
    clk,
    A1,
    A2,
    A3,
    RD1,
    RD2,
    WD3);
 input RegWrite;
 input clk;
 input [2:0] A1;
 input [2:0] A2;
 input [2:0] A3;
 output [15:0] RD1;
 output [15:0] RD2;
 input [15:0] WD3;

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
 wire net38;
 wire net39;
 wire net40;
 wire net41;
 wire net42;
 wire net43;
 wire net44;
 wire net45;
 wire net46;
 wire net47;
 wire net48;
 wire net49;
 wire net50;
 wire net51;
 wire net52;
 wire net53;
 wire net54;
 wire net55;
 wire net56;
 wire net57;
 wire net58;
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
 wire net26;
 wire net25;
 wire net24;
 wire _016_;
 wire _017_;
 wire net23;
 wire _019_;
 wire net22;
 wire _021_;
 wire _022_;
 wire net21;
 wire _024_;
 wire _025_;
 wire net20;
 wire _027_;
 wire _028_;
 wire net19;
 wire net18;
 wire _031_;
 wire _032_;
 wire net17;
 wire _034_;
 wire _035_;
 wire _036_;
 wire net16;
 wire net15;
 wire _039_;
 wire _040_;
 wire net14;
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
 wire net13;
 wire net12;
 wire _113_;
 wire net11;
 wire net10;
 wire net9;
 wire net8;
 wire _118_;
 wire _119_;
 wire net7;
 wire net6;
 wire _122_;
 wire net5;
 wire _124_;
 wire _125_;
 wire net4;
 wire net3;
 wire net2;
 wire _129_;
 wire _130_;
 wire net1;
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
 wire _155_;
 wire _156_;
 wire _157_;
 wire _158_;
 wire _159_;
 wire _160_;
 wire _161_;
 wire _162_;
 wire _163_;
 wire _164_;
 wire _165_;
 wire _166_;
 wire _167_;
 wire _168_;
 wire _169_;
 wire _170_;
 wire _171_;
 wire _172_;
 wire _173_;
 wire _174_;
 wire _175_;
 wire _176_;
 wire _177_;
 wire _178_;
 wire _179_;
 wire _180_;
 wire _181_;
 wire _182_;
 wire _183_;
 wire _184_;
 wire _185_;
 wire _186_;
 wire _187_;
 wire _188_;
 wire _189_;
 wire _190_;
 wire _191_;
 wire _192_;
 wire \reg_array[1][0] ;
 wire \reg_array[1][10] ;
 wire \reg_array[1][11] ;
 wire \reg_array[1][12] ;
 wire \reg_array[1][13] ;
 wire \reg_array[1][14] ;
 wire \reg_array[1][15] ;
 wire \reg_array[1][1] ;
 wire \reg_array[1][2] ;
 wire \reg_array[1][3] ;
 wire \reg_array[1][4] ;
 wire \reg_array[1][5] ;
 wire \reg_array[1][6] ;
 wire \reg_array[1][7] ;
 wire \reg_array[1][8] ;
 wire \reg_array[1][9] ;
 wire \reg_array[2][0] ;
 wire \reg_array[2][10] ;
 wire \reg_array[2][11] ;
 wire \reg_array[2][12] ;
 wire \reg_array[2][13] ;
 wire \reg_array[2][14] ;
 wire \reg_array[2][15] ;
 wire \reg_array[2][1] ;
 wire \reg_array[2][2] ;
 wire \reg_array[2][3] ;
 wire \reg_array[2][4] ;
 wire \reg_array[2][5] ;
 wire \reg_array[2][6] ;
 wire \reg_array[2][7] ;
 wire \reg_array[2][8] ;
 wire \reg_array[2][9] ;
 wire \reg_array[3][0] ;
 wire \reg_array[3][10] ;
 wire \reg_array[3][11] ;
 wire \reg_array[3][12] ;
 wire \reg_array[3][13] ;
 wire \reg_array[3][14] ;
 wire \reg_array[3][15] ;
 wire \reg_array[3][1] ;
 wire \reg_array[3][2] ;
 wire \reg_array[3][3] ;
 wire \reg_array[3][4] ;
 wire \reg_array[3][5] ;
 wire \reg_array[3][6] ;
 wire \reg_array[3][7] ;
 wire \reg_array[3][8] ;
 wire \reg_array[3][9] ;
 wire \reg_array[4][0] ;
 wire \reg_array[4][10] ;
 wire \reg_array[4][11] ;
 wire \reg_array[4][12] ;
 wire \reg_array[4][13] ;
 wire \reg_array[4][14] ;
 wire \reg_array[4][15] ;
 wire \reg_array[4][1] ;
 wire \reg_array[4][2] ;
 wire \reg_array[4][3] ;
 wire \reg_array[4][4] ;
 wire \reg_array[4][5] ;
 wire \reg_array[4][6] ;
 wire \reg_array[4][7] ;
 wire \reg_array[4][8] ;
 wire \reg_array[4][9] ;
 wire \reg_array[5][0] ;
 wire \reg_array[5][10] ;
 wire \reg_array[5][11] ;
 wire \reg_array[5][12] ;
 wire \reg_array[5][13] ;
 wire \reg_array[5][14] ;
 wire \reg_array[5][15] ;
 wire \reg_array[5][1] ;
 wire \reg_array[5][2] ;
 wire \reg_array[5][3] ;
 wire \reg_array[5][4] ;
 wire \reg_array[5][5] ;
 wire \reg_array[5][6] ;
 wire \reg_array[5][7] ;
 wire \reg_array[5][8] ;
 wire \reg_array[5][9] ;
 wire \reg_array[6][0] ;
 wire \reg_array[6][10] ;
 wire \reg_array[6][11] ;
 wire \reg_array[6][12] ;
 wire \reg_array[6][13] ;
 wire \reg_array[6][14] ;
 wire \reg_array[6][15] ;
 wire \reg_array[6][1] ;
 wire \reg_array[6][2] ;
 wire \reg_array[6][3] ;
 wire \reg_array[6][4] ;
 wire \reg_array[6][5] ;
 wire \reg_array[6][6] ;
 wire \reg_array[6][7] ;
 wire \reg_array[6][8] ;
 wire \reg_array[6][9] ;
 wire \reg_array[7][0] ;
 wire \reg_array[7][10] ;
 wire \reg_array[7][11] ;
 wire \reg_array[7][12] ;
 wire \reg_array[7][13] ;
 wire \reg_array[7][14] ;
 wire \reg_array[7][15] ;
 wire \reg_array[7][1] ;
 wire \reg_array[7][2] ;
 wire \reg_array[7][3] ;
 wire \reg_array[7][4] ;
 wire \reg_array[7][5] ;
 wire \reg_array[7][6] ;
 wire \reg_array[7][7] ;
 wire \reg_array[7][8] ;
 wire \reg_array[7][9] ;
 wire net69;
 wire net72;
 wire net76;
 wire clknet_0_clk;
 wire net63;
 wire net64;
 wire net65;
 wire net66;
 wire net67;
 wire net68;
 wire net70;
 wire net71;
 wire net73;
 wire net74;
 wire net75;
 wire net77;
 wire net78;
 wire clknet_3_0__leaf_clk;
 wire clknet_3_1__leaf_clk;
 wire clknet_3_2__leaf_clk;
 wire clknet_3_3__leaf_clk;
 wire clknet_3_4__leaf_clk;
 wire clknet_3_5__leaf_clk;
 wire clknet_3_6__leaf_clk;
 wire clknet_3_7__leaf_clk;

 sky130_fd_sc_hd__nand2b_1 _193_ (.A_N(net8),
    .B(net10),
    .Y(_007_));
 sky130_fd_sc_hd__nand2b_1 _194_ (.A_N(net9),
    .B(net7),
    .Y(_008_));
 sky130_fd_sc_hd__nor2_1 _195_ (.A(_007_),
    .B(_008_),
    .Y(_000_));
 sky130_fd_sc_hd__nand2_1 _196_ (.A(net8),
    .B(net10),
    .Y(_009_));
 sky130_fd_sc_hd__nor3_2 _197_ (.A(net7),
    .B(net9),
    .C(_009_),
    .Y(_001_));
 sky130_fd_sc_hd__nor2_1 _198_ (.A(_008_),
    .B(_009_),
    .Y(_002_));
 sky130_fd_sc_hd__nand2b_1 _199_ (.A_N(net7),
    .B(net9),
    .Y(_010_));
 sky130_fd_sc_hd__nor2_1 _200_ (.A(_007_),
    .B(_010_),
    .Y(_003_));
 sky130_fd_sc_hd__nand2_1 _201_ (.A(net7),
    .B(net9),
    .Y(_011_));
 sky130_fd_sc_hd__nor2_1 _202_ (.A(_007_),
    .B(_011_),
    .Y(_004_));
 sky130_fd_sc_hd__nor2_1 _203_ (.A(_009_),
    .B(_010_),
    .Y(_005_));
 sky130_fd_sc_hd__nor2_1 _204_ (.A(_009_),
    .B(_011_),
    .Y(_006_));
 sky130_fd_sc_hd__mux2_2 _209_ (.A0(\reg_array[2][0] ),
    .A1(\reg_array[3][0] ),
    .S(net78),
    .X(_016_));
 sky130_fd_sc_hd__nand2_1 _210_ (.A(net77),
    .B(_016_),
    .Y(_017_));
 sky130_fd_sc_hd__inv_1 _212_ (.A(net77),
    .Y(_019_));
 sky130_fd_sc_hd__a31oi_1 _214_ (.A1(\reg_array[1][0] ),
    .A2(net78),
    .A3(_019_),
    .B1(net76),
    .Y(_021_));
 sky130_fd_sc_hd__nand2_1 _215_ (.A(net76),
    .B(net77),
    .Y(_022_));
 sky130_fd_sc_hd__mux2_1 _217_ (.A0(\reg_array[6][0] ),
    .A1(\reg_array[7][0] ),
    .S(net78),
    .X(_024_));
 sky130_fd_sc_hd__nand2b_1 _218_ (.A_N(net77),
    .B(net76),
    .Y(_025_));
 sky130_fd_sc_hd__mux2_2 _220_ (.A0(\reg_array[4][0] ),
    .A1(\reg_array[5][0] ),
    .S(net78),
    .X(_027_));
 sky130_fd_sc_hd__o22ai_1 _221_ (.A1(_022_),
    .A2(_024_),
    .B1(_025_),
    .B2(_027_),
    .Y(_028_));
 sky130_fd_sc_hd__a21oi_1 _222_ (.A1(_017_),
    .A2(_021_),
    .B1(_028_),
    .Y(net27));
 sky130_fd_sc_hd__mux2_1 _225_ (.A0(\reg_array[6][10] ),
    .A1(\reg_array[7][10] ),
    .S(net78),
    .X(_031_));
 sky130_fd_sc_hd__mux2_2 _226_ (.A0(\reg_array[4][10] ),
    .A1(\reg_array[5][10] ),
    .S(net78),
    .X(_032_));
 sky130_fd_sc_hd__o22ai_1 _228_ (.A1(_022_),
    .A2(_031_),
    .B1(_032_),
    .B2(_025_),
    .Y(_034_));
 sky130_fd_sc_hd__mux2_1 _229_ (.A0(\reg_array[1][10] ),
    .A1(\reg_array[3][10] ),
    .S(net77),
    .X(_035_));
 sky130_fd_sc_hd__nor2b_4 _230_ (.A(net78),
    .B_N(net77),
    .Y(_036_));
 sky130_fd_sc_hd__a221oi_1 _233_ (.A1(net78),
    .A2(_035_),
    .B1(_036_),
    .B2(\reg_array[2][10] ),
    .C1(net76),
    .Y(_039_));
 sky130_fd_sc_hd__nor2_1 _234_ (.A(_034_),
    .B(_039_),
    .Y(net28));
 sky130_fd_sc_hd__mux2_2 _235_ (.A0(\reg_array[6][11] ),
    .A1(\reg_array[7][11] ),
    .S(net78),
    .X(_040_));
 sky130_fd_sc_hd__mux2_1 _237_ (.A0(\reg_array[4][11] ),
    .A1(\reg_array[5][11] ),
    .S(net78),
    .X(_042_));
 sky130_fd_sc_hd__o22ai_1 _238_ (.A1(_022_),
    .A2(_040_),
    .B1(_042_),
    .B2(_025_),
    .Y(_043_));
 sky130_fd_sc_hd__mux2_4 _239_ (.A0(\reg_array[1][11] ),
    .A1(\reg_array[3][11] ),
    .S(net77),
    .X(_044_));
 sky130_fd_sc_hd__a221oi_2 _240_ (.A1(\reg_array[2][11] ),
    .A2(_036_),
    .B1(_044_),
    .B2(net78),
    .C1(net76),
    .Y(_045_));
 sky130_fd_sc_hd__nor2_1 _241_ (.A(_043_),
    .B(_045_),
    .Y(net29));
 sky130_fd_sc_hd__mux2_2 _242_ (.A0(\reg_array[6][12] ),
    .A1(\reg_array[7][12] ),
    .S(net78),
    .X(_046_));
 sky130_fd_sc_hd__mux2_1 _243_ (.A0(\reg_array[4][12] ),
    .A1(\reg_array[5][12] ),
    .S(net78),
    .X(_047_));
 sky130_fd_sc_hd__o22ai_1 _244_ (.A1(_022_),
    .A2(_046_),
    .B1(_047_),
    .B2(_025_),
    .Y(_048_));
 sky130_fd_sc_hd__mux2_4 _245_ (.A0(\reg_array[1][12] ),
    .A1(\reg_array[3][12] ),
    .S(net77),
    .X(_049_));
 sky130_fd_sc_hd__a221oi_2 _246_ (.A1(\reg_array[2][12] ),
    .A2(_036_),
    .B1(_049_),
    .B2(net78),
    .C1(net76),
    .Y(_050_));
 sky130_fd_sc_hd__nor2_1 _247_ (.A(_048_),
    .B(_050_),
    .Y(net30));
 sky130_fd_sc_hd__mux2_2 _248_ (.A0(\reg_array[6][13] ),
    .A1(\reg_array[7][13] ),
    .S(net78),
    .X(_051_));
 sky130_fd_sc_hd__mux2_1 _249_ (.A0(\reg_array[4][13] ),
    .A1(\reg_array[5][13] ),
    .S(net78),
    .X(_052_));
 sky130_fd_sc_hd__o22ai_1 _250_ (.A1(_022_),
    .A2(_051_),
    .B1(_052_),
    .B2(_025_),
    .Y(_053_));
 sky130_fd_sc_hd__mux2_4 _251_ (.A0(\reg_array[1][13] ),
    .A1(\reg_array[3][13] ),
    .S(net77),
    .X(_054_));
 sky130_fd_sc_hd__a221oi_2 _252_ (.A1(\reg_array[2][13] ),
    .A2(_036_),
    .B1(_054_),
    .B2(net78),
    .C1(net76),
    .Y(_055_));
 sky130_fd_sc_hd__nor2_1 _253_ (.A(_053_),
    .B(_055_),
    .Y(net31));
 sky130_fd_sc_hd__mux2_2 _254_ (.A0(\reg_array[6][14] ),
    .A1(\reg_array[7][14] ),
    .S(net78),
    .X(_056_));
 sky130_fd_sc_hd__mux2_1 _255_ (.A0(\reg_array[4][14] ),
    .A1(\reg_array[5][14] ),
    .S(net78),
    .X(_057_));
 sky130_fd_sc_hd__o22ai_1 _256_ (.A1(_022_),
    .A2(_056_),
    .B1(_057_),
    .B2(_025_),
    .Y(_058_));
 sky130_fd_sc_hd__mux2_4 _257_ (.A0(\reg_array[1][14] ),
    .A1(\reg_array[3][14] ),
    .S(net77),
    .X(_059_));
 sky130_fd_sc_hd__a221oi_2 _258_ (.A1(\reg_array[2][14] ),
    .A2(_036_),
    .B1(_059_),
    .B2(net78),
    .C1(net76),
    .Y(_060_));
 sky130_fd_sc_hd__nor2_1 _259_ (.A(_058_),
    .B(_060_),
    .Y(net32));
 sky130_fd_sc_hd__mux2_2 _260_ (.A0(\reg_array[6][15] ),
    .A1(\reg_array[7][15] ),
    .S(net78),
    .X(_061_));
 sky130_fd_sc_hd__mux2_2 _261_ (.A0(\reg_array[4][15] ),
    .A1(\reg_array[5][15] ),
    .S(net78),
    .X(_062_));
 sky130_fd_sc_hd__o22ai_1 _262_ (.A1(_022_),
    .A2(_061_),
    .B1(_062_),
    .B2(_025_),
    .Y(_063_));
 sky130_fd_sc_hd__mux2_4 _263_ (.A0(\reg_array[1][15] ),
    .A1(\reg_array[3][15] ),
    .S(net77),
    .X(_064_));
 sky130_fd_sc_hd__a221oi_2 _264_ (.A1(\reg_array[2][15] ),
    .A2(_036_),
    .B1(_064_),
    .B2(net78),
    .C1(net76),
    .Y(_065_));
 sky130_fd_sc_hd__nor2_1 _265_ (.A(_063_),
    .B(_065_),
    .Y(net33));
 sky130_fd_sc_hd__mux2_1 _266_ (.A0(\reg_array[6][1] ),
    .A1(\reg_array[7][1] ),
    .S(net78),
    .X(_066_));
 sky130_fd_sc_hd__mux2_2 _267_ (.A0(\reg_array[4][1] ),
    .A1(\reg_array[5][1] ),
    .S(net78),
    .X(_067_));
 sky130_fd_sc_hd__o22ai_1 _268_ (.A1(_022_),
    .A2(_066_),
    .B1(_067_),
    .B2(_025_),
    .Y(_068_));
 sky130_fd_sc_hd__mux2_4 _269_ (.A0(\reg_array[1][1] ),
    .A1(\reg_array[3][1] ),
    .S(net77),
    .X(_069_));
 sky130_fd_sc_hd__a221oi_2 _270_ (.A1(\reg_array[2][1] ),
    .A2(_036_),
    .B1(_069_),
    .B2(net78),
    .C1(net76),
    .Y(_070_));
 sky130_fd_sc_hd__nor2_1 _271_ (.A(_068_),
    .B(_070_),
    .Y(net34));
 sky130_fd_sc_hd__mux2_1 _272_ (.A0(\reg_array[6][2] ),
    .A1(\reg_array[7][2] ),
    .S(net78),
    .X(_071_));
 sky130_fd_sc_hd__mux2_2 _273_ (.A0(\reg_array[4][2] ),
    .A1(\reg_array[5][2] ),
    .S(net78),
    .X(_072_));
 sky130_fd_sc_hd__o22ai_1 _274_ (.A1(_022_),
    .A2(_071_),
    .B1(_072_),
    .B2(_025_),
    .Y(_073_));
 sky130_fd_sc_hd__mux2_4 _275_ (.A0(\reg_array[1][2] ),
    .A1(\reg_array[3][2] ),
    .S(net77),
    .X(_074_));
 sky130_fd_sc_hd__a221oi_2 _276_ (.A1(\reg_array[2][2] ),
    .A2(_036_),
    .B1(_074_),
    .B2(net78),
    .C1(net76),
    .Y(_075_));
 sky130_fd_sc_hd__nor2_1 _277_ (.A(_073_),
    .B(_075_),
    .Y(net35));
 sky130_fd_sc_hd__mux2_1 _278_ (.A0(\reg_array[6][3] ),
    .A1(\reg_array[7][3] ),
    .S(net78),
    .X(_076_));
 sky130_fd_sc_hd__mux2_2 _279_ (.A0(\reg_array[4][3] ),
    .A1(\reg_array[5][3] ),
    .S(net78),
    .X(_077_));
 sky130_fd_sc_hd__o22ai_1 _280_ (.A1(_022_),
    .A2(_076_),
    .B1(_077_),
    .B2(_025_),
    .Y(_078_));
 sky130_fd_sc_hd__mux2_4 _281_ (.A0(\reg_array[1][3] ),
    .A1(\reg_array[3][3] ),
    .S(net77),
    .X(_079_));
 sky130_fd_sc_hd__a221oi_2 _282_ (.A1(\reg_array[2][3] ),
    .A2(_036_),
    .B1(_079_),
    .B2(net78),
    .C1(net76),
    .Y(_080_));
 sky130_fd_sc_hd__nor2_1 _283_ (.A(_078_),
    .B(_080_),
    .Y(net36));
 sky130_fd_sc_hd__mux2_1 _284_ (.A0(\reg_array[6][4] ),
    .A1(\reg_array[7][4] ),
    .S(net78),
    .X(_081_));
 sky130_fd_sc_hd__mux2_2 _285_ (.A0(\reg_array[4][4] ),
    .A1(\reg_array[5][4] ),
    .S(net78),
    .X(_082_));
 sky130_fd_sc_hd__o22ai_1 _286_ (.A1(_022_),
    .A2(_081_),
    .B1(_082_),
    .B2(_025_),
    .Y(_083_));
 sky130_fd_sc_hd__mux2_2 _287_ (.A0(\reg_array[1][4] ),
    .A1(\reg_array[3][4] ),
    .S(net77),
    .X(_084_));
 sky130_fd_sc_hd__a221oi_1 _288_ (.A1(\reg_array[2][4] ),
    .A2(_036_),
    .B1(_084_),
    .B2(net78),
    .C1(net76),
    .Y(_085_));
 sky130_fd_sc_hd__nor2_1 _289_ (.A(_083_),
    .B(_085_),
    .Y(net37));
 sky130_fd_sc_hd__mux2_1 _290_ (.A0(\reg_array[6][5] ),
    .A1(\reg_array[7][5] ),
    .S(net78),
    .X(_086_));
 sky130_fd_sc_hd__mux2_2 _291_ (.A0(\reg_array[4][5] ),
    .A1(\reg_array[5][5] ),
    .S(net78),
    .X(_087_));
 sky130_fd_sc_hd__o22ai_1 _292_ (.A1(_022_),
    .A2(_086_),
    .B1(_087_),
    .B2(_025_),
    .Y(_088_));
 sky130_fd_sc_hd__mux2_2 _293_ (.A0(\reg_array[1][5] ),
    .A1(\reg_array[3][5] ),
    .S(net77),
    .X(_089_));
 sky130_fd_sc_hd__a221oi_1 _294_ (.A1(\reg_array[2][5] ),
    .A2(_036_),
    .B1(_089_),
    .B2(net78),
    .C1(net76),
    .Y(_090_));
 sky130_fd_sc_hd__nor2_1 _295_ (.A(_088_),
    .B(_090_),
    .Y(net38));
 sky130_fd_sc_hd__mux2_1 _296_ (.A0(\reg_array[6][6] ),
    .A1(\reg_array[7][6] ),
    .S(net78),
    .X(_091_));
 sky130_fd_sc_hd__mux2_2 _297_ (.A0(\reg_array[4][6] ),
    .A1(\reg_array[5][6] ),
    .S(net78),
    .X(_092_));
 sky130_fd_sc_hd__o22ai_1 _298_ (.A1(_022_),
    .A2(_091_),
    .B1(_092_),
    .B2(_025_),
    .Y(_093_));
 sky130_fd_sc_hd__mux2_2 _299_ (.A0(\reg_array[1][6] ),
    .A1(\reg_array[3][6] ),
    .S(net77),
    .X(_094_));
 sky130_fd_sc_hd__a221oi_1 _300_ (.A1(\reg_array[2][6] ),
    .A2(_036_),
    .B1(_094_),
    .B2(net78),
    .C1(net76),
    .Y(_095_));
 sky130_fd_sc_hd__nor2_1 _301_ (.A(_093_),
    .B(_095_),
    .Y(net39));
 sky130_fd_sc_hd__mux2_1 _302_ (.A0(\reg_array[6][7] ),
    .A1(\reg_array[7][7] ),
    .S(net78),
    .X(_096_));
 sky130_fd_sc_hd__mux2_2 _303_ (.A0(\reg_array[4][7] ),
    .A1(\reg_array[5][7] ),
    .S(net78),
    .X(_097_));
 sky130_fd_sc_hd__o22ai_1 _304_ (.A1(_022_),
    .A2(_096_),
    .B1(_097_),
    .B2(_025_),
    .Y(_098_));
 sky130_fd_sc_hd__mux2_2 _305_ (.A0(\reg_array[1][7] ),
    .A1(\reg_array[3][7] ),
    .S(net77),
    .X(_099_));
 sky130_fd_sc_hd__a221oi_1 _306_ (.A1(\reg_array[2][7] ),
    .A2(_036_),
    .B1(_099_),
    .B2(net78),
    .C1(net76),
    .Y(_100_));
 sky130_fd_sc_hd__nor2_1 _307_ (.A(_098_),
    .B(_100_),
    .Y(net40));
 sky130_fd_sc_hd__mux2_1 _308_ (.A0(\reg_array[6][8] ),
    .A1(\reg_array[7][8] ),
    .S(net78),
    .X(_101_));
 sky130_fd_sc_hd__mux2_2 _309_ (.A0(\reg_array[4][8] ),
    .A1(\reg_array[5][8] ),
    .S(net78),
    .X(_102_));
 sky130_fd_sc_hd__o22ai_1 _310_ (.A1(_022_),
    .A2(_101_),
    .B1(_102_),
    .B2(_025_),
    .Y(_103_));
 sky130_fd_sc_hd__mux2_2 _311_ (.A0(\reg_array[1][8] ),
    .A1(\reg_array[3][8] ),
    .S(net77),
    .X(_104_));
 sky130_fd_sc_hd__a221oi_1 _312_ (.A1(\reg_array[2][8] ),
    .A2(_036_),
    .B1(_104_),
    .B2(net78),
    .C1(net76),
    .Y(_105_));
 sky130_fd_sc_hd__nor2_1 _313_ (.A(_103_),
    .B(_105_),
    .Y(net41));
 sky130_fd_sc_hd__mux2_1 _314_ (.A0(\reg_array[6][9] ),
    .A1(\reg_array[7][9] ),
    .S(net78),
    .X(_106_));
 sky130_fd_sc_hd__mux2_2 _315_ (.A0(\reg_array[4][9] ),
    .A1(\reg_array[5][9] ),
    .S(net78),
    .X(_107_));
 sky130_fd_sc_hd__o22ai_1 _316_ (.A1(_022_),
    .A2(_106_),
    .B1(_107_),
    .B2(_025_),
    .Y(_108_));
 sky130_fd_sc_hd__mux2_2 _317_ (.A0(\reg_array[1][9] ),
    .A1(\reg_array[3][9] ),
    .S(net77),
    .X(_109_));
 sky130_fd_sc_hd__a221oi_1 _318_ (.A1(\reg_array[2][9] ),
    .A2(_036_),
    .B1(_109_),
    .B2(net78),
    .C1(net76),
    .Y(_110_));
 sky130_fd_sc_hd__nor2_1 _319_ (.A(_108_),
    .B(_110_),
    .Y(net42));
 sky130_fd_sc_hd__and2_1 _322_ (.A(net73),
    .B(net74),
    .X(_113_));
 sky130_fd_sc_hd__mux2i_1 _327_ (.A0(\reg_array[6][0] ),
    .A1(\reg_array[7][0] ),
    .S(net75),
    .Y(_118_));
 sky130_fd_sc_hd__nor2b_2 _328_ (.A(net74),
    .B_N(net73),
    .Y(_119_));
 sky130_fd_sc_hd__mux2i_1 _331_ (.A0(\reg_array[4][0] ),
    .A1(\reg_array[5][0] ),
    .S(net75),
    .Y(_122_));
 sky130_fd_sc_hd__mux2_2 _333_ (.A0(\reg_array[2][0] ),
    .A1(\reg_array[3][0] ),
    .S(net75),
    .X(_124_));
 sky130_fd_sc_hd__nor2b_2 _334_ (.A(net74),
    .B_N(net75),
    .Y(_125_));
 sky130_fd_sc_hd__a221oi_2 _338_ (.A1(net74),
    .A2(_124_),
    .B1(net70),
    .B2(\reg_array[1][0] ),
    .C1(net73),
    .Y(_129_));
 sky130_fd_sc_hd__a221oi_2 _339_ (.A1(_113_),
    .A2(_118_),
    .B1(_119_),
    .B2(_122_),
    .C1(_129_),
    .Y(net43));
 sky130_fd_sc_hd__mux2i_1 _340_ (.A0(\reg_array[6][10] ),
    .A1(\reg_array[7][10] ),
    .S(net75),
    .Y(_130_));
 sky130_fd_sc_hd__mux2i_1 _342_ (.A0(\reg_array[4][10] ),
    .A1(\reg_array[5][10] ),
    .S(net75),
    .Y(_132_));
 sky130_fd_sc_hd__mux2_1 _343_ (.A0(\reg_array[2][10] ),
    .A1(\reg_array[3][10] ),
    .S(net75),
    .X(_133_));
 sky130_fd_sc_hd__a221oi_2 _344_ (.A1(\reg_array[1][10] ),
    .A2(net70),
    .B1(_133_),
    .B2(net74),
    .C1(net73),
    .Y(_134_));
 sky130_fd_sc_hd__a221oi_2 _345_ (.A1(_113_),
    .A2(_130_),
    .B1(_132_),
    .B2(_119_),
    .C1(_134_),
    .Y(net44));
 sky130_fd_sc_hd__mux2i_1 _346_ (.A0(\reg_array[6][11] ),
    .A1(\reg_array[7][11] ),
    .S(net75),
    .Y(_135_));
 sky130_fd_sc_hd__mux2i_1 _347_ (.A0(\reg_array[4][11] ),
    .A1(\reg_array[5][11] ),
    .S(net75),
    .Y(_136_));
 sky130_fd_sc_hd__mux2_1 _348_ (.A0(\reg_array[2][11] ),
    .A1(\reg_array[3][11] ),
    .S(net75),
    .X(_137_));
 sky130_fd_sc_hd__a221oi_2 _349_ (.A1(\reg_array[1][11] ),
    .A2(_125_),
    .B1(_137_),
    .B2(net74),
    .C1(net73),
    .Y(_138_));
 sky130_fd_sc_hd__a221oi_2 _350_ (.A1(_113_),
    .A2(_135_),
    .B1(_136_),
    .B2(_119_),
    .C1(_138_),
    .Y(net45));
 sky130_fd_sc_hd__mux2i_1 _351_ (.A0(\reg_array[6][12] ),
    .A1(\reg_array[7][12] ),
    .S(net75),
    .Y(_139_));
 sky130_fd_sc_hd__mux2i_1 _352_ (.A0(\reg_array[4][12] ),
    .A1(\reg_array[5][12] ),
    .S(net75),
    .Y(_140_));
 sky130_fd_sc_hd__mux2_1 _353_ (.A0(\reg_array[2][12] ),
    .A1(\reg_array[3][12] ),
    .S(net75),
    .X(_141_));
 sky130_fd_sc_hd__a221oi_2 _354_ (.A1(\reg_array[1][12] ),
    .A2(net70),
    .B1(_141_),
    .B2(net74),
    .C1(net73),
    .Y(_142_));
 sky130_fd_sc_hd__a221oi_2 _355_ (.A1(_113_),
    .A2(_139_),
    .B1(_140_),
    .B2(_119_),
    .C1(_142_),
    .Y(net46));
 sky130_fd_sc_hd__mux2i_1 _357_ (.A0(\reg_array[6][13] ),
    .A1(\reg_array[7][13] ),
    .S(net75),
    .Y(_144_));
 sky130_fd_sc_hd__mux2i_1 _358_ (.A0(\reg_array[4][13] ),
    .A1(\reg_array[5][13] ),
    .S(net75),
    .Y(_145_));
 sky130_fd_sc_hd__mux2_1 _359_ (.A0(\reg_array[2][13] ),
    .A1(\reg_array[3][13] ),
    .S(net75),
    .X(_146_));
 sky130_fd_sc_hd__a221oi_2 _360_ (.A1(\reg_array[1][13] ),
    .A2(_125_),
    .B1(_146_),
    .B2(net74),
    .C1(net73),
    .Y(_147_));
 sky130_fd_sc_hd__a221oi_2 _361_ (.A1(_113_),
    .A2(_144_),
    .B1(_145_),
    .B2(_119_),
    .C1(_147_),
    .Y(net47));
 sky130_fd_sc_hd__mux2i_1 _362_ (.A0(\reg_array[6][14] ),
    .A1(\reg_array[7][14] ),
    .S(net75),
    .Y(_148_));
 sky130_fd_sc_hd__mux2i_1 _363_ (.A0(\reg_array[4][14] ),
    .A1(\reg_array[5][14] ),
    .S(net75),
    .Y(_149_));
 sky130_fd_sc_hd__mux2_1 _364_ (.A0(\reg_array[2][14] ),
    .A1(\reg_array[3][14] ),
    .S(net75),
    .X(_150_));
 sky130_fd_sc_hd__a221oi_2 _365_ (.A1(\reg_array[1][14] ),
    .A2(_125_),
    .B1(_150_),
    .B2(net74),
    .C1(net73),
    .Y(_151_));
 sky130_fd_sc_hd__a221oi_2 _366_ (.A1(_113_),
    .A2(_148_),
    .B1(_149_),
    .B2(_119_),
    .C1(_151_),
    .Y(net48));
 sky130_fd_sc_hd__mux2i_1 _367_ (.A0(\reg_array[6][15] ),
    .A1(\reg_array[7][15] ),
    .S(net75),
    .Y(_152_));
 sky130_fd_sc_hd__mux2i_1 _368_ (.A0(\reg_array[4][15] ),
    .A1(\reg_array[5][15] ),
    .S(net75),
    .Y(_153_));
 sky130_fd_sc_hd__mux2_1 _370_ (.A0(\reg_array[2][15] ),
    .A1(\reg_array[3][15] ),
    .S(net75),
    .X(_155_));
 sky130_fd_sc_hd__a221oi_2 _371_ (.A1(\reg_array[1][15] ),
    .A2(_125_),
    .B1(_155_),
    .B2(net74),
    .C1(net73),
    .Y(_156_));
 sky130_fd_sc_hd__a221oi_2 _372_ (.A1(net72),
    .A2(_152_),
    .B1(_153_),
    .B2(net71),
    .C1(_156_),
    .Y(net49));
 sky130_fd_sc_hd__mux2i_1 _373_ (.A0(\reg_array[6][1] ),
    .A1(\reg_array[7][1] ),
    .S(net75),
    .Y(_157_));
 sky130_fd_sc_hd__mux2i_1 _374_ (.A0(\reg_array[4][1] ),
    .A1(\reg_array[5][1] ),
    .S(net75),
    .Y(_158_));
 sky130_fd_sc_hd__mux2_1 _375_ (.A0(\reg_array[2][1] ),
    .A1(\reg_array[3][1] ),
    .S(net75),
    .X(_159_));
 sky130_fd_sc_hd__a221oi_2 _376_ (.A1(\reg_array[1][1] ),
    .A2(_125_),
    .B1(_159_),
    .B2(net74),
    .C1(net73),
    .Y(_160_));
 sky130_fd_sc_hd__a221oi_2 _377_ (.A1(net72),
    .A2(_157_),
    .B1(_158_),
    .B2(net71),
    .C1(_160_),
    .Y(net50));
 sky130_fd_sc_hd__mux2i_1 _378_ (.A0(\reg_array[6][2] ),
    .A1(\reg_array[7][2] ),
    .S(net75),
    .Y(_161_));
 sky130_fd_sc_hd__mux2i_1 _379_ (.A0(\reg_array[4][2] ),
    .A1(\reg_array[5][2] ),
    .S(net75),
    .Y(_162_));
 sky130_fd_sc_hd__mux2_1 _380_ (.A0(\reg_array[2][2] ),
    .A1(\reg_array[3][2] ),
    .S(net75),
    .X(_163_));
 sky130_fd_sc_hd__a221oi_2 _381_ (.A1(\reg_array[1][2] ),
    .A2(_125_),
    .B1(_163_),
    .B2(net74),
    .C1(net73),
    .Y(_164_));
 sky130_fd_sc_hd__a221oi_2 _382_ (.A1(net72),
    .A2(_161_),
    .B1(_162_),
    .B2(net71),
    .C1(_164_),
    .Y(net51));
 sky130_fd_sc_hd__mux2i_1 _383_ (.A0(\reg_array[6][3] ),
    .A1(\reg_array[7][3] ),
    .S(net75),
    .Y(_165_));
 sky130_fd_sc_hd__mux2i_1 _384_ (.A0(\reg_array[4][3] ),
    .A1(\reg_array[5][3] ),
    .S(net75),
    .Y(_166_));
 sky130_fd_sc_hd__mux2_1 _385_ (.A0(\reg_array[2][3] ),
    .A1(\reg_array[3][3] ),
    .S(net75),
    .X(_167_));
 sky130_fd_sc_hd__a221oi_2 _386_ (.A1(\reg_array[1][3] ),
    .A2(_125_),
    .B1(_167_),
    .B2(net74),
    .C1(net73),
    .Y(_168_));
 sky130_fd_sc_hd__a221oi_2 _387_ (.A1(net72),
    .A2(_165_),
    .B1(_166_),
    .B2(net71),
    .C1(_168_),
    .Y(net52));
 sky130_fd_sc_hd__mux2i_1 _388_ (.A0(\reg_array[6][4] ),
    .A1(\reg_array[7][4] ),
    .S(net75),
    .Y(_169_));
 sky130_fd_sc_hd__mux2i_1 _389_ (.A0(\reg_array[4][4] ),
    .A1(\reg_array[5][4] ),
    .S(net75),
    .Y(_170_));
 sky130_fd_sc_hd__mux2_1 _390_ (.A0(\reg_array[2][4] ),
    .A1(\reg_array[3][4] ),
    .S(net75),
    .X(_171_));
 sky130_fd_sc_hd__a221oi_2 _391_ (.A1(\reg_array[1][4] ),
    .A2(net70),
    .B1(_171_),
    .B2(net74),
    .C1(net73),
    .Y(_172_));
 sky130_fd_sc_hd__a221oi_2 _392_ (.A1(net72),
    .A2(_169_),
    .B1(_170_),
    .B2(net71),
    .C1(_172_),
    .Y(net53));
 sky130_fd_sc_hd__mux2i_1 _393_ (.A0(\reg_array[6][5] ),
    .A1(\reg_array[7][5] ),
    .S(net75),
    .Y(_173_));
 sky130_fd_sc_hd__mux2i_1 _394_ (.A0(\reg_array[4][5] ),
    .A1(\reg_array[5][5] ),
    .S(net75),
    .Y(_174_));
 sky130_fd_sc_hd__mux2_1 _395_ (.A0(\reg_array[2][5] ),
    .A1(\reg_array[3][5] ),
    .S(net75),
    .X(_175_));
 sky130_fd_sc_hd__a221oi_2 _396_ (.A1(\reg_array[1][5] ),
    .A2(net70),
    .B1(_175_),
    .B2(net74),
    .C1(net73),
    .Y(_176_));
 sky130_fd_sc_hd__a221oi_2 _397_ (.A1(net72),
    .A2(_173_),
    .B1(_174_),
    .B2(net71),
    .C1(_176_),
    .Y(net54));
 sky130_fd_sc_hd__mux2i_1 _398_ (.A0(\reg_array[6][6] ),
    .A1(\reg_array[7][6] ),
    .S(net75),
    .Y(_177_));
 sky130_fd_sc_hd__mux2i_1 _399_ (.A0(\reg_array[4][6] ),
    .A1(\reg_array[5][6] ),
    .S(net75),
    .Y(_178_));
 sky130_fd_sc_hd__mux2_1 _400_ (.A0(\reg_array[2][6] ),
    .A1(\reg_array[3][6] ),
    .S(net75),
    .X(_179_));
 sky130_fd_sc_hd__a221oi_2 _401_ (.A1(\reg_array[1][6] ),
    .A2(net70),
    .B1(_179_),
    .B2(net74),
    .C1(net73),
    .Y(_180_));
 sky130_fd_sc_hd__a221oi_2 _402_ (.A1(net72),
    .A2(_177_),
    .B1(_178_),
    .B2(net71),
    .C1(_180_),
    .Y(net55));
 sky130_fd_sc_hd__mux2i_1 _403_ (.A0(\reg_array[6][7] ),
    .A1(\reg_array[7][7] ),
    .S(net75),
    .Y(_181_));
 sky130_fd_sc_hd__mux2i_1 _404_ (.A0(\reg_array[4][7] ),
    .A1(\reg_array[5][7] ),
    .S(net75),
    .Y(_182_));
 sky130_fd_sc_hd__mux2_1 _405_ (.A0(\reg_array[2][7] ),
    .A1(\reg_array[3][7] ),
    .S(net75),
    .X(_183_));
 sky130_fd_sc_hd__a221oi_2 _406_ (.A1(\reg_array[1][7] ),
    .A2(net70),
    .B1(_183_),
    .B2(net74),
    .C1(net73),
    .Y(_184_));
 sky130_fd_sc_hd__a221oi_2 _407_ (.A1(_113_),
    .A2(_181_),
    .B1(_182_),
    .B2(_119_),
    .C1(_184_),
    .Y(net56));
 sky130_fd_sc_hd__mux2i_1 _408_ (.A0(\reg_array[6][8] ),
    .A1(\reg_array[7][8] ),
    .S(net75),
    .Y(_185_));
 sky130_fd_sc_hd__mux2i_1 _409_ (.A0(\reg_array[4][8] ),
    .A1(\reg_array[5][8] ),
    .S(net75),
    .Y(_186_));
 sky130_fd_sc_hd__mux2_1 _410_ (.A0(\reg_array[2][8] ),
    .A1(\reg_array[3][8] ),
    .S(net75),
    .X(_187_));
 sky130_fd_sc_hd__a221oi_2 _411_ (.A1(\reg_array[1][8] ),
    .A2(net70),
    .B1(_187_),
    .B2(net74),
    .C1(net73),
    .Y(_188_));
 sky130_fd_sc_hd__a221oi_2 _412_ (.A1(net72),
    .A2(_185_),
    .B1(_186_),
    .B2(net71),
    .C1(_188_),
    .Y(net57));
 sky130_fd_sc_hd__mux2i_1 _413_ (.A0(\reg_array[6][9] ),
    .A1(\reg_array[7][9] ),
    .S(net75),
    .Y(_189_));
 sky130_fd_sc_hd__mux2i_1 _414_ (.A0(\reg_array[4][9] ),
    .A1(\reg_array[5][9] ),
    .S(net75),
    .Y(_190_));
 sky130_fd_sc_hd__mux2_1 _415_ (.A0(\reg_array[2][9] ),
    .A1(\reg_array[3][9] ),
    .S(net75),
    .X(_191_));
 sky130_fd_sc_hd__a221oi_2 _416_ (.A1(\reg_array[1][9] ),
    .A2(net70),
    .B1(_191_),
    .B2(net74),
    .C1(net73),
    .Y(_192_));
 sky130_fd_sc_hd__a221oi_2 _417_ (.A1(net72),
    .A2(_189_),
    .B1(_190_),
    .B2(net71),
    .C1(_192_),
    .Y(net58));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[1][0]$_DFFE_PP_  (.D(net11),
    .DE(net69),
    .Q(\reg_array[1][0] ),
    .CLK(clknet_3_7__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[1][10]$_DFFE_PP_  (.D(net12),
    .DE(net69),
    .Q(\reg_array[1][10] ),
    .CLK(clknet_3_6__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[1][11]$_DFFE_PP_  (.D(net13),
    .DE(net69),
    .Q(\reg_array[1][11] ),
    .CLK(clknet_3_3__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[1][12]$_DFFE_PP_  (.D(net14),
    .DE(net69),
    .Q(\reg_array[1][12] ),
    .CLK(clknet_3_7__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[1][13]$_DFFE_PP_  (.D(net15),
    .DE(net69),
    .Q(\reg_array[1][13] ),
    .CLK(clknet_3_6__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[1][14]$_DFFE_PP_  (.D(net16),
    .DE(net69),
    .Q(\reg_array[1][14] ),
    .CLK(clknet_3_6__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[1][15]$_DFFE_PP_  (.D(net17),
    .DE(net69),
    .Q(\reg_array[1][15] ),
    .CLK(clknet_3_1__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[1][1]$_DFFE_PP_  (.D(net18),
    .DE(net69),
    .Q(\reg_array[1][1] ),
    .CLK(clknet_3_1__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[1][2]$_DFFE_PP_  (.D(net19),
    .DE(net69),
    .Q(\reg_array[1][2] ),
    .CLK(clknet_3_2__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[1][3]$_DFFE_PP_  (.D(net20),
    .DE(net69),
    .Q(\reg_array[1][3] ),
    .CLK(clknet_3_3__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[1][4]$_DFFE_PP_  (.D(net21),
    .DE(net69),
    .Q(\reg_array[1][4] ),
    .CLK(clknet_3_1__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[1][5]$_DFFE_PP_  (.D(net22),
    .DE(net69),
    .Q(\reg_array[1][5] ),
    .CLK(clknet_3_4__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[1][6]$_DFFE_PP_  (.D(net23),
    .DE(net69),
    .Q(\reg_array[1][6] ),
    .CLK(clknet_3_1__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[1][7]$_DFFE_PP_  (.D(net24),
    .DE(net69),
    .Q(\reg_array[1][7] ),
    .CLK(clknet_3_5__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[1][8]$_DFFE_PP_  (.D(net25),
    .DE(net69),
    .Q(\reg_array[1][8] ),
    .CLK(clknet_3_5__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[1][9]$_DFFE_PP_  (.D(net26),
    .DE(net69),
    .Q(\reg_array[1][9] ),
    .CLK(clknet_3_4__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[2][0]$_DFFE_PP_  (.D(net11),
    .DE(net68),
    .Q(\reg_array[2][0] ),
    .CLK(clknet_3_7__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[2][10]$_DFFE_PP_  (.D(net12),
    .DE(net68),
    .Q(\reg_array[2][10] ),
    .CLK(clknet_3_4__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[2][11]$_DFFE_PP_  (.D(net13),
    .DE(net68),
    .Q(\reg_array[2][11] ),
    .CLK(clknet_3_3__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[2][12]$_DFFE_PP_  (.D(net14),
    .DE(net68),
    .Q(\reg_array[2][12] ),
    .CLK(clknet_3_7__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[2][13]$_DFFE_PP_  (.D(net15),
    .DE(net68),
    .Q(\reg_array[2][13] ),
    .CLK(clknet_3_6__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[2][14]$_DFFE_PP_  (.D(net16),
    .DE(net68),
    .Q(\reg_array[2][14] ),
    .CLK(clknet_3_6__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[2][15]$_DFFE_PP_  (.D(net17),
    .DE(net68),
    .Q(\reg_array[2][15] ),
    .CLK(clknet_3_3__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[2][1]$_DFFE_PP_  (.D(net18),
    .DE(net68),
    .Q(\reg_array[2][1] ),
    .CLK(clknet_3_0__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[2][2]$_DFFE_PP_  (.D(net19),
    .DE(net68),
    .Q(\reg_array[2][2] ),
    .CLK(clknet_3_2__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[2][3]$_DFFE_PP_  (.D(net20),
    .DE(net68),
    .Q(\reg_array[2][3] ),
    .CLK(clknet_3_2__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[2][4]$_DFFE_PP_  (.D(net21),
    .DE(net68),
    .Q(\reg_array[2][4] ),
    .CLK(clknet_3_0__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[2][5]$_DFFE_PP_  (.D(net22),
    .DE(net68),
    .Q(\reg_array[2][5] ),
    .CLK(clknet_3_4__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[2][6]$_DFFE_PP_  (.D(net23),
    .DE(net68),
    .Q(\reg_array[2][6] ),
    .CLK(clknet_3_1__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[2][7]$_DFFE_PP_  (.D(net24),
    .DE(net68),
    .Q(\reg_array[2][7] ),
    .CLK(clknet_3_5__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[2][8]$_DFFE_PP_  (.D(net25),
    .DE(net68),
    .Q(\reg_array[2][8] ),
    .CLK(clknet_3_5__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[2][9]$_DFFE_PP_  (.D(net26),
    .DE(net68),
    .Q(\reg_array[2][9] ),
    .CLK(clknet_3_4__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[3][0]$_DFFE_PP_  (.D(net11),
    .DE(net67),
    .Q(\reg_array[3][0] ),
    .CLK(clknet_3_7__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[3][10]$_DFFE_PP_  (.D(net12),
    .DE(net67),
    .Q(\reg_array[3][10] ),
    .CLK(clknet_3_6__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[3][11]$_DFFE_PP_  (.D(net13),
    .DE(net67),
    .Q(\reg_array[3][11] ),
    .CLK(clknet_3_3__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[3][12]$_DFFE_PP_  (.D(net14),
    .DE(net67),
    .Q(\reg_array[3][12] ),
    .CLK(clknet_3_7__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[3][13]$_DFFE_PP_  (.D(net15),
    .DE(net67),
    .Q(\reg_array[3][13] ),
    .CLK(clknet_3_6__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[3][14]$_DFFE_PP_  (.D(net16),
    .DE(net67),
    .Q(\reg_array[3][14] ),
    .CLK(clknet_3_6__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[3][15]$_DFFE_PP_  (.D(net17),
    .DE(net67),
    .Q(\reg_array[3][15] ),
    .CLK(clknet_3_1__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[3][1]$_DFFE_PP_  (.D(net18),
    .DE(net67),
    .Q(\reg_array[3][1] ),
    .CLK(clknet_3_1__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[3][2]$_DFFE_PP_  (.D(net19),
    .DE(net67),
    .Q(\reg_array[3][2] ),
    .CLK(clknet_3_2__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[3][3]$_DFFE_PP_  (.D(net20),
    .DE(net67),
    .Q(\reg_array[3][3] ),
    .CLK(clknet_3_2__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[3][4]$_DFFE_PP_  (.D(net21),
    .DE(net67),
    .Q(\reg_array[3][4] ),
    .CLK(clknet_3_1__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[3][5]$_DFFE_PP_  (.D(net22),
    .DE(net67),
    .Q(\reg_array[3][5] ),
    .CLK(clknet_3_4__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[3][6]$_DFFE_PP_  (.D(net23),
    .DE(net67),
    .Q(\reg_array[3][6] ),
    .CLK(clknet_3_1__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[3][7]$_DFFE_PP_  (.D(net24),
    .DE(net67),
    .Q(\reg_array[3][7] ),
    .CLK(clknet_3_5__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[3][8]$_DFFE_PP_  (.D(net25),
    .DE(net67),
    .Q(\reg_array[3][8] ),
    .CLK(clknet_3_5__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[3][9]$_DFFE_PP_  (.D(net26),
    .DE(net67),
    .Q(\reg_array[3][9] ),
    .CLK(clknet_3_4__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[4][0]$_DFFE_PP_  (.D(net11),
    .DE(net66),
    .Q(\reg_array[4][0] ),
    .CLK(clknet_3_7__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[4][10]$_DFFE_PP_  (.D(net12),
    .DE(net66),
    .Q(\reg_array[4][10] ),
    .CLK(clknet_3_6__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[4][11]$_DFFE_PP_  (.D(net13),
    .DE(net66),
    .Q(\reg_array[4][11] ),
    .CLK(clknet_3_3__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[4][12]$_DFFE_PP_  (.D(net14),
    .DE(net66),
    .Q(\reg_array[4][12] ),
    .CLK(clknet_3_7__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[4][13]$_DFFE_PP_  (.D(net15),
    .DE(net66),
    .Q(\reg_array[4][13] ),
    .CLK(clknet_3_6__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[4][14]$_DFFE_PP_  (.D(net16),
    .DE(net66),
    .Q(\reg_array[4][14] ),
    .CLK(clknet_3_3__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[4][15]$_DFFE_PP_  (.D(net17),
    .DE(net66),
    .Q(\reg_array[4][15] ),
    .CLK(clknet_3_0__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[4][1]$_DFFE_PP_  (.D(net18),
    .DE(net66),
    .Q(\reg_array[4][1] ),
    .CLK(clknet_3_0__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[4][2]$_DFFE_PP_  (.D(net19),
    .DE(net66),
    .Q(\reg_array[4][2] ),
    .CLK(clknet_3_2__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[4][3]$_DFFE_PP_  (.D(net20),
    .DE(net66),
    .Q(\reg_array[4][3] ),
    .CLK(clknet_3_2__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[4][4]$_DFFE_PP_  (.D(net21),
    .DE(net66),
    .Q(\reg_array[4][4] ),
    .CLK(clknet_3_0__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[4][5]$_DFFE_PP_  (.D(net22),
    .DE(net66),
    .Q(\reg_array[4][5] ),
    .CLK(clknet_3_4__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[4][6]$_DFFE_PP_  (.D(net23),
    .DE(net66),
    .Q(\reg_array[4][6] ),
    .CLK(clknet_3_1__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[4][7]$_DFFE_PP_  (.D(net24),
    .DE(net66),
    .Q(\reg_array[4][7] ),
    .CLK(clknet_3_5__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[4][8]$_DFFE_PP_  (.D(net25),
    .DE(net66),
    .Q(\reg_array[4][8] ),
    .CLK(clknet_3_5__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[4][9]$_DFFE_PP_  (.D(net26),
    .DE(net66),
    .Q(\reg_array[4][9] ),
    .CLK(clknet_3_4__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[5][0]$_DFFE_PP_  (.D(net11),
    .DE(net65),
    .Q(\reg_array[5][0] ),
    .CLK(clknet_3_7__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[5][10]$_DFFE_PP_  (.D(net12),
    .DE(net65),
    .Q(\reg_array[5][10] ),
    .CLK(clknet_3_4__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[5][11]$_DFFE_PP_  (.D(net13),
    .DE(net65),
    .Q(\reg_array[5][11] ),
    .CLK(clknet_3_3__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[5][12]$_DFFE_PP_  (.D(net14),
    .DE(net65),
    .Q(\reg_array[5][12] ),
    .CLK(clknet_3_7__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[5][13]$_DFFE_PP_  (.D(net15),
    .DE(net65),
    .Q(\reg_array[5][13] ),
    .CLK(clknet_3_6__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[5][14]$_DFFE_PP_  (.D(net16),
    .DE(net65),
    .Q(\reg_array[5][14] ),
    .CLK(clknet_3_6__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[5][15]$_DFFE_PP_  (.D(net17),
    .DE(net65),
    .Q(\reg_array[5][15] ),
    .CLK(clknet_3_0__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[5][1]$_DFFE_PP_  (.D(net18),
    .DE(net65),
    .Q(\reg_array[5][1] ),
    .CLK(clknet_3_0__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[5][2]$_DFFE_PP_  (.D(net19),
    .DE(net65),
    .Q(\reg_array[5][2] ),
    .CLK(clknet_3_2__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[5][3]$_DFFE_PP_  (.D(net20),
    .DE(net65),
    .Q(\reg_array[5][3] ),
    .CLK(clknet_3_2__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[5][4]$_DFFE_PP_  (.D(net21),
    .DE(net65),
    .Q(\reg_array[5][4] ),
    .CLK(clknet_3_0__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[5][5]$_DFFE_PP_  (.D(net22),
    .DE(net65),
    .Q(\reg_array[5][5] ),
    .CLK(clknet_3_4__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[5][6]$_DFFE_PP_  (.D(net23),
    .DE(net65),
    .Q(\reg_array[5][6] ),
    .CLK(clknet_3_1__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[5][7]$_DFFE_PP_  (.D(net24),
    .DE(net65),
    .Q(\reg_array[5][7] ),
    .CLK(clknet_3_5__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[5][8]$_DFFE_PP_  (.D(net25),
    .DE(net65),
    .Q(\reg_array[5][8] ),
    .CLK(clknet_3_5__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[5][9]$_DFFE_PP_  (.D(net26),
    .DE(net65),
    .Q(\reg_array[5][9] ),
    .CLK(clknet_3_4__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[6][0]$_DFFE_PP_  (.D(net11),
    .DE(net64),
    .Q(\reg_array[6][0] ),
    .CLK(clknet_3_7__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[6][10]$_DFFE_PP_  (.D(net12),
    .DE(net64),
    .Q(\reg_array[6][10] ),
    .CLK(clknet_3_6__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[6][11]$_DFFE_PP_  (.D(net13),
    .DE(net64),
    .Q(\reg_array[6][11] ),
    .CLK(clknet_3_3__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[6][12]$_DFFE_PP_  (.D(net14),
    .DE(net64),
    .Q(\reg_array[6][12] ),
    .CLK(clknet_3_7__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[6][13]$_DFFE_PP_  (.D(net15),
    .DE(net64),
    .Q(\reg_array[6][13] ),
    .CLK(clknet_3_7__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[6][14]$_DFFE_PP_  (.D(net16),
    .DE(net64),
    .Q(\reg_array[6][14] ),
    .CLK(clknet_3_6__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[6][15]$_DFFE_PP_  (.D(net17),
    .DE(net64),
    .Q(\reg_array[6][15] ),
    .CLK(clknet_3_0__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[6][1]$_DFFE_PP_  (.D(net18),
    .DE(net64),
    .Q(\reg_array[6][1] ),
    .CLK(clknet_3_0__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[6][2]$_DFFE_PP_  (.D(net19),
    .DE(net64),
    .Q(\reg_array[6][2] ),
    .CLK(clknet_3_2__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[6][3]$_DFFE_PP_  (.D(net20),
    .DE(net64),
    .Q(\reg_array[6][3] ),
    .CLK(clknet_3_2__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[6][4]$_DFFE_PP_  (.D(net21),
    .DE(net64),
    .Q(\reg_array[6][4] ),
    .CLK(clknet_3_0__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[6][5]$_DFFE_PP_  (.D(net22),
    .DE(net64),
    .Q(\reg_array[6][5] ),
    .CLK(clknet_3_4__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[6][6]$_DFFE_PP_  (.D(net23),
    .DE(net64),
    .Q(\reg_array[6][6] ),
    .CLK(clknet_3_1__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[6][7]$_DFFE_PP_  (.D(net24),
    .DE(net64),
    .Q(\reg_array[6][7] ),
    .CLK(clknet_3_5__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[6][8]$_DFFE_PP_  (.D(net25),
    .DE(net64),
    .Q(\reg_array[6][8] ),
    .CLK(clknet_3_5__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[6][9]$_DFFE_PP_  (.D(net26),
    .DE(net64),
    .Q(\reg_array[6][9] ),
    .CLK(clknet_3_4__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[7][0]$_DFFE_PP_  (.D(net11),
    .DE(net63),
    .Q(\reg_array[7][0] ),
    .CLK(clknet_3_7__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[7][10]$_DFFE_PP_  (.D(net12),
    .DE(net63),
    .Q(\reg_array[7][10] ),
    .CLK(clknet_3_6__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[7][11]$_DFFE_PP_  (.D(net13),
    .DE(net63),
    .Q(\reg_array[7][11] ),
    .CLK(clknet_3_3__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[7][12]$_DFFE_PP_  (.D(net14),
    .DE(net63),
    .Q(\reg_array[7][12] ),
    .CLK(clknet_3_7__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[7][13]$_DFFE_PP_  (.D(net15),
    .DE(net63),
    .Q(\reg_array[7][13] ),
    .CLK(clknet_3_7__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[7][14]$_DFFE_PP_  (.D(net16),
    .DE(net63),
    .Q(\reg_array[7][14] ),
    .CLK(clknet_3_3__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[7][15]$_DFFE_PP_  (.D(net17),
    .DE(net63),
    .Q(\reg_array[7][15] ),
    .CLK(clknet_3_0__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[7][1]$_DFFE_PP_  (.D(net18),
    .DE(net63),
    .Q(\reg_array[7][1] ),
    .CLK(clknet_3_0__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[7][2]$_DFFE_PP_  (.D(net19),
    .DE(net63),
    .Q(\reg_array[7][2] ),
    .CLK(clknet_3_2__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[7][3]$_DFFE_PP_  (.D(net20),
    .DE(net63),
    .Q(\reg_array[7][3] ),
    .CLK(clknet_3_2__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[7][4]$_DFFE_PP_  (.D(net21),
    .DE(net63),
    .Q(\reg_array[7][4] ),
    .CLK(clknet_3_0__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[7][5]$_DFFE_PP_  (.D(net22),
    .DE(net63),
    .Q(\reg_array[7][5] ),
    .CLK(clknet_3_4__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[7][6]$_DFFE_PP_  (.D(net23),
    .DE(net63),
    .Q(\reg_array[7][6] ),
    .CLK(clknet_3_1__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[7][7]$_DFFE_PP_  (.D(net24),
    .DE(net63),
    .Q(\reg_array[7][7] ),
    .CLK(clknet_3_5__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[7][8]$_DFFE_PP_  (.D(net25),
    .DE(net63),
    .Q(\reg_array[7][8] ),
    .CLK(clknet_3_5__leaf_clk));
 sky130_fd_sc_hd__edfxtp_1 \reg_array[7][9]$_DFFE_PP_  (.D(net26),
    .DE(net63),
    .Q(\reg_array[7][9] ),
    .CLK(clknet_3_4__leaf_clk));
 sky130_fd_sc_hd__buf_2 input1 (.A(A1[0]),
    .X(net1));
 sky130_fd_sc_hd__clkdlybuf4s50_1 input2 (.A(A1[1]),
    .X(net2));
 sky130_fd_sc_hd__clkdlybuf4s50_1 input3 (.A(A1[2]),
    .X(net3));
 sky130_fd_sc_hd__buf_2 input4 (.A(A2[0]),
    .X(net4));
 sky130_fd_sc_hd__clkdlybuf4s50_1 input5 (.A(A2[1]),
    .X(net5));
 sky130_fd_sc_hd__clkdlybuf4s50_1 input6 (.A(A2[2]),
    .X(net6));
 sky130_fd_sc_hd__clkdlybuf4s50_1 input7 (.A(A3[0]),
    .X(net7));
 sky130_fd_sc_hd__clkdlybuf4s50_1 input8 (.A(A3[1]),
    .X(net8));
 sky130_fd_sc_hd__clkdlybuf4s50_1 input9 (.A(A3[2]),
    .X(net9));
 sky130_fd_sc_hd__clkdlybuf4s50_1 input10 (.A(RegWrite),
    .X(net10));
 sky130_fd_sc_hd__clkdlybuf4s50_1 input11 (.A(WD3[0]),
    .X(net11));
 sky130_fd_sc_hd__clkdlybuf4s50_1 input12 (.A(WD3[10]),
    .X(net12));
 sky130_fd_sc_hd__clkdlybuf4s50_1 input13 (.A(WD3[11]),
    .X(net13));
 sky130_fd_sc_hd__clkdlybuf4s50_1 input14 (.A(WD3[12]),
    .X(net14));
 sky130_fd_sc_hd__clkdlybuf4s50_1 input15 (.A(WD3[13]),
    .X(net15));
 sky130_fd_sc_hd__clkdlybuf4s50_1 input16 (.A(WD3[14]),
    .X(net16));
 sky130_fd_sc_hd__clkdlybuf4s50_1 input17 (.A(WD3[15]),
    .X(net17));
 sky130_fd_sc_hd__clkdlybuf4s50_1 input18 (.A(WD3[1]),
    .X(net18));
 sky130_fd_sc_hd__clkdlybuf4s50_1 input19 (.A(WD3[2]),
    .X(net19));
 sky130_fd_sc_hd__clkdlybuf4s50_1 input20 (.A(WD3[3]),
    .X(net20));
 sky130_fd_sc_hd__clkdlybuf4s50_1 input21 (.A(WD3[4]),
    .X(net21));
 sky130_fd_sc_hd__clkdlybuf4s50_1 input22 (.A(WD3[5]),
    .X(net22));
 sky130_fd_sc_hd__clkdlybuf4s50_1 input23 (.A(WD3[6]),
    .X(net23));
 sky130_fd_sc_hd__clkdlybuf4s50_1 input24 (.A(WD3[7]),
    .X(net24));
 sky130_fd_sc_hd__clkdlybuf4s50_1 input25 (.A(WD3[8]),
    .X(net25));
 sky130_fd_sc_hd__clkdlybuf4s50_1 input26 (.A(WD3[9]),
    .X(net26));
 sky130_fd_sc_hd__clkdlybuf4s50_1 output27 (.A(net27),
    .X(RD1[0]));
 sky130_fd_sc_hd__clkdlybuf4s50_1 output28 (.A(net28),
    .X(RD1[10]));
 sky130_fd_sc_hd__clkdlybuf4s50_1 output29 (.A(net29),
    .X(RD1[11]));
 sky130_fd_sc_hd__clkdlybuf4s50_1 output30 (.A(net30),
    .X(RD1[12]));
 sky130_fd_sc_hd__clkdlybuf4s50_1 output31 (.A(net31),
    .X(RD1[13]));
 sky130_fd_sc_hd__clkdlybuf4s50_1 output32 (.A(net32),
    .X(RD1[14]));
 sky130_fd_sc_hd__clkdlybuf4s50_1 output33 (.A(net33),
    .X(RD1[15]));
 sky130_fd_sc_hd__clkdlybuf4s50_1 output34 (.A(net34),
    .X(RD1[1]));
 sky130_fd_sc_hd__clkdlybuf4s50_1 output35 (.A(net35),
    .X(RD1[2]));
 sky130_fd_sc_hd__clkdlybuf4s50_1 output36 (.A(net36),
    .X(RD1[3]));
 sky130_fd_sc_hd__clkdlybuf4s50_1 output37 (.A(net37),
    .X(RD1[4]));
 sky130_fd_sc_hd__clkdlybuf4s50_1 output38 (.A(net38),
    .X(RD1[5]));
 sky130_fd_sc_hd__clkdlybuf4s50_1 output39 (.A(net39),
    .X(RD1[6]));
 sky130_fd_sc_hd__clkdlybuf4s50_1 output40 (.A(net40),
    .X(RD1[7]));
 sky130_fd_sc_hd__clkdlybuf4s50_1 output41 (.A(net41),
    .X(RD1[8]));
 sky130_fd_sc_hd__clkdlybuf4s50_1 output42 (.A(net42),
    .X(RD1[9]));
 sky130_fd_sc_hd__clkdlybuf4s50_1 output43 (.A(net43),
    .X(RD2[0]));
 sky130_fd_sc_hd__clkdlybuf4s50_1 output44 (.A(net44),
    .X(RD2[10]));
 sky130_fd_sc_hd__clkdlybuf4s50_1 output45 (.A(net45),
    .X(RD2[11]));
 sky130_fd_sc_hd__clkdlybuf4s50_1 output46 (.A(net46),
    .X(RD2[12]));
 sky130_fd_sc_hd__clkdlybuf4s50_1 output47 (.A(net47),
    .X(RD2[13]));
 sky130_fd_sc_hd__clkdlybuf4s50_1 output48 (.A(net48),
    .X(RD2[14]));
 sky130_fd_sc_hd__clkdlybuf4s50_1 output49 (.A(net49),
    .X(RD2[15]));
 sky130_fd_sc_hd__clkdlybuf4s50_1 output50 (.A(net50),
    .X(RD2[1]));
 sky130_fd_sc_hd__clkdlybuf4s50_1 output51 (.A(net51),
    .X(RD2[2]));
 sky130_fd_sc_hd__clkdlybuf4s50_1 output52 (.A(net52),
    .X(RD2[3]));
 sky130_fd_sc_hd__clkdlybuf4s50_1 output53 (.A(net53),
    .X(RD2[4]));
 sky130_fd_sc_hd__clkdlybuf4s50_1 output54 (.A(net54),
    .X(RD2[5]));
 sky130_fd_sc_hd__clkdlybuf4s50_1 output55 (.A(net55),
    .X(RD2[6]));
 sky130_fd_sc_hd__clkdlybuf4s50_1 output56 (.A(net56),
    .X(RD2[7]));
 sky130_fd_sc_hd__clkdlybuf4s50_1 output57 (.A(net57),
    .X(RD2[8]));
 sky130_fd_sc_hd__clkdlybuf4s50_1 output58 (.A(net58),
    .X(RD2[9]));
 sky130_fd_sc_hd__buf_4 place69 (.A(_000_),
    .X(net69));
 sky130_fd_sc_hd__buf_4 place72 (.A(_113_),
    .X(net72));
 sky130_fd_sc_hd__buf_4 place76 (.A(net3),
    .X(net76));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_0_clk (.A(clk),
    .X(clknet_0_clk));
 sky130_fd_sc_hd__buf_4 place63 (.A(_006_),
    .X(net63));
 sky130_fd_sc_hd__buf_4 place64 (.A(_005_),
    .X(net64));
 sky130_fd_sc_hd__buf_4 place65 (.A(_004_),
    .X(net65));
 sky130_fd_sc_hd__buf_4 place66 (.A(_003_),
    .X(net66));
 sky130_fd_sc_hd__buf_4 place67 (.A(_002_),
    .X(net67));
 sky130_fd_sc_hd__buf_4 place68 (.A(_001_),
    .X(net68));
 sky130_fd_sc_hd__buf_4 place70 (.A(_125_),
    .X(net70));
 sky130_fd_sc_hd__buf_4 place71 (.A(_119_),
    .X(net71));
 sky130_fd_sc_hd__buf_4 place73 (.A(net6),
    .X(net73));
 sky130_fd_sc_hd__buf_4 place74 (.A(net5),
    .X(net74));
 sky130_fd_sc_hd__buf_4 place75 (.A(net4),
    .X(net75));
 sky130_fd_sc_hd__buf_4 place77 (.A(net2),
    .X(net77));
 sky130_fd_sc_hd__buf_4 place78 (.A(net1),
    .X(net78));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_3_0__f_clk (.A(clknet_0_clk),
    .X(clknet_3_0__leaf_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_3_1__f_clk (.A(clknet_0_clk),
    .X(clknet_3_1__leaf_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_3_2__f_clk (.A(clknet_0_clk),
    .X(clknet_3_2__leaf_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_3_3__f_clk (.A(clknet_0_clk),
    .X(clknet_3_3__leaf_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_3_4__f_clk (.A(clknet_0_clk),
    .X(clknet_3_4__leaf_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_3_5__f_clk (.A(clknet_0_clk),
    .X(clknet_3_5__leaf_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_3_6__f_clk (.A(clknet_0_clk),
    .X(clknet_3_6__leaf_clk));
 sky130_fd_sc_hd__clkbuf_16 clkbuf_3_7__f_clk (.A(clknet_0_clk),
    .X(clknet_3_7__leaf_clk));
 sky130_fd_sc_hd__clkinv_1 clkload0 (.A(clknet_3_0__leaf_clk));
 sky130_fd_sc_hd__clkinv_2 clkload1 (.A(clknet_3_1__leaf_clk));
 sky130_fd_sc_hd__clkinv_2 clkload2 (.A(clknet_3_2__leaf_clk));
 sky130_fd_sc_hd__clkinvlp_4 clkload3 (.A(clknet_3_3__leaf_clk));
 sky130_fd_sc_hd__clkinv_1 clkload4 (.A(clknet_3_5__leaf_clk));
 sky130_fd_sc_hd__clkbuf_1 clkload5 (.A(clknet_3_6__leaf_clk));
endmodule
