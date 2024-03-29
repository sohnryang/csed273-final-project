set_property PACKAGE_PIN L1 [get_ports {dice_led[0]}]
set_property PACKAGE_PIN P1 [get_ports {dice_led[1]}]
set_property PACKAGE_PIN N3 [get_ports {dice_led[2]}]
set_property PACKAGE_PIN P3 [get_ports {dice_led[3]}]
set_property PACKAGE_PIN U3 [get_ports {dice_led[4]}]
set_property PACKAGE_PIN W3 [get_ports {dice_led[5]}]
set_property PACKAGE_PIN V3 [get_ports {dice_led[6]}]
set_property PACKAGE_PIN V13 [get_ports {dice_led[7]}]
set_property PACKAGE_PIN V14 [get_ports {dice_led[8]}]
set_property PACKAGE_PIN U14 [get_ports {dice_led[9]}]
set_property PACKAGE_PIN U15 [get_ports {dice_led[10]}]
set_property PACKAGE_PIN W18 [get_ports {dice_led[11]}]
set_property PACKAGE_PIN V19 [get_ports {dice_led[12]}]
set_property PACKAGE_PIN U19 [get_ports {dice_led[13]}]
set_property PACKAGE_PIN E19 [get_ports {dice_led[14]}]
set_property PACKAGE_PIN W7 [get_ports {ss_display[0]}]
set_property PACKAGE_PIN W6 [get_ports {ss_display[1]}]
set_property PACKAGE_PIN U8 [get_ports {ss_display[2]}]
set_property PACKAGE_PIN V8 [get_ports {ss_display[3]}]
set_property PACKAGE_PIN U5 [get_ports {ss_display[4]}]
set_property PACKAGE_PIN V5 [get_ports {ss_display[5]}]
set_property PACKAGE_PIN U7 [get_ports {ss_display[6]}]
set_property PACKAGE_PIN V7 [get_ports {ss_display[7]}]
set_property PACKAGE_PIN W4 [get_ports {ss_sel[0]}]
set_property PACKAGE_PIN V4 [get_ports {ss_sel[1]}]
set_property PACKAGE_PIN U4 [get_ports {ss_sel[2]}]
set_property PACKAGE_PIN U2 [get_ports {ss_sel[3]}]
set_property PACKAGE_PIN U18 [get_ports throw_button]
set_property PACKAGE_PIN W19 [get_ports prev_button]
set_property PACKAGE_PIN T17 [get_ports next_button]
set_property PACKAGE_PIN W5 [get_ports clk]

set_property IOSTANDARD LVCMOS18 [get_ports {dice_led[0]}]
set_property IOSTANDARD LVCMOS18 [get_ports {dice_led[1]}]
set_property IOSTANDARD LVCMOS18 [get_ports {dice_led[2]}]
set_property IOSTANDARD LVCMOS18 [get_ports {dice_led[3]}]
set_property IOSTANDARD LVCMOS18 [get_ports {dice_led[4]}]
set_property IOSTANDARD LVCMOS18 [get_ports {dice_led[5]}]
set_property IOSTANDARD LVCMOS18 [get_ports {dice_led[6]}]
set_property IOSTANDARD LVCMOS18 [get_ports {dice_led[7]}]
set_property IOSTANDARD LVCMOS18 [get_ports {dice_led[8]}]
set_property IOSTANDARD LVCMOS18 [get_ports {dice_led[9]}]
set_property IOSTANDARD LVCMOS18 [get_ports {dice_led[10]}]
set_property IOSTANDARD LVCMOS18 [get_ports {dice_led[11]}]
set_property IOSTANDARD LVCMOS18 [get_ports {dice_led[12]}]
set_property IOSTANDARD LVCMOS18 [get_ports {dice_led[13]}]
set_property IOSTANDARD LVCMOS18 [get_ports {dice_led[14]}]
set_property IOSTANDARD LVCMOS18 [get_ports {ss_display[0]}]
set_property IOSTANDARD LVCMOS18 [get_ports {ss_display[1]}]
set_property IOSTANDARD LVCMOS18 [get_ports {ss_display[2]}]
set_property IOSTANDARD LVCMOS18 [get_ports {ss_display[3]}]
set_property IOSTANDARD LVCMOS18 [get_ports {ss_display[4]}]
set_property IOSTANDARD LVCMOS18 [get_ports {ss_display[5]}]
set_property IOSTANDARD LVCMOS18 [get_ports {ss_display[6]}]
set_property IOSTANDARD LVCMOS18 [get_ports {ss_display[7]}]
set_property IOSTANDARD LVCMOS18 [get_ports {ss_sel[0]}]
set_property IOSTANDARD LVCMOS18 [get_ports {ss_sel[1]}]
set_property IOSTANDARD LVCMOS18 [get_ports {ss_sel[2]}]
set_property IOSTANDARD LVCMOS18 [get_ports {ss_sel[3]}]
set_property IOSTANDARD LVCMOS18 [get_ports throw_button]
set_property IOSTANDARD LVCMOS18 [get_ports prev_button]
set_property IOSTANDARD LVCMOS18 [get_ports next_button]
set_property IOSTANDARD LVCMOS18 [get_ports clk]

create_clock -period 10.000 -name clk0 -waveform {0.000 5.000} [get_ports clk]
