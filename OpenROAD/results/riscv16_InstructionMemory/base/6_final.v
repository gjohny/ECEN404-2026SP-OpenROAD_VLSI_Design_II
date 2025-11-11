module Instruction_Memory_16 (instruction,
    pc);
 output [15:0] instruction;
 input [15:0] pc;


 sky130_fd_sc_hd__conb_1 _02__1 (.LO(instruction[0]));
 sky130_fd_sc_hd__conb_1 _03__2 (.LO(instruction[1]));
 sky130_fd_sc_hd__conb_1 _04__3 (.LO(instruction[2]));
 sky130_fd_sc_hd__conb_1 _05__4 (.LO(instruction[3]));
 sky130_fd_sc_hd__conb_1 _06__5 (.LO(instruction[4]));
 sky130_fd_sc_hd__conb_1 _07__6 (.LO(instruction[5]));
 sky130_fd_sc_hd__conb_1 _08__7 (.LO(instruction[6]));
 sky130_fd_sc_hd__conb_1 _09__8 (.LO(instruction[7]));
 sky130_fd_sc_hd__conb_1 _10__9 (.LO(instruction[8]));
 sky130_fd_sc_hd__conb_1 _11__10 (.LO(instruction[9]));
 sky130_fd_sc_hd__conb_1 _12__11 (.LO(instruction[10]));
 sky130_fd_sc_hd__conb_1 _13__12 (.LO(instruction[11]));
 sky130_fd_sc_hd__conb_1 _14__13 (.LO(instruction[12]));
 sky130_fd_sc_hd__conb_1 _15__14 (.LO(instruction[13]));
 sky130_fd_sc_hd__conb_1 _16__15 (.LO(instruction[14]));
 sky130_fd_sc_hd__conb_1 _17__16 (.LO(instruction[15]));
endmodule
