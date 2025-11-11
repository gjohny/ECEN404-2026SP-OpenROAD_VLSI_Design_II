###############################################################################
# Created by write_sdc
###############################################################################
current_design Register_file
###############################################################################
# Timing Constraints
###############################################################################
create_clock -name virt -period 3.7912 [get_ports {clk}]
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {RD1[0]}]
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {RD1[10]}]
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {RD1[11]}]
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {RD1[12]}]
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {RD1[13]}]
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {RD1[14]}]
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {RD1[15]}]
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {RD1[1]}]
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {RD1[2]}]
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {RD1[3]}]
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {RD1[4]}]
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {RD1[5]}]
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {RD1[6]}]
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {RD1[7]}]
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {RD1[8]}]
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {RD1[9]}]
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {RD2[0]}]
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {RD2[10]}]
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {RD2[11]}]
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {RD2[12]}]
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {RD2[13]}]
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {RD2[14]}]
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {RD2[15]}]
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {RD2[1]}]
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {RD2[2]}]
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {RD2[3]}]
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {RD2[4]}]
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {RD2[5]}]
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {RD2[6]}]
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {RD2[7]}]
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {RD2[8]}]
set_output_delay 2.0000 -clock [get_clocks {virt}] -add_delay [get_ports {RD2[9]}]
###############################################################################
# Environment
###############################################################################
###############################################################################
# Design Rules
###############################################################################
