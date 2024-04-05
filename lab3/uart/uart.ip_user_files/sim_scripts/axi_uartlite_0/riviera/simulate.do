transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

asim +access +r +m+axi_uartlite_0  -L axi_lite_ipif_v3_0_4 -L lib_pkg_v1_0_2 -L lib_srl_fifo_v1_0_2 -L lib_cdc_v1_0_2 -L axi_uartlite_v2_0_32 -L xil_defaultlib -L secureip -O5 xil_defaultlib.axi_uartlite_0

do {axi_uartlite_0.udo}

run 1000ns

endsim

quit -force
