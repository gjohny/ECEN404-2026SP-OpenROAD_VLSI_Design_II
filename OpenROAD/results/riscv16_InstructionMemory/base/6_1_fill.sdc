###############################################################################
# Created by write_sdc
###############################################################################
current_design Instruction_Memory_16
###############################################################################
# Timing Constraints
###############################################################################
create_clock -name virt -period 10.0000 
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {instruction[0]}]
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {instruction[10]}]
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {instruction[11]}]
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {instruction[12]}]
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {instruction[13]}]
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {instruction[14]}]
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {instruction[15]}]
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {instruction[1]}]
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {instruction[2]}]
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {instruction[3]}]
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {instruction[4]}]
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {instruction[5]}]
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {instruction[6]}]
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {instruction[7]}]
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {instruction[8]}]
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {instruction[9]}]
###############################################################################
# Environment
###############################################################################
###############################################################################
# Design Rules
###############################################################################
