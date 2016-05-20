## This file is a general .xdc for the Basys3 rev B board
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project

## Clock signal
set_property PACKAGE_PIN W5 [get_ports CLK]							
	set_property IOSTANDARD LVCMOS33 [get_ports CLK]
	create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]
 




#VGA Connector
    #Bank = 14, Pin name = ,                    Sch name = VGA_R0
    set_property PACKAGE_PIN G19 [get_ports {VGA_RED[0]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {VGA_RED[0]}]
    #Bank = 14, Pin name = ,                    Sch name = VGA_R1
    set_property PACKAGE_PIN H19 [get_ports {VGA_RED[1]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {VGA_RED[1]}]
    #Bank = 14, Pin name = ,                    Sch name = VGA_R2
    set_property PACKAGE_PIN J19 [get_ports {VGA_RED[2]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {VGA_RED[2]}]
    #Bank = 14, Pin name = ,                    Sch name = VGA_R3
    set_property PACKAGE_PIN N19 [get_ports {VGA_RED[3]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {VGA_RED[3]}]
    #Bank = 14, Pin name = ,                    Sch name = VGA_B0
    set_property PACKAGE_PIN N18 [get_ports {VGA_BLUE[0]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {VGA_BLUE[0]}]
    #Bank = 14, Pin name = ,                        Sch name = VGA_B1
    set_property PACKAGE_PIN L18 [get_ports {VGA_BLUE[1]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {VGA_BLUE[1]}]
    #Bank = 14, Pin name = ,                    Sch name = VGA_B2
    set_property PACKAGE_PIN K18 [get_ports {VGA_BLUE[2]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {VGA_BLUE[2]}]
    #Bank = 14, Pin name = ,                        Sch name = VGA_B3
    set_property PACKAGE_PIN J18 [get_ports {VGA_BLUE[3]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {VGA_BLUE[3]}]
    #Bank = 14, Pin name = ,                    Sch name = VGA_G0
    set_property PACKAGE_PIN J17 [get_ports {VGA_GREEN[0]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {VGA_GREEN[0]}]
    #Bank = 14, Pin name = ,                Sch name = VGA_G1
    set_property PACKAGE_PIN H17 [get_ports {VGA_GREEN[1]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {VGA_GREEN[1]}]
    #Bank = 14, Pin name = ,                    Sch name = VGA_G2
    set_property PACKAGE_PIN G17 [get_ports {VGA_GREEN[2]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {VGA_GREEN[2]}]
    #Bank = 14, Pin name = ,                Sch name = VGA_G3
    set_property PACKAGE_PIN D17 [get_ports {VGA_GREEN[3]}]
    set_property IOSTANDARD LVCMOS33 [get_ports {VGA_GREEN[3]}]
    #Bank = 14, Pin name = ,                        Sch name = VGA_HS
    set_property PACKAGE_PIN P19 [get_ports VGA_HS]
    set_property IOSTANDARD LVCMOS33 [get_ports VGA_HS]
    #Bank = 14, Pin name = ,                Sch name = VGA_VS
    set_property PACKAGE_PIN R19 [get_ports VGA_VS]
    set_property IOSTANDARD LVCMOS33 [get_ports VGA_VS]



set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]
set_property CONFIG_MODE SPIx4 [current_design]

set_property BITSTREAM.CONFIG.CONFIGRATE 33 [current_design]

set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]



