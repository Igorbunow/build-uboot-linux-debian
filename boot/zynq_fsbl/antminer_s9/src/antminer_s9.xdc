## This file is a general .xdc for the Antminer S9 control board

## Clock Signal
#set_property -dict { PACKAGE_PIN N18    IOSTANDARD LVCMOS33 } [get_ports { clk0 }];  #Use this if Y3 is soldered 
#set_property -dict { PACKAGE_PIN K17    IOSTANDARD LVCMOS33 } [get_ports { clk1 }];  #Use this if Y4 is soldered 
#create_clock -add -name sys_clk_pin -period 8.00 -waveform {0 4} [get_ports { clk }];

#set_property package_pin K17 [get_ports clk_100_i]
#set_property iostandard lvcmos33 [get_ports clk_100_i]
#create_clock -period 10 [get_ports clk_100_i]

###########################################################
##     Buttons                                           ##
###########################################################

## S1 button
## Bank 501
set_property iostandard    "LVCMOS25" [get_ports "BUTTONS[1]"]
set_property PACKAGE_PIN   "B14"      [get_ports "BUTTONS[1]"]
set_property PIO_DIRECTION "INPUT"    [get_ports "BUTTONS[1]"]
set_property PULLTYPE      "PULLUP"   [get_ports "BUTTONS[1]"]

## S2 button
## Bank 501
set_property iostandard    "LVCMOS25" [get_ports "BUTTONS[2]"]
set_property PACKAGE_PIN   "B9"       [get_ports "BUTTONS[2]"]
set_property PIO_DIRECTION "INPUT"    [get_ports "BUTTONS[2]"]
set_property PULLTYPE      "PULLUP"   [get_ports "BUTTONS[2]"]


###########################################################
##     LEDS                                              ##
###########################################################

## LED Green
## Bank 501
set_property iostandard    "LVCMOS25" [get_ports ""]
set_property PACKAGE_PIN   "E13"      [get_ports ""]
set_property slew          "SLOW"     [get_ports ""]
set_property PIO_DIRECTION "OUTPUT"   [get_ports ""]
set_property drive         "6"        [get_ports ""]

## LED Red
## Bank 501
set_property iostandard    "LVCMOS25" [get_ports ""]
set_property PACKAGE_PIN   "A10"      [get_ports ""]
set_property slew          "SLOW"     [get_ports ""]
set_property PIO_DIRECTION "OUTPUT"   [get_ports ""]
set_property drive         "6"        [get_ports ""]

## LED D7
## Bank 35
set_property iostandard    "LVCMOS33" [get_ports ""]
set_property PACKAGE_PIN   "F16"      [get_ports ""]
set_property slew          "SLOW"     [get_ports ""]
set_property PIO_DIRECTION "OUTPUT"   [get_ports ""]
set_property drive         "6"        [get_ports ""]

## LED D8
## Bank 35
set_property iostandard    "LVCMOS33" [get_ports ""]
set_property PACKAGE_PIN   "L19"      [get_ports ""]
set_property slew          "SLOW"     [get_ports ""]
set_property PIO_DIRECTION "OUTPUT"   [get_ports ""]
set_property drive         "6"        [get_ports ""]

## LED D5
## Bank 35
set_property iostandard    "LVCMOS33" [get_ports ""]
set_property PACKAGE_PIN   "M19"      [get_ports ""]
set_property slew          "SLOW"     [get_ports ""]
set_property PIO_DIRECTION "OUTPUT"   [get_ports ""]
set_property drive         "6"        [get_ports ""]

## LED D6
## Bank 35
set_property iostandard    "LVCMOS33" [get_ports ""]
set_property PACKAGE_PIN   "M17"      [get_ports ""]
set_property slew          "SLOW"     [get_ports ""]
set_property PIO_DIRECTION "OUTPUT"   [get_ports ""]
set_property drive         "6"        [get_ports ""]


###########################################################
##     Beep                                              ##
###########################################################

## Beep
## Bank 501
set_property iostandard    "LVCMOS25" [get_ports "Beep"]
set_property PACKAGE_PIN   "C18"      [get_ports "Beep"]
set_property slew          "SLOW"     [get_ports "Beep"]
set_property PIO_DIRECTION "OUTPUT"   [get_ports "Beep"]
set_property drive         "6"        [get_ports "Beep"]

###  Otput Pin sample
## LVCMOS12 LVCMOS15 LVCMOS18 LVCMOS25 LVCMOS33
#set_property iostandard    "LVCMOS33" [get_ports ""]
#set_property PACKAGE_PIN   ""       [get_ports ""]
## SLEW specifies output buffer slew rate for output buffers configured with I/O standards
## SLOW (default) / FAST
#set_property slew          "SLOW"     [get_ports ""]
#set_property PIO_DIRECTION "OUTPUT"   [get_ports ""]
## DRIVE specifies output buffer drive strength in mA for output buffers configured with I/O 
##  standards that support programmable output drive strengths. {2|4|6|8|12|16|24}
#set_property drive         "6"        [get_ports ""]

#set_property iostandard    "LVCMOS33" [get_ports ""]
#set_property PACKAGE_PIN   ""       [get_ports ""]
#set_property slew          "SLOW"     [get_ports ""]
#set_property PIO_DIRECTION "OUTPUT"   [get_ports ""]
#set_property drive         "6"        [get_ports ""]


###  Input pin sample
#set_property iostandard    "LVCMOS33" [get_ports ""]
#set_property PACKAGE_PIN   ""      [get_ports ""]
#set_property PIO_DIRECTION "INPUT"    [get_ports ""]
## Input buffers (for example, IBUF), 3-state output buffers (for example, OBUFT), 
##   and bidirectional buffers (for example, IOBUF) can have a weak pull-up resistor, 
##   a weak pull-down resistor, or a weak "keeper" circuit. 
##   PULLUP/PULLDOWN/KEEPER
#set_property PULLTYPE {KEEPER|PULLDOWN|PULLUP| } [get_ports ""]

#set_property iostandard    "LVCMOS33" [get_ports ""]
#set_property PACKAGE_PIN   ""      [get_ports ""]
#set_property PIO_DIRECTION "INPUT"    [get_ports ""]
#set_property PULLTYPE {KEEPER|PULLDOWN|PULLUP| } [get_ports ""]