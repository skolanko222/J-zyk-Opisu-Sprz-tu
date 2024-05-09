onbreak {quit -f}
onerror {quit -f}

vsim -voptargs="+acc"  -L axi_lite_ipif_v3_0_4 -L lib_pkg_v1_0_2 -L lib_srl_fifo_v1_0_2 -L lib_cdc_v1_0_2 -L axi_uartlite_v2_0_32 -L xil_defaultlib -L secureip -lib xil_defaultlib xil_defaultlib.axi_uartlite_0

set NumericStdNoWarnings 1
set StdArithNoWarnings 1

do {wave.do}

view wave
view structure
view signals

do {axi_uartlite_0.udo}

run 1000ns

quit -force
