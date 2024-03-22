transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

vlib work
vmap -link {/home/stud2021/1kolanko/JOS/lab2/lab2/lab2.cache/compile_simlib/riviera}
vlib riviera/xil_defaultlib

vlog -work xil_defaultlib  -incr -v2k5 "+incdir+../../../../lab2.gen/sources_1/ip/ila_scope/hdl/verilog" -l xil_defaultlib \
"../../../../lab2.gen/sources_1/ip/ila_scope/sim/ila_scope.v" \


vlog -work xil_defaultlib \
"glbl.v"

