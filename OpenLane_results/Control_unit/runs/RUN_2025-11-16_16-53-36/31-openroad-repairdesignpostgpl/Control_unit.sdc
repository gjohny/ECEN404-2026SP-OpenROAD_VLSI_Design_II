###############################################################################
# Created by write_sdc
###############################################################################
current_design Control_unit
###############################################################################
# Timing Constraints
###############################################################################
create_clock -name clk -period 25.0000 
set_clock_uncertainty 0.2500 clk
set_input_delay 5.0000 -clock [get_clocks {clk}] -add_delay [get_ports {func[0]}]
set_input_delay 5.0000 -clock [get_clocks {clk}] -add_delay [get_ports {func[1]}]
set_input_delay 5.0000 -clock [get_clocks {clk}] -add_delay [get_ports {func[2]}]
set_input_delay 5.0000 -clock [get_clocks {clk}] -add_delay [get_ports {func[3]}]
set_input_delay 5.0000 -clock [get_clocks {clk}] -add_delay [get_ports {opcode[0]}]
set_input_delay 5.0000 -clock [get_clocks {clk}] -add_delay [get_ports {opcode[1]}]
set_input_delay 5.0000 -clock [get_clocks {clk}] -add_delay [get_ports {opcode[2]}]
set_input_delay 5.0000 -clock [get_clocks {clk}] -add_delay [get_ports {zero}]
set_output_delay 5.0000 -clock [get_clocks {clk}] -add_delay [get_ports {ALUControl[0]}]
set_output_delay 5.0000 -clock [get_clocks {clk}] -add_delay [get_ports {ALUControl[1]}]
set_output_delay 5.0000 -clock [get_clocks {clk}] -add_delay [get_ports {ALUControl[2]}]
set_output_delay 5.0000 -clock [get_clocks {clk}] -add_delay [get_ports {ALUControl[3]}]
set_output_delay 5.0000 -clock [get_clocks {clk}] -add_delay [get_ports {ALUSrc}]
set_output_delay 5.0000 -clock [get_clocks {clk}] -add_delay [get_ports {ImmSrc[0]}]
set_output_delay 5.0000 -clock [get_clocks {clk}] -add_delay [get_ports {ImmSrc[1]}]
set_output_delay 5.0000 -clock [get_clocks {clk}] -add_delay [get_ports {MemWrite}]
set_output_delay 5.0000 -clock [get_clocks {clk}] -add_delay [get_ports {PCSrc}]
set_output_delay 5.0000 -clock [get_clocks {clk}] -add_delay [get_ports {RegWrite}]
set_output_delay 5.0000 -clock [get_clocks {clk}] -add_delay [get_ports {ResultSrc}]
###############################################################################
# Environment
###############################################################################
set_load -pin_load 0.0334 [get_ports {ALUSrc}]
set_load -pin_load 0.0334 [get_ports {MemWrite}]
set_load -pin_load 0.0334 [get_ports {PCSrc}]
set_load -pin_load 0.0334 [get_ports {RegWrite}]
set_load -pin_load 0.0334 [get_ports {ResultSrc}]
set_load -pin_load 0.0334 [get_ports {ALUControl[3]}]
set_load -pin_load 0.0334 [get_ports {ALUControl[2]}]
set_load -pin_load 0.0334 [get_ports {ALUControl[1]}]
set_load -pin_load 0.0334 [get_ports {ALUControl[0]}]
set_load -pin_load 0.0334 [get_ports {ImmSrc[1]}]
set_load -pin_load 0.0334 [get_ports {ImmSrc[0]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {zero}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {func[3]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {func[2]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {func[1]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {func[0]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {opcode[2]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {opcode[1]}]
set_driving_cell -lib_cell sky130_fd_sc_hd__inv_2 -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {opcode[0]}]
###############################################################################
# Design Rules
###############################################################################
set_max_transition 0.7500 [current_design]
set_max_capacitance 0.2000 [current_design]
set_max_fanout 6.0000 [current_design]
