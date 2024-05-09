# ----------------------------------------------------------------------------
# Clock Source - Bank 13
# ---------------------------------------------------------------------------- 
set_property PACKAGE_PIN Y9 [get_ports {clk}];  # "GCLK"
# 34
set_property PACKAGE_PIN P16 [get_ports {rst}];  # "BTNC"

# ----------------------------------------------------------------------------
# JA Pmod - Bank 13 
# ---------------------------------------------------------------------------- 
set_property PACKAGE_PIN Y11  [get_ports {slow}];  # "JA1"
set_property PACKAGE_PIN AA11 [get_ports {random}];  # "JA2"
set_property PACKAGE_PIN Y10  [get_ports {outfsm}];  # "JA3"
set_property PACKAGE_PIN AA9  [get_ports {trg}];  # "JA4"

set_property IOSTANDARD LVCMOS33 [get_ports -of_objects [get_iobanks 13]];
#set_property IOSTANDARD LVCMOS33 [get_ports -of_objects [get_iobanks 33]];
set_property IOSTANDARD LVCMOS18 [get_ports -of_objects [get_iobanks 34]];