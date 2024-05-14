transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

vlib work
vmap -link {/home/stud2021/1kolanko/JOS/JOS_old_V/JOS_old_V.cache/compile_simlib/riviera}
vlib riviera/xil_defaultlib

vlog -work xil_defaultlib  -incr -v2k5 -l xil_defaultlib \
"../../../../JOS_old_V.gen/sources_1/ip/axi_uartlite_0_1/axi_uartlite_0_sim_netlist.v" \


vlog -work xil_defaultlib \
"glbl.v"

