###############################################################################
# Created by write_sdc
###############################################################################
current_design ALU
###############################################################################
# Timing Constraints
###############################################################################
create_clock -name virt -period 10.0000 
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {ALU_result[0]}]
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {ALU_result[10]}]
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {ALU_result[11]}]
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {ALU_result[12]}]
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {ALU_result[13]}]
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {ALU_result[14]}]
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {ALU_result[15]}]
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {ALU_result[1]}]
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {ALU_result[2]}]
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {ALU_result[3]}]
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {ALU_result[4]}]
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {ALU_result[5]}]
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {ALU_result[6]}]
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {ALU_result[7]}]
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {ALU_result[8]}]
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {ALU_result[9]}]
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {zero}]
###############################################################################
# Environment
###############################################################################
###############################################################################
# Design Rules
###############################################################################
