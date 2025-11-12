#Edge: BOTTOM
#Edge: RIGHT
place_pin -pin_name ALUControl[0] -layer met3 -location {37.37 16.66} -force_to_die_boundary
place_pin -pin_name ALUControl[1] -layer met3 -location {37.37 19.38} -force_to_die_boundary
place_pin -pin_name ALUControl[2] -layer met3 -location {37.37 23.46} -force_to_die_boundary
place_pin -pin_name ALUControl[3] -layer met3 -location {37.37 22.1} -force_to_die_boundary
place_pin -pin_name func[1] -layer met3 -location {37.37 18.02} -force_to_die_boundary
place_pin -pin_name func[3] -layer met3 -location {37.37 20.74} -force_to_die_boundary
#Edge: TOP
place_pin -pin_name func[2] -layer met2 -location {24.15 37.37} -force_to_die_boundary
place_pin -pin_name opcode[0] -layer met2 -location {21.39 37.37} -force_to_die_boundary
#Edge: LEFT
place_pin -pin_name ALUSrc -layer met3 -location {0 24.82} -force_to_die_boundary
place_pin -pin_name ImmSrc[0] -layer met3 -location {0 22.1} -force_to_die_boundary
place_pin -pin_name ImmSrc[1] -layer met3 -location {0 23.46} -force_to_die_boundary
place_pin -pin_name MemWrite -layer met3 -location {0 27.54} -force_to_die_boundary
place_pin -pin_name PCSrc -layer met3 -location {0 19.38} -force_to_die_boundary
place_pin -pin_name RegWrite -layer met3 -location {0 18.02} -force_to_die_boundary
place_pin -pin_name ResultSrc -layer met3 -location {0 26.18} -force_to_die_boundary
place_pin -pin_name func[0] -layer met3 -location {0 16.66} -force_to_die_boundary
place_pin -pin_name opcode[1] -layer met3 -location {0 20.74} -force_to_die_boundary
place_pin -pin_name opcode[2] -layer met3 -location {0 28.9} -force_to_die_boundary
place_pin -pin_name zero -layer met3 -location {0 15.3} -force_to_die_boundary
