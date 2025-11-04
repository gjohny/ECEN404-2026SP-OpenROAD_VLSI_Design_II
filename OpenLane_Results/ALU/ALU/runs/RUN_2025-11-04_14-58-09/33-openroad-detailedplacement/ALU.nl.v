module ALU (zero,
    ALU_control,
    ALU_result,
    SrcA,
    SrcB);
 output zero;
 input [3:0] ALU_control;
 output [15:0] ALU_result;
 input [15:0] SrcA;
 input [15:0] SrcB;

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
 wire _193_;
 wire _194_;
 wire _195_;
 wire _196_;
 wire _197_;
 wire _198_;
 wire _199_;
 wire _200_;
 wire _201_;
 wire _202_;
 wire _203_;
 wire _204_;
 wire _205_;
 wire _206_;
 wire _207_;
 wire _208_;
 wire _209_;
 wire _210_;
 wire _211_;
 wire _212_;
 wire _213_;
 wire _214_;
 wire _215_;
 wire _216_;
 wire _217_;
 wire _218_;
 wire _219_;
 wire _220_;
 wire _221_;
 wire _222_;
 wire _223_;
 wire _224_;
 wire _225_;
 wire _226_;
 wire _227_;
 wire _228_;
 wire _229_;
 wire _230_;
 wire _231_;
 wire _232_;
 wire _233_;
 wire _234_;
 wire _235_;
 wire _236_;
 wire _237_;
 wire _238_;
 wire _239_;
 wire _240_;
 wire _241_;
 wire _242_;
 wire _243_;
 wire _244_;
 wire _245_;
 wire _246_;
 wire _247_;
 wire _248_;
 wire _249_;
 wire _250_;
 wire _251_;
 wire _252_;
 wire _253_;
 wire _254_;
 wire _255_;
 wire _256_;
 wire _257_;
 wire _258_;
 wire _259_;
 wire _260_;
 wire _261_;
 wire _262_;
 wire _263_;
 wire _264_;
 wire _265_;
 wire _266_;
 wire _267_;
 wire _268_;
 wire _269_;
 wire _270_;
 wire _271_;
 wire _272_;
 wire _273_;
 wire _274_;
 wire _275_;
 wire _276_;
 wire _277_;
 wire _278_;
 wire _279_;
 wire _280_;
 wire _281_;
 wire _282_;
 wire _283_;
 wire _284_;
 wire _285_;
 wire _286_;
 wire _287_;
 wire _288_;
 wire _289_;
 wire _290_;
 wire _291_;
 wire _292_;
 wire _293_;
 wire _294_;
 wire _295_;
 wire _296_;
 wire _297_;
 wire _298_;
 wire _299_;
 wire _300_;
 wire _301_;
 wire _302_;
 wire _303_;
 wire _304_;
 wire _305_;
 wire _306_;
 wire _307_;
 wire _308_;
 wire _309_;
 wire _310_;
 wire _311_;
 wire _312_;
 wire _313_;
 wire _314_;
 wire _315_;
 wire _316_;
 wire _317_;
 wire _318_;
 wire _319_;
 wire _320_;
 wire _321_;
 wire _322_;
 wire _323_;
 wire _324_;
 wire _325_;
 wire _326_;
 wire _327_;
 wire _328_;
 wire _329_;
 wire _330_;
 wire _331_;
 wire _332_;
 wire _333_;
 wire _334_;
 wire _335_;
 wire _336_;
 wire _337_;
 wire _338_;
 wire _339_;
 wire _340_;
 wire _341_;
 wire _342_;
 wire _343_;
 wire _344_;
 wire _345_;
 wire _346_;
 wire _347_;
 wire _348_;
 wire _349_;
 wire _350_;
 wire _351_;
 wire _352_;
 wire _353_;
 wire _354_;
 wire _355_;
 wire _356_;
 wire _357_;
 wire _358_;
 wire _359_;
 wire _360_;
 wire _361_;
 wire _362_;
 wire _363_;
 wire _364_;
 wire _365_;
 wire _366_;
 wire _367_;
 wire _368_;
 wire _369_;
 wire _370_;
 wire _371_;
 wire _372_;
 wire _373_;
 wire _374_;
 wire _375_;
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
 wire net59;
 wire net60;
 wire net61;
 wire net62;
 wire net63;
 wire net64;
 wire net65;
 wire net66;
 wire net67;
 wire net68;
 wire net69;
 wire net70;
 wire net71;
 wire net72;
 wire net73;
 wire net74;
 wire net75;
 wire net76;
 wire net77;
 wire net78;
 wire net79;
 wire net80;
 wire net81;
 wire net82;
 wire net83;
 wire net84;
 wire net85;
 wire net86;
 wire net87;
 wire net88;
 wire net89;
 wire net90;
 wire net91;
 wire net92;
 wire net93;
 wire net94;
 wire net95;
 wire net96;
 wire net97;
 wire net98;
 wire net99;
 wire net100;
 wire net101;
 wire net102;
 wire net103;
 wire net104;
 wire net105;
 wire net106;

 sky130_fd_sc_hd__inv_2 _376_ (.A(net5),
    .Y(_331_));
 sky130_fd_sc_hd__inv_2 _377_ (.A(net68),
    .Y(_332_));
 sky130_fd_sc_hd__inv_2 _378_ (.A(net100),
    .Y(_333_));
 sky130_fd_sc_hd__inv_2 _379_ (.A(net89),
    .Y(_334_));
 sky130_fd_sc_hd__inv_2 _380_ (.A(net87),
    .Y(_335_));
 sky130_fd_sc_hd__inv_2 _381_ (.A(net66),
    .Y(_336_));
 sky130_fd_sc_hd__inv_2 _382_ (.A(net64),
    .Y(_337_));
 sky130_fd_sc_hd__inv_2 _383_ (.A(net103),
    .Y(_338_));
 sky130_fd_sc_hd__and3b_2 _384_ (.A_N(net4),
    .B(net3),
    .C(net88),
    .X(_339_));
 sky130_fd_sc_hd__nand3b_2 _385_ (.A_N(net4),
    .B(net3),
    .C(net88),
    .Y(_340_));
 sky130_fd_sc_hd__mux4_1 _386_ (.A0(net89),
    .A1(net87),
    .A2(net66),
    .A3(net64),
    .S0(net83),
    .S1(net77),
    .X(_341_));
 sky130_fd_sc_hd__mux2_1 _387_ (.A0(net103),
    .A1(net101),
    .S(net85),
    .X(_342_));
 sky130_fd_sc_hd__mux4_1 _388_ (.A0(net62),
    .A1(net60),
    .A2(net103),
    .A3(net101),
    .S0(net85),
    .S1(net79),
    .X(_343_));
 sky130_fd_sc_hd__mux2_1 _389_ (.A0(_341_),
    .A1(_343_),
    .S(net71),
    .X(_344_));
 sky130_fd_sc_hd__nor2_2 _390_ (.A(net67),
    .B(net73),
    .Y(_345_));
 sky130_fd_sc_hd__or2_2 _391_ (.A(net68),
    .B(net71),
    .X(_346_));
 sky130_fd_sc_hd__mux4_1 _392_ (.A0(net5),
    .A1(net100),
    .A2(net98),
    .A3(net97),
    .S0(net81),
    .S1(net76),
    .X(_347_));
 sky130_fd_sc_hd__and2_2 _393_ (.A(_332_),
    .B(net71),
    .X(_348_));
 sky130_fd_sc_hd__nand2_1 _394_ (.A(_332_),
    .B(net71),
    .Y(_349_));
 sky130_fd_sc_hd__mux4_1 _395_ (.A0(net96),
    .A1(net95),
    .A2(net92),
    .A3(net90),
    .S0(net81),
    .S1(net75),
    .X(_350_));
 sky130_fd_sc_hd__a22o_1 _396_ (.A1(_345_),
    .A2(_347_),
    .B1(_348_),
    .B2(_350_),
    .X(_351_));
 sky130_fd_sc_hd__a21oi_1 _397_ (.A1(net67),
    .A2(_344_),
    .B1(_351_),
    .Y(_352_));
 sky130_fd_sc_hd__nor2_1 _398_ (.A(_340_),
    .B(_352_),
    .Y(_353_));
 sky130_fd_sc_hd__nand2_1 _399_ (.A(net5),
    .B(net81),
    .Y(_354_));
 sky130_fd_sc_hd__a21o_1 _400_ (.A1(net88),
    .A2(net104),
    .B1(_354_),
    .X(_355_));
 sky130_fd_sc_hd__nor2_1 _401_ (.A(net3),
    .B(net4),
    .Y(_356_));
 sky130_fd_sc_hd__nand2_1 _402_ (.A(_331_),
    .B(net85),
    .Y(_357_));
 sky130_fd_sc_hd__o211a_1 _403_ (.A1(net5),
    .A2(net81),
    .B1(_355_),
    .C1(_356_),
    .X(_358_));
 sky130_fd_sc_hd__nor3b_1 _404_ (.A(net2),
    .B(net4),
    .C_N(net3),
    .Y(_359_));
 sky130_fd_sc_hd__or3b_4 _405_ (.A(net88),
    .B(net4),
    .C_N(net3),
    .X(_360_));
 sky130_fd_sc_hd__and2_2 _406_ (.A(net104),
    .B(_359_),
    .X(_361_));
 sky130_fd_sc_hd__nand2_2 _407_ (.A(net104),
    .B(_359_),
    .Y(_362_));
 sky130_fd_sc_hd__nor2_1 _408_ (.A(net67),
    .B(_362_),
    .Y(_363_));
 sky130_fd_sc_hd__nor2_1 _409_ (.A(net85),
    .B(net79),
    .Y(_364_));
 sky130_fd_sc_hd__nor3_1 _410_ (.A(net71),
    .B(net82),
    .C(net76),
    .Y(_365_));
 sky130_fd_sc_hd__nor4b_2 _411_ (.A(net88),
    .B(net104),
    .C(net3),
    .D_N(net4),
    .Y(_366_));
 sky130_fd_sc_hd__or4b_4 _412_ (.A(net88),
    .B(net104),
    .C(net3),
    .D_N(net4),
    .X(_367_));
 sky130_fd_sc_hd__nor2_4 _413_ (.A(net105),
    .B(_360_),
    .Y(_368_));
 sky130_fd_sc_hd__a221o_1 _414_ (.A1(_363_),
    .A2(net59),
    .B1(_368_),
    .B2(net82),
    .C1(_366_),
    .X(_369_));
 sky130_fd_sc_hd__a211o_1 _415_ (.A1(net5),
    .A2(_369_),
    .B1(_358_),
    .C1(_353_),
    .X(net37));
 sky130_fd_sc_hd__and2b_2 _416_ (.A_N(net88),
    .B(_356_),
    .X(_370_));
 sky130_fd_sc_hd__or3_4 _417_ (.A(net88),
    .B(net3),
    .C(net4),
    .X(_371_));
 sky130_fd_sc_hd__or4b_1 _418_ (.A(net88),
    .B(net3),
    .C(net4),
    .D_N(net104),
    .X(_372_));
 sky130_fd_sc_hd__and3_1 _419_ (.A(net85),
    .B(net79),
    .C(net57),
    .X(_373_));
 sky130_fd_sc_hd__a21oi_1 _420_ (.A1(net85),
    .A2(net57),
    .B1(net79),
    .Y(_374_));
 sky130_fd_sc_hd__or3_1 _421_ (.A(net100),
    .B(_373_),
    .C(_374_),
    .X(_375_));
 sky130_fd_sc_hd__o21ai_1 _422_ (.A1(_373_),
    .A2(_374_),
    .B1(net12),
    .Y(_000_));
 sky130_fd_sc_hd__a21oi_1 _423_ (.A1(_375_),
    .A2(_000_),
    .B1(_357_),
    .Y(_001_));
 sky130_fd_sc_hd__a31o_1 _424_ (.A1(_357_),
    .A2(_375_),
    .A3(_000_),
    .B1(_371_),
    .X(_002_));
 sky130_fd_sc_hd__o21a_1 _425_ (.A1(_333_),
    .A2(net81),
    .B1(_354_),
    .X(_003_));
 sky130_fd_sc_hd__or3_1 _426_ (.A(net71),
    .B(net75),
    .C(_003_),
    .X(_004_));
 sky130_fd_sc_hd__and2_1 _427_ (.A(net88),
    .B(_356_),
    .X(_005_));
 sky130_fd_sc_hd__or3b_1 _428_ (.A(net104),
    .B(_333_),
    .C_N(net75),
    .X(_006_));
 sky130_fd_sc_hd__o22a_1 _429_ (.A1(net100),
    .A2(_367_),
    .B1(_006_),
    .B2(_360_),
    .X(_007_));
 sky130_fd_sc_hd__o211ai_1 _430_ (.A1(net100),
    .A2(net75),
    .B1(net54),
    .C1(_006_),
    .Y(_008_));
 sky130_fd_sc_hd__o311a_1 _431_ (.A1(net67),
    .A2(_362_),
    .A3(_004_),
    .B1(_007_),
    .C1(_008_),
    .X(_009_));
 sky130_fd_sc_hd__mux4_1 _432_ (.A0(net87),
    .A1(net66),
    .A2(net64),
    .A3(net62),
    .S0(net84),
    .S1(net78),
    .X(_010_));
 sky130_fd_sc_hd__and2b_1 _433_ (.A_N(net72),
    .B(_010_),
    .X(_011_));
 sky130_fd_sc_hd__or3b_1 _434_ (.A(net79),
    .B(_338_),
    .C_N(net85),
    .X(_012_));
 sky130_fd_sc_hd__nand3b_1 _435_ (.A_N(net105),
    .B(net85),
    .C(_012_),
    .Y(_013_));
 sky130_fd_sc_hd__mux2_1 _436_ (.A0(net61),
    .A1(net10),
    .S(net86),
    .X(_014_));
 sky130_fd_sc_hd__mux2_1 _437_ (.A0(_014_),
    .A1(net101),
    .S(net79),
    .X(_015_));
 sky130_fd_sc_hd__a31o_1 _438_ (.A1(net72),
    .A2(_013_),
    .A3(_015_),
    .B1(_011_),
    .X(_016_));
 sky130_fd_sc_hd__mux4_1 _439_ (.A0(net95),
    .A1(net92),
    .A2(net90),
    .A3(net89),
    .S0(net83),
    .S1(net77),
    .X(_017_));
 sky130_fd_sc_hd__mux4_1 _440_ (.A0(net100),
    .A1(net98),
    .A2(net97),
    .A3(net96),
    .S0(net82),
    .S1(net76),
    .X(_018_));
 sky130_fd_sc_hd__a22o_1 _441_ (.A1(_348_),
    .A2(_017_),
    .B1(_018_),
    .B2(_345_),
    .X(_019_));
 sky130_fd_sc_hd__a21oi_1 _442_ (.A1(net67),
    .A2(_016_),
    .B1(_019_),
    .Y(_020_));
 sky130_fd_sc_hd__o22a_1 _443_ (.A1(_001_),
    .A2(_002_),
    .B1(_020_),
    .B2(_340_),
    .X(_021_));
 sky130_fd_sc_hd__nand2_1 _444_ (.A(_009_),
    .B(_021_),
    .Y(net44));
 sky130_fd_sc_hd__a21bo_1 _445_ (.A1(_357_),
    .A2(_375_),
    .B1_N(_000_),
    .X(_022_));
 sky130_fd_sc_hd__and2b_1 _446_ (.A_N(_364_),
    .B(net57),
    .X(_023_));
 sky130_fd_sc_hd__xnor2_1 _447_ (.A(net73),
    .B(_023_),
    .Y(_024_));
 sky130_fd_sc_hd__and2_1 _448_ (.A(net98),
    .B(_024_),
    .X(_025_));
 sky130_fd_sc_hd__xor2_2 _449_ (.A(net98),
    .B(_024_),
    .X(_026_));
 sky130_fd_sc_hd__nand2_1 _450_ (.A(_022_),
    .B(_026_),
    .Y(_027_));
 sky130_fd_sc_hd__or2_1 _451_ (.A(_022_),
    .B(_026_),
    .X(_028_));
 sky130_fd_sc_hd__and2b_1 _452_ (.A_N(net79),
    .B(_342_),
    .X(_029_));
 sky130_fd_sc_hd__mux4_1 _453_ (.A0(net66),
    .A1(net65),
    .A2(net62),
    .A3(net60),
    .S0(net84),
    .S1(net78),
    .X(_030_));
 sky130_fd_sc_hd__mux2_1 _454_ (.A0(_030_),
    .A1(_029_),
    .S(net72),
    .X(_031_));
 sky130_fd_sc_hd__mux4_1 _455_ (.A0(net98),
    .A1(net97),
    .A2(net15),
    .A3(net95),
    .S0(net82),
    .S1(net76),
    .X(_032_));
 sky130_fd_sc_hd__mux4_1 _456_ (.A0(net93),
    .A1(net91),
    .A2(net89),
    .A3(net87),
    .S0(net83),
    .S1(net77),
    .X(_033_));
 sky130_fd_sc_hd__a22o_1 _457_ (.A1(_345_),
    .A2(_032_),
    .B1(_033_),
    .B2(_348_),
    .X(_034_));
 sky130_fd_sc_hd__a21o_1 _458_ (.A1(net70),
    .A2(_031_),
    .B1(_034_),
    .X(_035_));
 sky130_fd_sc_hd__nor2_1 _459_ (.A(net106),
    .B(_340_),
    .Y(_036_));
 sky130_fd_sc_hd__or2_1 _460_ (.A(net105),
    .B(_340_),
    .X(_037_));
 sky130_fd_sc_hd__mux2_1 _461_ (.A0(net99),
    .A1(net12),
    .S(net85),
    .X(_038_));
 sky130_fd_sc_hd__o21ai_1 _462_ (.A1(_331_),
    .A2(net85),
    .B1(net79),
    .Y(_039_));
 sky130_fd_sc_hd__o21ai_1 _463_ (.A1(net79),
    .A2(_038_),
    .B1(_039_),
    .Y(_040_));
 sky130_fd_sc_hd__nor2_1 _464_ (.A(net73),
    .B(_040_),
    .Y(_041_));
 sky130_fd_sc_hd__nand3b_1 _465_ (.A_N(net106),
    .B(net73),
    .C(net99),
    .Y(_042_));
 sky130_fd_sc_hd__o211a_1 _466_ (.A1(net73),
    .A2(net99),
    .B1(net54),
    .C1(_042_),
    .X(_043_));
 sky130_fd_sc_hd__nand2_1 _467_ (.A(net12),
    .B(net99),
    .Y(_044_));
 sky130_fd_sc_hd__or2_1 _468_ (.A(net12),
    .B(net99),
    .X(_045_));
 sky130_fd_sc_hd__and3_1 _469_ (.A(_366_),
    .B(_044_),
    .C(_045_),
    .X(_046_));
 sky130_fd_sc_hd__a311o_1 _470_ (.A1(net73),
    .A2(net99),
    .A3(_368_),
    .B1(_043_),
    .C1(_046_),
    .X(_047_));
 sky130_fd_sc_hd__a221o_1 _471_ (.A1(_035_),
    .A2(_036_),
    .B1(_041_),
    .B2(_363_),
    .C1(_047_),
    .X(_048_));
 sky130_fd_sc_hd__and2_1 _472_ (.A(net106),
    .B(_339_),
    .X(_049_));
 sky130_fd_sc_hd__and2_1 _473_ (.A(net72),
    .B(net101),
    .X(_050_));
 sky130_fd_sc_hd__a31o_1 _474_ (.A1(net70),
    .A2(net79),
    .A3(_050_),
    .B1(_035_),
    .X(_051_));
 sky130_fd_sc_hd__a21o_1 _475_ (.A1(_049_),
    .A2(_051_),
    .B1(_048_),
    .X(_052_));
 sky130_fd_sc_hd__a31o_1 _476_ (.A1(_370_),
    .A2(_027_),
    .A3(_028_),
    .B1(_052_),
    .X(net45));
 sky130_fd_sc_hd__and2b_1 _477_ (.A_N(_365_),
    .B(net57),
    .X(_053_));
 sky130_fd_sc_hd__xnor2_1 _478_ (.A(net67),
    .B(_053_),
    .Y(_054_));
 sky130_fd_sc_hd__and2_1 _479_ (.A(net14),
    .B(_054_),
    .X(_055_));
 sky130_fd_sc_hd__a21o_1 _480_ (.A1(_022_),
    .A2(_026_),
    .B1(_025_),
    .X(_056_));
 sky130_fd_sc_hd__nor2_1 _481_ (.A(net14),
    .B(_054_),
    .Y(_057_));
 sky130_fd_sc_hd__or2_1 _482_ (.A(_055_),
    .B(_057_),
    .X(_058_));
 sky130_fd_sc_hd__xnor2_1 _483_ (.A(_056_),
    .B(_058_),
    .Y(_059_));
 sky130_fd_sc_hd__mux4_1 _484_ (.A0(net65),
    .A1(net62),
    .A2(net60),
    .A3(net103),
    .S0(net86),
    .S1(net80),
    .X(_060_));
 sky130_fd_sc_hd__and2b_1 _485_ (.A_N(net72),
    .B(_060_),
    .X(_061_));
 sky130_fd_sc_hd__a31o_1 _486_ (.A1(net72),
    .A2(net101),
    .A3(_364_),
    .B1(_061_),
    .X(_062_));
 sky130_fd_sc_hd__or2_1 _487_ (.A(_050_),
    .B(_061_),
    .X(_063_));
 sky130_fd_sc_hd__a22o_1 _488_ (.A1(_036_),
    .A2(_062_),
    .B1(_063_),
    .B2(_049_),
    .X(_064_));
 sky130_fd_sc_hd__mux4_1 _489_ (.A0(net97),
    .A1(net98),
    .A2(net100),
    .A3(net5),
    .S0(net81),
    .S1(net75),
    .X(_065_));
 sky130_fd_sc_hd__and2b_1 _490_ (.A_N(net71),
    .B(_065_),
    .X(_066_));
 sky130_fd_sc_hd__or3b_1 _491_ (.A(net104),
    .B(_332_),
    .C_N(net97),
    .X(_067_));
 sky130_fd_sc_hd__o211a_1 _492_ (.A1(net67),
    .A2(net14),
    .B1(net54),
    .C1(_067_),
    .X(_068_));
 sky130_fd_sc_hd__a21oi_1 _493_ (.A1(net100),
    .A2(net98),
    .B1(net97),
    .Y(_069_));
 sky130_fd_sc_hd__and3_1 _494_ (.A(net100),
    .B(net98),
    .C(net97),
    .X(_070_));
 sky130_fd_sc_hd__or3_1 _495_ (.A(_367_),
    .B(_069_),
    .C(_070_),
    .X(_071_));
 sky130_fd_sc_hd__o21ai_1 _496_ (.A1(_360_),
    .A2(_067_),
    .B1(_071_),
    .Y(_072_));
 sky130_fd_sc_hd__a211o_1 _497_ (.A1(_363_),
    .A2(_066_),
    .B1(_068_),
    .C1(_072_),
    .X(_073_));
 sky130_fd_sc_hd__mux4_1 _498_ (.A0(net91),
    .A1(net89),
    .A2(net87),
    .A3(net66),
    .S0(net83),
    .S1(net77),
    .X(_074_));
 sky130_fd_sc_hd__mux4_1 _499_ (.A0(net97),
    .A1(net96),
    .A2(net95),
    .A3(net93),
    .S0(net81),
    .S1(net75),
    .X(_075_));
 sky130_fd_sc_hd__a22o_1 _500_ (.A1(_348_),
    .A2(_074_),
    .B1(_075_),
    .B2(_345_),
    .X(_076_));
 sky130_fd_sc_hd__a221o_1 _501_ (.A1(net67),
    .A2(_064_),
    .B1(_076_),
    .B2(_339_),
    .C1(_073_),
    .X(_077_));
 sky130_fd_sc_hd__a21o_1 _502_ (.A1(_370_),
    .A2(_059_),
    .B1(_077_),
    .X(net46));
 sky130_fd_sc_hd__or4_4 _503_ (.A(net68),
    .B(net74),
    .C(net83),
    .D(net77),
    .X(_078_));
 sky130_fd_sc_hd__inv_2 _504_ (.A(_078_),
    .Y(_079_));
 sky130_fd_sc_hd__nand2_1 _505_ (.A(net57),
    .B(_078_),
    .Y(_080_));
 sky130_fd_sc_hd__xor2_1 _506_ (.A(net31),
    .B(_080_),
    .X(_081_));
 sky130_fd_sc_hd__nand2_1 _507_ (.A(net96),
    .B(_081_),
    .Y(_082_));
 sky130_fd_sc_hd__xnor2_1 _508_ (.A(net96),
    .B(_081_),
    .Y(_083_));
 sky130_fd_sc_hd__a211oi_2 _509_ (.A1(_022_),
    .A2(_026_),
    .B1(_055_),
    .C1(_025_),
    .Y(_084_));
 sky130_fd_sc_hd__or3_2 _510_ (.A(_057_),
    .B(_083_),
    .C(_084_),
    .X(_085_));
 sky130_fd_sc_hd__o21ai_1 _511_ (.A1(_057_),
    .A2(_084_),
    .B1(_083_),
    .Y(_086_));
 sky130_fd_sc_hd__mux4_1 _512_ (.A0(net15),
    .A1(net14),
    .A2(net98),
    .A3(net100),
    .S0(net82),
    .S1(net76),
    .X(_087_));
 sky130_fd_sc_hd__a21bo_1 _513_ (.A1(net5),
    .A2(_364_),
    .B1_N(net74),
    .X(_088_));
 sky130_fd_sc_hd__o211ai_1 _514_ (.A1(net74),
    .A2(_087_),
    .B1(_088_),
    .C1(_361_),
    .Y(_089_));
 sky130_fd_sc_hd__o22a_1 _515_ (.A1(_341_),
    .A2(_349_),
    .B1(_350_),
    .B2(_346_),
    .X(_090_));
 sky130_fd_sc_hd__nand2_1 _516_ (.A(_339_),
    .B(_090_),
    .Y(_091_));
 sky130_fd_sc_hd__mux2_1 _517_ (.A0(_343_),
    .A1(net101),
    .S(net72),
    .X(_092_));
 sky130_fd_sc_hd__nand2_1 _518_ (.A(_049_),
    .B(_092_),
    .Y(_093_));
 sky130_fd_sc_hd__or3b_1 _519_ (.A(net72),
    .B(_037_),
    .C_N(_343_),
    .X(_094_));
 sky130_fd_sc_hd__a32o_1 _520_ (.A1(net68),
    .A2(_093_),
    .A3(_094_),
    .B1(_089_),
    .B2(_091_),
    .X(_095_));
 sky130_fd_sc_hd__and3b_1 _521_ (.A_N(net104),
    .B(net96),
    .C(net31),
    .X(_096_));
 sky130_fd_sc_hd__o21ai_1 _522_ (.A1(net96),
    .A2(net31),
    .B1(net54),
    .Y(_097_));
 sky130_fd_sc_hd__mux2_1 _523_ (.A0(_097_),
    .A1(_360_),
    .S(_096_),
    .X(_098_));
 sky130_fd_sc_hd__and2_1 _524_ (.A(net96),
    .B(_070_),
    .X(_099_));
 sky130_fd_sc_hd__o21ai_1 _525_ (.A1(net96),
    .A2(_070_),
    .B1(_366_),
    .Y(_100_));
 sky130_fd_sc_hd__o211ai_1 _526_ (.A1(_099_),
    .A2(_100_),
    .B1(_095_),
    .C1(_098_),
    .Y(_101_));
 sky130_fd_sc_hd__a31o_1 _527_ (.A1(_370_),
    .A2(_085_),
    .A3(_086_),
    .B1(_101_),
    .X(net47));
 sky130_fd_sc_hd__o21a_1 _528_ (.A1(net31),
    .A2(_078_),
    .B1(net57),
    .X(_102_));
 sky130_fd_sc_hd__xnor2_1 _529_ (.A(net32),
    .B(_102_),
    .Y(_103_));
 sky130_fd_sc_hd__nand2_1 _530_ (.A(net94),
    .B(_103_),
    .Y(_104_));
 sky130_fd_sc_hd__nor2_1 _531_ (.A(net94),
    .B(_103_),
    .Y(_105_));
 sky130_fd_sc_hd__inv_2 _532_ (.A(_105_),
    .Y(_106_));
 sky130_fd_sc_hd__nand2_1 _533_ (.A(_104_),
    .B(_106_),
    .Y(_107_));
 sky130_fd_sc_hd__nand3_1 _534_ (.A(_082_),
    .B(_085_),
    .C(_107_),
    .Y(_108_));
 sky130_fd_sc_hd__a21o_1 _535_ (.A1(_082_),
    .A2(_085_),
    .B1(_107_),
    .X(_109_));
 sky130_fd_sc_hd__mux4_1 _536_ (.A0(net95),
    .A1(net96),
    .A2(net97),
    .A3(net98),
    .S0(net81),
    .S1(net75),
    .X(_110_));
 sky130_fd_sc_hd__inv_2 _537_ (.A(_110_),
    .Y(_111_));
 sky130_fd_sc_hd__o21ai_1 _538_ (.A1(net75),
    .A2(_003_),
    .B1(net71),
    .Y(_112_));
 sky130_fd_sc_hd__o211ai_2 _539_ (.A1(net71),
    .A2(_110_),
    .B1(_112_),
    .C1(_361_),
    .Y(_113_));
 sky130_fd_sc_hd__o22a_1 _540_ (.A1(_349_),
    .A2(_010_),
    .B1(_017_),
    .B2(_346_),
    .X(_114_));
 sky130_fd_sc_hd__nand2_1 _541_ (.A(_339_),
    .B(_114_),
    .Y(_115_));
 sky130_fd_sc_hd__and2b_1 _542_ (.A_N(net72),
    .B(_015_),
    .X(_116_));
 sky130_fd_sc_hd__inv_2 _543_ (.A(_116_),
    .Y(_117_));
 sky130_fd_sc_hd__o21ai_1 _544_ (.A1(_050_),
    .A2(_116_),
    .B1(_049_),
    .Y(_118_));
 sky130_fd_sc_hd__a211o_1 _545_ (.A1(net86),
    .A2(_012_),
    .B1(_037_),
    .C1(_117_),
    .X(_119_));
 sky130_fd_sc_hd__a32o_1 _546_ (.A1(net68),
    .A2(_118_),
    .A3(_119_),
    .B1(_113_),
    .B2(_115_),
    .X(_120_));
 sky130_fd_sc_hd__nand3b_1 _547_ (.A_N(net104),
    .B(net94),
    .C(net32),
    .Y(_121_));
 sky130_fd_sc_hd__o211a_1 _548_ (.A1(net94),
    .A2(net32),
    .B1(net54),
    .C1(_121_),
    .X(_122_));
 sky130_fd_sc_hd__nand2_1 _549_ (.A(net94),
    .B(_099_),
    .Y(_123_));
 sky130_fd_sc_hd__o211a_1 _550_ (.A1(net94),
    .A2(_099_),
    .B1(_123_),
    .C1(_366_),
    .X(_124_));
 sky130_fd_sc_hd__a311o_1 _551_ (.A1(net94),
    .A2(net32),
    .A3(_368_),
    .B1(_122_),
    .C1(_124_),
    .X(_125_));
 sky130_fd_sc_hd__nand2b_1 _552_ (.A_N(_125_),
    .B(_120_),
    .Y(_126_));
 sky130_fd_sc_hd__a31o_1 _553_ (.A1(_370_),
    .A2(_108_),
    .A3(_109_),
    .B1(_126_),
    .X(net48));
 sky130_fd_sc_hd__o31a_1 _554_ (.A1(net31),
    .A2(net32),
    .A3(_078_),
    .B1(net56),
    .X(_127_));
 sky130_fd_sc_hd__xnor2_1 _555_ (.A(net33),
    .B(_127_),
    .Y(_128_));
 sky130_fd_sc_hd__nand2_1 _556_ (.A(net92),
    .B(_128_),
    .Y(_129_));
 sky130_fd_sc_hd__xnor2_1 _557_ (.A(net92),
    .B(_128_),
    .Y(_130_));
 sky130_fd_sc_hd__o21a_1 _558_ (.A1(_082_),
    .A2(_105_),
    .B1(_104_),
    .X(_131_));
 sky130_fd_sc_hd__a311o_1 _559_ (.A1(_082_),
    .A2(_085_),
    .A3(_104_),
    .B1(_105_),
    .C1(_130_),
    .X(_132_));
 sky130_fd_sc_hd__o211a_1 _560_ (.A1(_085_),
    .A2(_105_),
    .B1(_130_),
    .C1(_131_),
    .X(_133_));
 sky130_fd_sc_hd__nand2_1 _561_ (.A(_370_),
    .B(_132_),
    .Y(_134_));
 sky130_fd_sc_hd__mux4_1 _562_ (.A0(net93),
    .A1(net94),
    .A2(net15),
    .A3(net97),
    .S0(net81),
    .S1(net75),
    .X(_135_));
 sky130_fd_sc_hd__nand2_1 _563_ (.A(net73),
    .B(_040_),
    .Y(_136_));
 sky130_fd_sc_hd__o211a_1 _564_ (.A1(net73),
    .A2(_135_),
    .B1(_136_),
    .C1(_361_),
    .X(_137_));
 sky130_fd_sc_hd__o22a_1 _565_ (.A1(_349_),
    .A2(_030_),
    .B1(_033_),
    .B2(_346_),
    .X(_138_));
 sky130_fd_sc_hd__a21oi_1 _566_ (.A1(_339_),
    .A2(_138_),
    .B1(_137_),
    .Y(_139_));
 sky130_fd_sc_hd__or3b_1 _567_ (.A(net72),
    .B(net80),
    .C_N(_342_),
    .X(_140_));
 sky130_fd_sc_hd__o21ai_1 _568_ (.A1(net73),
    .A2(net80),
    .B1(net102),
    .Y(_141_));
 sky130_fd_sc_hd__a21bo_1 _569_ (.A1(_140_),
    .A2(_141_),
    .B1_N(_049_),
    .X(_142_));
 sky130_fd_sc_hd__or2_1 _570_ (.A(_037_),
    .B(_140_),
    .X(_143_));
 sky130_fd_sc_hd__a31o_1 _571_ (.A1(net68),
    .A2(_142_),
    .A3(_143_),
    .B1(_139_),
    .X(_144_));
 sky130_fd_sc_hd__and3b_1 _572_ (.A_N(net105),
    .B(net92),
    .C(net33),
    .X(_145_));
 sky130_fd_sc_hd__o21ai_1 _573_ (.A1(net92),
    .A2(net33),
    .B1(net54),
    .Y(_146_));
 sky130_fd_sc_hd__mux2_1 _574_ (.A0(_146_),
    .A1(_360_),
    .S(_145_),
    .X(_147_));
 sky130_fd_sc_hd__a21oi_1 _575_ (.A1(net94),
    .A2(_099_),
    .B1(net92),
    .Y(_148_));
 sky130_fd_sc_hd__and3_1 _576_ (.A(net94),
    .B(net92),
    .C(_099_),
    .X(_149_));
 sky130_fd_sc_hd__o311a_1 _577_ (.A1(_367_),
    .A2(_148_),
    .A3(_149_),
    .B1(_144_),
    .C1(_147_),
    .X(_150_));
 sky130_fd_sc_hd__o21ai_1 _578_ (.A1(_133_),
    .A2(_134_),
    .B1(_150_),
    .Y(net49));
 sky130_fd_sc_hd__o41a_1 _579_ (.A1(net31),
    .A2(net32),
    .A3(net33),
    .A4(_078_),
    .B1(net56),
    .X(_151_));
 sky130_fd_sc_hd__xnor2_1 _580_ (.A(net34),
    .B(_151_),
    .Y(_152_));
 sky130_fd_sc_hd__xnor2_1 _581_ (.A(net90),
    .B(_152_),
    .Y(_153_));
 sky130_fd_sc_hd__nand3_1 _582_ (.A(_129_),
    .B(_132_),
    .C(_153_),
    .Y(_154_));
 sky130_fd_sc_hd__a21o_1 _583_ (.A1(_129_),
    .A2(_132_),
    .B1(_153_),
    .X(_155_));
 sky130_fd_sc_hd__and4b_1 _584_ (.A_N(net106),
    .B(net70),
    .C(net101),
    .D(net59),
    .X(_156_));
 sky130_fd_sc_hd__a221o_1 _585_ (.A1(_348_),
    .A2(_060_),
    .B1(_074_),
    .B2(_345_),
    .C1(_156_),
    .X(_157_));
 sky130_fd_sc_hd__and4_1 _586_ (.A(net95),
    .B(net92),
    .C(net90),
    .D(_099_),
    .X(_158_));
 sky130_fd_sc_hd__nor2_1 _587_ (.A(net90),
    .B(_149_),
    .Y(_159_));
 sky130_fd_sc_hd__nand3b_1 _588_ (.A_N(net105),
    .B(net90),
    .C(net34),
    .Y(_160_));
 sky130_fd_sc_hd__o211a_1 _589_ (.A1(net90),
    .A2(net34),
    .B1(net55),
    .C1(_160_),
    .X(_161_));
 sky130_fd_sc_hd__and3_2 _590_ (.A(net68),
    .B(net102),
    .C(_049_),
    .X(_162_));
 sky130_fd_sc_hd__a311o_1 _591_ (.A1(net90),
    .A2(net34),
    .A3(_368_),
    .B1(_161_),
    .C1(_162_),
    .X(_163_));
 sky130_fd_sc_hd__mux4_1 _592_ (.A0(net91),
    .A1(net93),
    .A2(net95),
    .A3(net15),
    .S0(net81),
    .S1(net75),
    .X(_164_));
 sky130_fd_sc_hd__mux2_1 _593_ (.A0(_164_),
    .A1(_065_),
    .S(net74),
    .X(_165_));
 sky130_fd_sc_hd__a21oi_1 _594_ (.A1(_363_),
    .A2(_165_),
    .B1(_163_),
    .Y(_166_));
 sky130_fd_sc_hd__o31a_1 _595_ (.A1(_367_),
    .A2(_158_),
    .A3(_159_),
    .B1(_166_),
    .X(_167_));
 sky130_fd_sc_hd__a21bo_1 _596_ (.A1(_339_),
    .A2(_157_),
    .B1_N(_167_),
    .X(_168_));
 sky130_fd_sc_hd__a31o_1 _597_ (.A1(_370_),
    .A2(_154_),
    .A3(_155_),
    .B1(_168_),
    .X(net50));
 sky130_fd_sc_hd__or2_1 _598_ (.A(_130_),
    .B(_153_),
    .X(_169_));
 sky130_fd_sc_hd__or3b_1 _599_ (.A(_105_),
    .B(_083_),
    .C_N(_104_),
    .X(_170_));
 sky130_fd_sc_hd__or4_2 _600_ (.A(_057_),
    .B(_084_),
    .C(_169_),
    .D(_170_),
    .X(_171_));
 sky130_fd_sc_hd__a22o_1 _601_ (.A1(net92),
    .A2(_128_),
    .B1(_152_),
    .B2(net90),
    .X(_172_));
 sky130_fd_sc_hd__o21ai_1 _602_ (.A1(net90),
    .A2(_152_),
    .B1(_172_),
    .Y(_173_));
 sky130_fd_sc_hd__o21a_1 _603_ (.A1(_131_),
    .A2(_169_),
    .B1(_173_),
    .X(_174_));
 sky130_fd_sc_hd__or2_1 _604_ (.A(net33),
    .B(net34),
    .X(_175_));
 sky130_fd_sc_hd__or4_2 _605_ (.A(net31),
    .B(net32),
    .C(_078_),
    .D(_175_),
    .X(_176_));
 sky130_fd_sc_hd__nand2_1 _606_ (.A(net56),
    .B(_176_),
    .Y(_177_));
 sky130_fd_sc_hd__xnor2_1 _607_ (.A(net35),
    .B(_177_),
    .Y(_178_));
 sky130_fd_sc_hd__or2_1 _608_ (.A(_334_),
    .B(_178_),
    .X(_179_));
 sky130_fd_sc_hd__xnor2_1 _609_ (.A(_334_),
    .B(_178_),
    .Y(_180_));
 sky130_fd_sc_hd__a21o_1 _610_ (.A1(_171_),
    .A2(_174_),
    .B1(_180_),
    .X(_181_));
 sky130_fd_sc_hd__a31oi_1 _611_ (.A1(_171_),
    .A2(_174_),
    .A3(_180_),
    .B1(_371_),
    .Y(_182_));
 sky130_fd_sc_hd__mux4_1 _612_ (.A0(net89),
    .A1(net91),
    .A2(net93),
    .A3(net95),
    .S0(net83),
    .S1(net77),
    .X(_183_));
 sky130_fd_sc_hd__a22o_1 _613_ (.A1(_348_),
    .A2(_087_),
    .B1(_183_),
    .B2(_345_),
    .X(_184_));
 sky130_fd_sc_hd__a31o_1 _614_ (.A1(net5),
    .A2(net67),
    .A3(net59),
    .B1(_184_),
    .X(_185_));
 sky130_fd_sc_hd__nor2_1 _615_ (.A(net68),
    .B(_340_),
    .Y(_186_));
 sky130_fd_sc_hd__or3b_1 _616_ (.A(net105),
    .B(_334_),
    .C_N(net35),
    .X(_187_));
 sky130_fd_sc_hd__o211a_1 _617_ (.A1(net89),
    .A2(net35),
    .B1(net55),
    .C1(_187_),
    .X(_188_));
 sky130_fd_sc_hd__nor2_1 _618_ (.A(_360_),
    .B(_187_),
    .Y(_189_));
 sky130_fd_sc_hd__a22o_1 _619_ (.A1(_361_),
    .A2(_185_),
    .B1(_186_),
    .B2(_344_),
    .X(_190_));
 sky130_fd_sc_hd__or4_1 _620_ (.A(_162_),
    .B(_188_),
    .C(_189_),
    .D(_190_),
    .X(_191_));
 sky130_fd_sc_hd__nand2_1 _621_ (.A(net89),
    .B(_158_),
    .Y(_192_));
 sky130_fd_sc_hd__o211a_1 _622_ (.A1(net89),
    .A2(_158_),
    .B1(_192_),
    .C1(net58),
    .X(_193_));
 sky130_fd_sc_hd__a211o_1 _623_ (.A1(_181_),
    .A2(_182_),
    .B1(_191_),
    .C1(_193_),
    .X(net51));
 sky130_fd_sc_hd__o21ai_1 _624_ (.A1(net35),
    .A2(_176_),
    .B1(net56),
    .Y(_194_));
 sky130_fd_sc_hd__xnor2_1 _625_ (.A(net36),
    .B(_194_),
    .Y(_195_));
 sky130_fd_sc_hd__xnor2_1 _626_ (.A(_335_),
    .B(_195_),
    .Y(_196_));
 sky130_fd_sc_hd__and3_1 _627_ (.A(_179_),
    .B(_181_),
    .C(_196_),
    .X(_197_));
 sky130_fd_sc_hd__a21oi_1 _628_ (.A1(_179_),
    .A2(_181_),
    .B1(_196_),
    .Y(_198_));
 sky130_fd_sc_hd__and2_1 _629_ (.A(_335_),
    .B(_192_),
    .X(_199_));
 sky130_fd_sc_hd__and3_1 _630_ (.A(net89),
    .B(net87),
    .C(_158_),
    .X(_200_));
 sky130_fd_sc_hd__or3b_1 _631_ (.A(net105),
    .B(_335_),
    .C_N(net36),
    .X(_201_));
 sky130_fd_sc_hd__o211a_1 _632_ (.A1(net87),
    .A2(net36),
    .B1(net55),
    .C1(_201_),
    .X(_202_));
 sky130_fd_sc_hd__a311o_1 _633_ (.A1(net87),
    .A2(net36),
    .A3(_368_),
    .B1(_162_),
    .C1(_202_),
    .X(_203_));
 sky130_fd_sc_hd__mux4_1 _634_ (.A0(net87),
    .A1(net19),
    .A2(net91),
    .A3(net93),
    .S0(net83),
    .S1(net77),
    .X(_204_));
 sky130_fd_sc_hd__a221o_1 _635_ (.A1(net67),
    .A2(_004_),
    .B1(_111_),
    .B2(net71),
    .C1(_362_),
    .X(_205_));
 sky130_fd_sc_hd__o21ba_1 _636_ (.A1(_346_),
    .A2(_204_),
    .B1_N(_205_),
    .X(_206_));
 sky130_fd_sc_hd__a211oi_1 _637_ (.A1(_016_),
    .A2(_186_),
    .B1(_203_),
    .C1(_206_),
    .Y(_207_));
 sky130_fd_sc_hd__o31a_1 _638_ (.A1(_367_),
    .A2(_199_),
    .A3(_200_),
    .B1(_207_),
    .X(_208_));
 sky130_fd_sc_hd__o31ai_1 _639_ (.A1(_371_),
    .A2(_197_),
    .A3(_198_),
    .B1(_208_),
    .Y(net52));
 sky130_fd_sc_hd__o31a_1 _640_ (.A1(net35),
    .A2(net36),
    .A3(_176_),
    .B1(net56),
    .X(_209_));
 sky130_fd_sc_hd__xor2_1 _641_ (.A(net22),
    .B(_209_),
    .X(_210_));
 sky130_fd_sc_hd__nor2_1 _642_ (.A(_336_),
    .B(_210_),
    .Y(_211_));
 sky130_fd_sc_hd__xnor2_1 _643_ (.A(_336_),
    .B(_210_),
    .Y(_212_));
 sky130_fd_sc_hd__or2_1 _644_ (.A(_180_),
    .B(_196_),
    .X(_213_));
 sky130_fd_sc_hd__a21o_1 _645_ (.A1(_171_),
    .A2(_174_),
    .B1(_213_),
    .X(_214_));
 sky130_fd_sc_hd__o22a_1 _646_ (.A1(_334_),
    .A2(_178_),
    .B1(_195_),
    .B2(_335_),
    .X(_215_));
 sky130_fd_sc_hd__a21o_1 _647_ (.A1(_335_),
    .A2(_195_),
    .B1(_215_),
    .X(_216_));
 sky130_fd_sc_hd__and3_1 _648_ (.A(_212_),
    .B(_214_),
    .C(_216_),
    .X(_217_));
 sky130_fd_sc_hd__a21oi_1 _649_ (.A1(_214_),
    .A2(_216_),
    .B1(_212_),
    .Y(_218_));
 sky130_fd_sc_hd__a31o_1 _650_ (.A1(net105),
    .A2(net80),
    .A3(_050_),
    .B1(_031_),
    .X(_219_));
 sky130_fd_sc_hd__a211o_1 _651_ (.A1(_332_),
    .A2(_135_),
    .B1(_041_),
    .C1(_345_),
    .X(_220_));
 sky130_fd_sc_hd__mux4_1 _652_ (.A0(net66),
    .A1(net87),
    .A2(net19),
    .A3(net91),
    .S0(net83),
    .S1(net77),
    .X(_221_));
 sky130_fd_sc_hd__o211ai_1 _653_ (.A1(_346_),
    .A2(_221_),
    .B1(_220_),
    .C1(_361_),
    .Y(_222_));
 sky130_fd_sc_hd__or3b_1 _654_ (.A(net105),
    .B(_336_),
    .C_N(net22),
    .X(_223_));
 sky130_fd_sc_hd__o211a_1 _655_ (.A1(net66),
    .A2(net22),
    .B1(net55),
    .C1(_223_),
    .X(_224_));
 sky130_fd_sc_hd__a311o_1 _656_ (.A1(net6),
    .A2(net22),
    .A3(_368_),
    .B1(_162_),
    .C1(_224_),
    .X(_225_));
 sky130_fd_sc_hd__a21oi_1 _657_ (.A1(_186_),
    .A2(_219_),
    .B1(_225_),
    .Y(_226_));
 sky130_fd_sc_hd__and2_1 _658_ (.A(net6),
    .B(_200_),
    .X(_227_));
 sky130_fd_sc_hd__nor2_1 _659_ (.A(net6),
    .B(_200_),
    .Y(_228_));
 sky130_fd_sc_hd__or3_1 _660_ (.A(_367_),
    .B(_227_),
    .C(_228_),
    .X(_229_));
 sky130_fd_sc_hd__and3_1 _661_ (.A(_222_),
    .B(_226_),
    .C(_229_),
    .X(_230_));
 sky130_fd_sc_hd__o31ai_1 _662_ (.A1(_371_),
    .A2(_217_),
    .A3(_218_),
    .B1(_230_),
    .Y(net38));
 sky130_fd_sc_hd__o41a_1 _663_ (.A1(net35),
    .A2(net36),
    .A3(net22),
    .A4(_176_),
    .B1(net56),
    .X(_231_));
 sky130_fd_sc_hd__xor2_1 _664_ (.A(net23),
    .B(_231_),
    .X(_232_));
 sky130_fd_sc_hd__xnor2_1 _665_ (.A(net64),
    .B(_232_),
    .Y(_233_));
 sky130_fd_sc_hd__o21ai_1 _666_ (.A1(_211_),
    .A2(_218_),
    .B1(_233_),
    .Y(_234_));
 sky130_fd_sc_hd__or3_1 _667_ (.A(_211_),
    .B(_218_),
    .C(_233_),
    .X(_235_));
 sky130_fd_sc_hd__nand2_1 _668_ (.A(net64),
    .B(_227_),
    .Y(_236_));
 sky130_fd_sc_hd__o211a_1 _669_ (.A1(net64),
    .A2(_227_),
    .B1(_236_),
    .C1(net58),
    .X(_237_));
 sky130_fd_sc_hd__a211o_1 _670_ (.A1(_332_),
    .A2(_164_),
    .B1(_066_),
    .C1(_345_),
    .X(_238_));
 sky130_fd_sc_hd__mux4_1 _671_ (.A0(net64),
    .A1(net66),
    .A2(net20),
    .A3(net19),
    .S0(net83),
    .S1(net77),
    .X(_239_));
 sky130_fd_sc_hd__o211a_1 _672_ (.A1(_346_),
    .A2(_239_),
    .B1(_238_),
    .C1(_361_),
    .X(_240_));
 sky130_fd_sc_hd__or3b_1 _673_ (.A(net105),
    .B(_337_),
    .C_N(net23),
    .X(_241_));
 sky130_fd_sc_hd__o211a_1 _674_ (.A1(net64),
    .A2(net23),
    .B1(net55),
    .C1(_241_),
    .X(_242_));
 sky130_fd_sc_hd__nor2_1 _675_ (.A(_360_),
    .B(_241_),
    .Y(_243_));
 sky130_fd_sc_hd__or4_1 _676_ (.A(_162_),
    .B(_240_),
    .C(_242_),
    .D(_243_),
    .X(_244_));
 sky130_fd_sc_hd__a211o_1 _677_ (.A1(_332_),
    .A2(_064_),
    .B1(_237_),
    .C1(_244_),
    .X(_245_));
 sky130_fd_sc_hd__a31o_1 _678_ (.A1(_370_),
    .A2(_234_),
    .A3(_235_),
    .B1(_245_),
    .X(net39));
 sky130_fd_sc_hd__nand2b_1 _679_ (.A_N(_212_),
    .B(_233_),
    .Y(_246_));
 sky130_fd_sc_hd__a211o_1 _680_ (.A1(_171_),
    .A2(_174_),
    .B1(_213_),
    .C1(_246_),
    .X(_247_));
 sky130_fd_sc_hd__a211o_1 _681_ (.A1(_337_),
    .A2(_232_),
    .B1(_210_),
    .C1(_336_),
    .X(_248_));
 sky130_fd_sc_hd__o221a_1 _682_ (.A1(_337_),
    .A2(_232_),
    .B1(_246_),
    .B2(_216_),
    .C1(_248_),
    .X(_249_));
 sky130_fd_sc_hd__a21o_1 _683_ (.A1(net23),
    .A2(net56),
    .B1(_231_),
    .X(_250_));
 sky130_fd_sc_hd__a211o_1 _684_ (.A1(net23),
    .A2(net56),
    .B1(_231_),
    .C1(net24),
    .X(_251_));
 sky130_fd_sc_hd__xnor2_1 _685_ (.A(net24),
    .B(_250_),
    .Y(_252_));
 sky130_fd_sc_hd__nand2_1 _686_ (.A(net62),
    .B(_252_),
    .Y(_253_));
 sky130_fd_sc_hd__or2_1 _687_ (.A(net62),
    .B(_252_),
    .X(_254_));
 sky130_fd_sc_hd__nand2_1 _688_ (.A(_253_),
    .B(_254_),
    .Y(_255_));
 sky130_fd_sc_hd__a21o_1 _689_ (.A1(_247_),
    .A2(_249_),
    .B1(_255_),
    .X(_256_));
 sky130_fd_sc_hd__and3_1 _690_ (.A(_247_),
    .B(_249_),
    .C(_255_),
    .X(_257_));
 sky130_fd_sc_hd__or3b_1 _691_ (.A(_257_),
    .B(_371_),
    .C_N(_256_),
    .X(_258_));
 sky130_fd_sc_hd__mux4_1 _692_ (.A0(net62),
    .A1(net64),
    .A2(net66),
    .A3(net20),
    .S0(net83),
    .S1(net77),
    .X(_259_));
 sky130_fd_sc_hd__o22a_1 _693_ (.A1(_349_),
    .A2(_183_),
    .B1(_259_),
    .B2(_346_),
    .X(_260_));
 sky130_fd_sc_hd__nand2_1 _694_ (.A(_361_),
    .B(_260_),
    .Y(_261_));
 sky130_fd_sc_hd__a22o_1 _695_ (.A1(net68),
    .A2(_089_),
    .B1(_094_),
    .B2(_261_),
    .X(_262_));
 sky130_fd_sc_hd__or2_1 _696_ (.A(net68),
    .B(_093_),
    .X(_263_));
 sky130_fd_sc_hd__nand3b_1 _697_ (.A_N(net106),
    .B(net63),
    .C(net24),
    .Y(_264_));
 sky130_fd_sc_hd__o211a_1 _698_ (.A1(net63),
    .A2(net24),
    .B1(net54),
    .C1(_264_),
    .X(_265_));
 sky130_fd_sc_hd__a311o_1 _699_ (.A1(net63),
    .A2(net24),
    .A3(_368_),
    .B1(_162_),
    .C1(_265_),
    .X(_266_));
 sky130_fd_sc_hd__a31o_1 _700_ (.A1(net6),
    .A2(net65),
    .A3(_200_),
    .B1(net63),
    .X(_267_));
 sky130_fd_sc_hd__and3_1 _701_ (.A(net64),
    .B(net63),
    .C(_227_),
    .X(_268_));
 sky130_fd_sc_hd__and3b_1 _702_ (.A_N(_268_),
    .B(net58),
    .C(_267_),
    .X(_269_));
 sky130_fd_sc_hd__and4bb_1 _703_ (.A_N(_266_),
    .B_N(_269_),
    .C(_262_),
    .D(_263_),
    .X(_270_));
 sky130_fd_sc_hd__nand2_1 _704_ (.A(_258_),
    .B(_270_),
    .Y(net40));
 sky130_fd_sc_hd__nand2_1 _705_ (.A(net56),
    .B(_251_),
    .Y(_271_));
 sky130_fd_sc_hd__xor2_1 _706_ (.A(net25),
    .B(_271_),
    .X(_272_));
 sky130_fd_sc_hd__and2_1 _707_ (.A(net60),
    .B(_272_),
    .X(_273_));
 sky130_fd_sc_hd__nor2_1 _708_ (.A(net60),
    .B(_272_),
    .Y(_274_));
 sky130_fd_sc_hd__or2_1 _709_ (.A(_273_),
    .B(_274_),
    .X(_275_));
 sky130_fd_sc_hd__a21oi_1 _710_ (.A1(_253_),
    .A2(_256_),
    .B1(_275_),
    .Y(_276_));
 sky130_fd_sc_hd__a31o_1 _711_ (.A1(_253_),
    .A2(_256_),
    .A3(_275_),
    .B1(_371_),
    .X(_277_));
 sky130_fd_sc_hd__and2_1 _712_ (.A(net60),
    .B(_268_),
    .X(_278_));
 sky130_fd_sc_hd__o21ai_1 _713_ (.A1(net60),
    .A2(_268_),
    .B1(net58),
    .Y(_279_));
 sky130_fd_sc_hd__mux4_1 _714_ (.A0(net60),
    .A1(net62),
    .A2(net65),
    .A3(net66),
    .S0(net84),
    .S1(net78),
    .X(_280_));
 sky130_fd_sc_hd__o22a_1 _715_ (.A1(_349_),
    .A2(_204_),
    .B1(_280_),
    .B2(_346_),
    .X(_281_));
 sky130_fd_sc_hd__nand2_1 _716_ (.A(_361_),
    .B(_281_),
    .Y(_282_));
 sky130_fd_sc_hd__a22o_1 _717_ (.A1(net69),
    .A2(_113_),
    .B1(_119_),
    .B2(_282_),
    .X(_283_));
 sky130_fd_sc_hd__nand3b_1 _718_ (.A_N(net106),
    .B(net61),
    .C(net25),
    .Y(_284_));
 sky130_fd_sc_hd__o211a_1 _719_ (.A1(net61),
    .A2(net25),
    .B1(net54),
    .C1(_284_),
    .X(_285_));
 sky130_fd_sc_hd__a311o_1 _720_ (.A1(net61),
    .A2(net25),
    .A3(_368_),
    .B1(_162_),
    .C1(_285_),
    .X(_286_));
 sky130_fd_sc_hd__o21ba_1 _721_ (.A1(net69),
    .A2(_118_),
    .B1_N(_286_),
    .X(_287_));
 sky130_fd_sc_hd__o211a_1 _722_ (.A1(_278_),
    .A2(_279_),
    .B1(_283_),
    .C1(_287_),
    .X(_288_));
 sky130_fd_sc_hd__o21ai_1 _723_ (.A1(_276_),
    .A2(_277_),
    .B1(_288_),
    .Y(net41));
 sky130_fd_sc_hd__o21a_1 _724_ (.A1(net25),
    .A2(_251_),
    .B1(net56),
    .X(_289_));
 sky130_fd_sc_hd__xor2_1 _725_ (.A(net26),
    .B(_289_),
    .X(_290_));
 sky130_fd_sc_hd__nand2_1 _726_ (.A(_338_),
    .B(_290_),
    .Y(_291_));
 sky130_fd_sc_hd__or2_1 _727_ (.A(_338_),
    .B(_290_),
    .X(_292_));
 sky130_fd_sc_hd__nand2_1 _728_ (.A(_291_),
    .B(_292_),
    .Y(_293_));
 sky130_fd_sc_hd__a21boi_1 _729_ (.A1(net61),
    .A2(_272_),
    .B1_N(_253_),
    .Y(_294_));
 sky130_fd_sc_hd__a21o_1 _730_ (.A1(_256_),
    .A2(_294_),
    .B1(_274_),
    .X(_295_));
 sky130_fd_sc_hd__a211o_1 _731_ (.A1(_256_),
    .A2(_294_),
    .B1(_293_),
    .C1(_274_),
    .X(_296_));
 sky130_fd_sc_hd__nand2_1 _732_ (.A(_293_),
    .B(_295_),
    .Y(_297_));
 sky130_fd_sc_hd__nand2_1 _733_ (.A(net103),
    .B(_278_),
    .Y(_298_));
 sky130_fd_sc_hd__o211a_1 _734_ (.A1(net103),
    .A2(_278_),
    .B1(_298_),
    .C1(net58),
    .X(_299_));
 sky130_fd_sc_hd__mux4_1 _735_ (.A0(net103),
    .A1(net60),
    .A2(net62),
    .A3(net65),
    .S0(net86),
    .S1(net80),
    .X(_300_));
 sky130_fd_sc_hd__a22o_1 _736_ (.A1(_029_),
    .A2(_036_),
    .B1(_300_),
    .B2(_361_),
    .X(_301_));
 sky130_fd_sc_hd__or3b_1 _737_ (.A(net106),
    .B(_338_),
    .C_N(net26),
    .X(_302_));
 sky130_fd_sc_hd__o211a_1 _738_ (.A1(net10),
    .A2(net26),
    .B1(net54),
    .C1(_302_),
    .X(_303_));
 sky130_fd_sc_hd__a311o_1 _739_ (.A1(net10),
    .A2(net26),
    .A3(_368_),
    .B1(_162_),
    .C1(_303_),
    .X(_304_));
 sky130_fd_sc_hd__a31o_1 _740_ (.A1(_348_),
    .A2(_361_),
    .A3(_221_),
    .B1(_304_),
    .X(_305_));
 sky130_fd_sc_hd__a2bb2o_1 _741_ (.A1_N(net69),
    .A2_N(_142_),
    .B1(_301_),
    .B2(_345_),
    .X(_306_));
 sky130_fd_sc_hd__and2_1 _742_ (.A(net69),
    .B(_137_),
    .X(_307_));
 sky130_fd_sc_hd__or4_1 _743_ (.A(_299_),
    .B(_305_),
    .C(_306_),
    .D(_307_),
    .X(_308_));
 sky130_fd_sc_hd__a31o_1 _744_ (.A1(_370_),
    .A2(_296_),
    .A3(_297_),
    .B1(_308_),
    .X(net42));
 sky130_fd_sc_hd__nand2_1 _745_ (.A(net102),
    .B(net27),
    .Y(_309_));
 sky130_fd_sc_hd__or2_1 _746_ (.A(net102),
    .B(net27),
    .X(_310_));
 sky130_fd_sc_hd__nand2_1 _747_ (.A(_309_),
    .B(_310_),
    .Y(_311_));
 sky130_fd_sc_hd__a21o_1 _748_ (.A1(net26),
    .A2(net57),
    .B1(_289_),
    .X(_312_));
 sky130_fd_sc_hd__xnor2_1 _749_ (.A(_311_),
    .B(_312_),
    .Y(_313_));
 sky130_fd_sc_hd__and3_1 _750_ (.A(_292_),
    .B(_296_),
    .C(_313_),
    .X(_314_));
 sky130_fd_sc_hd__a21oi_1 _751_ (.A1(_292_),
    .A2(_296_),
    .B1(_313_),
    .Y(_315_));
 sky130_fd_sc_hd__or3_1 _752_ (.A(_371_),
    .B(_314_),
    .C(_315_),
    .X(_316_));
 sky130_fd_sc_hd__a21oi_1 _753_ (.A1(net103),
    .A2(_278_),
    .B1(net101),
    .Y(_317_));
 sky130_fd_sc_hd__a311o_1 _754_ (.A1(net103),
    .A2(net101),
    .A3(_278_),
    .B1(_317_),
    .C1(_367_),
    .X(_318_));
 sky130_fd_sc_hd__a221o_1 _755_ (.A1(net27),
    .A2(_368_),
    .B1(_036_),
    .B2(_079_),
    .C1(_049_),
    .X(_319_));
 sky130_fd_sc_hd__o211a_1 _756_ (.A1(net106),
    .A2(_309_),
    .B1(_310_),
    .C1(net54),
    .X(_320_));
 sky130_fd_sc_hd__a21oi_1 _757_ (.A1(net102),
    .A2(_319_),
    .B1(_320_),
    .Y(_321_));
 sky130_fd_sc_hd__mux4_1 _758_ (.A0(net101),
    .A1(net103),
    .A2(net60),
    .A3(net62),
    .S0(net84),
    .S1(net80),
    .X(_322_));
 sky130_fd_sc_hd__a22o_1 _759_ (.A1(_348_),
    .A2(_239_),
    .B1(_322_),
    .B2(_345_),
    .X(_323_));
 sky130_fd_sc_hd__a21oi_1 _760_ (.A1(net69),
    .A2(_165_),
    .B1(_323_),
    .Y(_324_));
 sky130_fd_sc_hd__o211a_1 _761_ (.A1(_362_),
    .A2(_324_),
    .B1(_321_),
    .C1(_318_),
    .X(_325_));
 sky130_fd_sc_hd__nand2_1 _762_ (.A(_316_),
    .B(_325_),
    .Y(net43));
 sky130_fd_sc_hd__or4_1 _763_ (.A(net37),
    .B(net44),
    .C(net45),
    .D(net46),
    .X(_326_));
 sky130_fd_sc_hd__nor3_1 _764_ (.A(net47),
    .B(net48),
    .C(_326_),
    .Y(_327_));
 sky130_fd_sc_hd__or4b_1 _765_ (.A(net49),
    .B(net50),
    .C(net51),
    .D_N(_327_),
    .X(_328_));
 sky130_fd_sc_hd__and4bb_1 _766_ (.A_N(net52),
    .B_N(net38),
    .C(_258_),
    .D(_270_),
    .X(_329_));
 sky130_fd_sc_hd__nor4b_1 _767_ (.A(net39),
    .B(net41),
    .C(_328_),
    .D_N(_329_),
    .Y(_330_));
 sky130_fd_sc_hd__and4b_1 _768_ (.A_N(net42),
    .B(_316_),
    .C(_325_),
    .D(_330_),
    .X(net53));
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
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_0_Left_32 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_1_Left_33 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_2_Left_34 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_3_Left_35 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_4_Left_36 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_5_Left_37 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_6_Left_38 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_7_Left_39 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_8_Left_40 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_9_Left_41 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_10_Left_42 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_11_Left_43 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_12_Left_44 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_13_Left_45 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_14_Left_46 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_15_Left_47 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_16_Left_48 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_17_Left_49 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_18_Left_50 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_19_Left_51 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_20_Left_52 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_21_Left_53 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_22_Left_54 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_23_Left_55 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_24_Left_56 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_25_Left_57 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_26_Left_58 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_27_Left_59 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_28_Left_60 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_29_Left_61 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_30_Left_62 ();
 sky130_fd_sc_hd__decap_3 PHY_EDGE_ROW_31_Left_63 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_0_64 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_0_65 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_0_66 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_0_67 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_0_68 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_0_69 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_1_70 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_1_71 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_1_72 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_2_73 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_2_74 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_2_75 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_3_76 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_3_77 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_3_78 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_4_79 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_4_80 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_4_81 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_5_82 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_5_83 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_5_84 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_6_85 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_6_86 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_6_87 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_7_88 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_7_89 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_7_90 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_8_91 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_8_92 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_8_93 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_9_94 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_9_95 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_9_96 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_10_97 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_10_98 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_10_99 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_11_100 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_11_101 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_11_102 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_12_103 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_12_104 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_12_105 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_13_106 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_13_107 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_13_108 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_14_109 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_14_110 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_14_111 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_15_112 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_15_113 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_15_114 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_16_115 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_16_116 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_16_117 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_17_118 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_17_119 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_17_120 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_18_121 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_18_122 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_18_123 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_19_124 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_19_125 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_19_126 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_20_127 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_20_128 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_20_129 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_21_130 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_21_131 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_21_132 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_22_133 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_22_134 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_22_135 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_23_136 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_23_137 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_23_138 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_24_139 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_24_140 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_24_141 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_25_142 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_25_143 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_25_144 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_26_145 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_26_146 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_26_147 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_27_148 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_27_149 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_27_150 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_28_151 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_28_152 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_28_153 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_29_154 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_29_155 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_29_156 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_30_157 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_30_158 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_30_159 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_31_160 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_31_161 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_31_162 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_31_163 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_31_164 ();
 sky130_fd_sc_hd__tapvpwrvgnd_1 TAP_TAPCELL_ROW_31_165 ();
 sky130_fd_sc_hd__clkbuf_1 input1 (.A(ALU_control[0]),
    .X(net1));
 sky130_fd_sc_hd__clkbuf_1 input2 (.A(ALU_control[1]),
    .X(net2));
 sky130_fd_sc_hd__clkbuf_2 input3 (.A(ALU_control[2]),
    .X(net3));
 sky130_fd_sc_hd__clkbuf_2 input4 (.A(ALU_control[3]),
    .X(net4));
 sky130_fd_sc_hd__buf_2 input5 (.A(SrcA[0]),
    .X(net5));
 sky130_fd_sc_hd__buf_1 input6 (.A(SrcA[10]),
    .X(net6));
 sky130_fd_sc_hd__buf_1 input7 (.A(SrcA[11]),
    .X(net7));
 sky130_fd_sc_hd__clkbuf_1 input8 (.A(SrcA[12]),
    .X(net8));
 sky130_fd_sc_hd__clkbuf_1 input9 (.A(SrcA[13]),
    .X(net9));
 sky130_fd_sc_hd__buf_1 input10 (.A(SrcA[14]),
    .X(net10));
 sky130_fd_sc_hd__clkbuf_1 input11 (.A(SrcA[15]),
    .X(net11));
 sky130_fd_sc_hd__buf_1 input12 (.A(SrcA[1]),
    .X(net12));
 sky130_fd_sc_hd__buf_1 input13 (.A(SrcA[2]),
    .X(net13));
 sky130_fd_sc_hd__buf_1 input14 (.A(SrcA[3]),
    .X(net14));
 sky130_fd_sc_hd__buf_1 input15 (.A(SrcA[4]),
    .X(net15));
 sky130_fd_sc_hd__clkbuf_1 input16 (.A(SrcA[5]),
    .X(net16));
 sky130_fd_sc_hd__clkbuf_1 input17 (.A(SrcA[6]),
    .X(net17));
 sky130_fd_sc_hd__clkbuf_1 input18 (.A(SrcA[7]),
    .X(net18));
 sky130_fd_sc_hd__buf_1 input19 (.A(SrcA[8]),
    .X(net19));
 sky130_fd_sc_hd__buf_1 input20 (.A(SrcA[9]),
    .X(net20));
 sky130_fd_sc_hd__clkbuf_1 input21 (.A(SrcB[0]),
    .X(net21));
 sky130_fd_sc_hd__dlymetal6s2s_1 input22 (.A(SrcB[10]),
    .X(net22));
 sky130_fd_sc_hd__dlymetal6s2s_1 input23 (.A(SrcB[11]),
    .X(net23));
 sky130_fd_sc_hd__dlymetal6s2s_1 input24 (.A(SrcB[12]),
    .X(net24));
 sky130_fd_sc_hd__dlymetal6s2s_1 input25 (.A(SrcB[13]),
    .X(net25));
 sky130_fd_sc_hd__dlymetal6s2s_1 input26 (.A(SrcB[14]),
    .X(net26));
 sky130_fd_sc_hd__buf_1 input27 (.A(SrcB[15]),
    .X(net27));
 sky130_fd_sc_hd__clkbuf_1 input28 (.A(SrcB[1]),
    .X(net28));
 sky130_fd_sc_hd__clkbuf_1 input29 (.A(SrcB[2]),
    .X(net29));
 sky130_fd_sc_hd__clkbuf_1 input30 (.A(SrcB[3]),
    .X(net30));
 sky130_fd_sc_hd__clkbuf_2 input31 (.A(SrcB[4]),
    .X(net31));
 sky130_fd_sc_hd__clkbuf_2 input32 (.A(SrcB[5]),
    .X(net32));
 sky130_fd_sc_hd__buf_1 input33 (.A(SrcB[6]),
    .X(net33));
 sky130_fd_sc_hd__dlymetal6s2s_1 input34 (.A(SrcB[7]),
    .X(net34));
 sky130_fd_sc_hd__clkbuf_2 input35 (.A(SrcB[8]),
    .X(net35));
 sky130_fd_sc_hd__clkbuf_2 input36 (.A(SrcB[9]),
    .X(net36));
 sky130_fd_sc_hd__buf_2 output37 (.A(net37),
    .X(ALU_result[0]));
 sky130_fd_sc_hd__buf_2 output38 (.A(net38),
    .X(ALU_result[10]));
 sky130_fd_sc_hd__buf_2 output39 (.A(net39),
    .X(ALU_result[11]));
 sky130_fd_sc_hd__buf_2 output40 (.A(net40),
    .X(ALU_result[12]));
 sky130_fd_sc_hd__buf_2 output41 (.A(net41),
    .X(ALU_result[13]));
 sky130_fd_sc_hd__buf_2 output42 (.A(net42),
    .X(ALU_result[14]));
 sky130_fd_sc_hd__buf_2 output43 (.A(net43),
    .X(ALU_result[15]));
 sky130_fd_sc_hd__buf_2 output44 (.A(net44),
    .X(ALU_result[1]));
 sky130_fd_sc_hd__buf_2 output45 (.A(net45),
    .X(ALU_result[2]));
 sky130_fd_sc_hd__buf_2 output46 (.A(net46),
    .X(ALU_result[3]));
 sky130_fd_sc_hd__buf_2 output47 (.A(net47),
    .X(ALU_result[4]));
 sky130_fd_sc_hd__buf_2 output48 (.A(net48),
    .X(ALU_result[5]));
 sky130_fd_sc_hd__buf_2 output49 (.A(net49),
    .X(ALU_result[6]));
 sky130_fd_sc_hd__buf_2 output50 (.A(net50),
    .X(ALU_result[7]));
 sky130_fd_sc_hd__buf_2 output51 (.A(net51),
    .X(ALU_result[8]));
 sky130_fd_sc_hd__buf_2 output52 (.A(net52),
    .X(ALU_result[9]));
 sky130_fd_sc_hd__buf_2 output53 (.A(net53),
    .X(zero));
 sky130_fd_sc_hd__clkbuf_4 fanout54 (.A(_005_),
    .X(net54));
 sky130_fd_sc_hd__dlymetal6s2s_1 fanout55 (.A(_005_),
    .X(net55));
 sky130_fd_sc_hd__buf_2 fanout56 (.A(net57),
    .X(net56));
 sky130_fd_sc_hd__buf_2 fanout57 (.A(_372_),
    .X(net57));
 sky130_fd_sc_hd__clkbuf_2 max_cap58 (.A(_366_),
    .X(net58));
 sky130_fd_sc_hd__buf_1 max_cap59 (.A(_365_),
    .X(net59));
 sky130_fd_sc_hd__clkbuf_2 fanout60 (.A(net61),
    .X(net60));
 sky130_fd_sc_hd__clkbuf_2 fanout61 (.A(net9),
    .X(net61));
 sky130_fd_sc_hd__clkbuf_2 fanout62 (.A(net8),
    .X(net62));
 sky130_fd_sc_hd__buf_1 fanout63 (.A(net8),
    .X(net63));
 sky130_fd_sc_hd__buf_2 fanout64 (.A(net7),
    .X(net64));
 sky130_fd_sc_hd__buf_1 fanout65 (.A(net7),
    .X(net65));
 sky130_fd_sc_hd__clkbuf_2 fanout66 (.A(net6),
    .X(net66));
 sky130_fd_sc_hd__buf_2 fanout67 (.A(net70),
    .X(net67));
 sky130_fd_sc_hd__buf_2 fanout68 (.A(net70),
    .X(net68));
 sky130_fd_sc_hd__buf_1 fanout69 (.A(net70),
    .X(net69));
 sky130_fd_sc_hd__clkbuf_2 fanout70 (.A(net30),
    .X(net70));
 sky130_fd_sc_hd__buf_2 fanout71 (.A(net74),
    .X(net71));
 sky130_fd_sc_hd__clkbuf_2 fanout72 (.A(net73),
    .X(net72));
 sky130_fd_sc_hd__buf_2 fanout73 (.A(net74),
    .X(net73));
 sky130_fd_sc_hd__clkbuf_2 fanout74 (.A(net29),
    .X(net74));
 sky130_fd_sc_hd__buf_2 fanout75 (.A(net78),
    .X(net75));
 sky130_fd_sc_hd__buf_1 fanout76 (.A(net78),
    .X(net76));
 sky130_fd_sc_hd__buf_2 fanout77 (.A(net78),
    .X(net77));
 sky130_fd_sc_hd__clkbuf_2 fanout78 (.A(net28),
    .X(net78));
 sky130_fd_sc_hd__buf_2 fanout79 (.A(net28),
    .X(net79));
 sky130_fd_sc_hd__clkbuf_2 fanout80 (.A(net28),
    .X(net80));
 sky130_fd_sc_hd__clkbuf_4 fanout81 (.A(net84),
    .X(net81));
 sky130_fd_sc_hd__clkbuf_2 fanout82 (.A(net84),
    .X(net82));
 sky130_fd_sc_hd__clkbuf_4 fanout83 (.A(net84),
    .X(net83));
 sky130_fd_sc_hd__buf_2 fanout84 (.A(net86),
    .X(net84));
 sky130_fd_sc_hd__buf_2 fanout85 (.A(net86),
    .X(net85));
 sky130_fd_sc_hd__clkbuf_2 fanout86 (.A(net21),
    .X(net86));
 sky130_fd_sc_hd__clkbuf_2 fanout87 (.A(net20),
    .X(net87));
 sky130_fd_sc_hd__buf_2 fanout88 (.A(net2),
    .X(net88));
 sky130_fd_sc_hd__clkbuf_2 fanout89 (.A(net19),
    .X(net89));
 sky130_fd_sc_hd__buf_2 fanout90 (.A(net18),
    .X(net90));
 sky130_fd_sc_hd__buf_1 fanout91 (.A(net18),
    .X(net91));
 sky130_fd_sc_hd__buf_2 fanout92 (.A(net17),
    .X(net92));
 sky130_fd_sc_hd__buf_1 fanout93 (.A(net17),
    .X(net93));
 sky130_fd_sc_hd__clkbuf_2 fanout94 (.A(net95),
    .X(net94));
 sky130_fd_sc_hd__clkbuf_2 fanout95 (.A(net16),
    .X(net95));
 sky130_fd_sc_hd__buf_2 fanout96 (.A(net15),
    .X(net96));
 sky130_fd_sc_hd__clkbuf_2 fanout97 (.A(net14),
    .X(net97));
 sky130_fd_sc_hd__buf_2 fanout98 (.A(net13),
    .X(net98));
 sky130_fd_sc_hd__buf_1 fanout99 (.A(net13),
    .X(net99));
 sky130_fd_sc_hd__buf_2 fanout100 (.A(net12),
    .X(net100));
 sky130_fd_sc_hd__buf_2 fanout101 (.A(net11),
    .X(net101));
 sky130_fd_sc_hd__buf_1 fanout102 (.A(net11),
    .X(net102));
 sky130_fd_sc_hd__buf_2 fanout103 (.A(net10),
    .X(net103));
 sky130_fd_sc_hd__buf_2 fanout104 (.A(net106),
    .X(net104));
 sky130_fd_sc_hd__buf_2 fanout105 (.A(net106),
    .X(net105));
 sky130_fd_sc_hd__buf_2 fanout106 (.A(net1),
    .X(net106));
endmodule
