###############################################################################
# Created by write_sdc
###############################################################################
current_design Data_Memory
###############################################################################
# Timing Constraints
###############################################################################
create_clock -name virt -period 3.7364 [get_ports {clk}]
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {mem_read_data[0]}]
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {mem_read_data[10]}]
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {mem_read_data[11]}]
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {mem_read_data[12]}]
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {mem_read_data[13]}]
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {mem_read_data[14]}]
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {mem_read_data[15]}]
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {mem_read_data[1]}]
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {mem_read_data[2]}]
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {mem_read_data[3]}]
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {mem_read_data[4]}]
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {mem_read_data[5]}]
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {mem_read_data[6]}]
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {mem_read_data[7]}]
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {mem_read_data[8]}]
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {mem_read_data[9]}]
###############################################################################
# Environment
###############################################################################
###############################################################################
# Design Rules
###############################################################################
