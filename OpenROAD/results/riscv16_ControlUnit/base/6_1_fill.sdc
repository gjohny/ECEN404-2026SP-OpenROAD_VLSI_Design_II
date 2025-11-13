###############################################################################
# Created by write_sdc
###############################################################################
current_design Control_Unit
###############################################################################
# Timing Constraints
###############################################################################
create_clock -name virt -period 10.0000 
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {ALUControl[0]}]
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {ALUControl[1]}]
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {ALUControl[2]}]
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {ALUControl[3]}]
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {ALUSrc}]
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {ImmSrc[0]}]
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {ImmSrc[1]}]
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {MemWrite}]
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {PCSrc}]
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {RegWrite}]
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {ResultSrc}]
###############################################################################
# Environment
###############################################################################
###############################################################################
# Design Rules
###############################################################################
