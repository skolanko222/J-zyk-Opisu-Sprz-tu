vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xil_defaultlib

vmap xil_defaultlib questa_lib/msim/xil_defaultlib

vlog -work xil_defaultlib -64 -incr -mfcu  "+incdir+../../../../lab2.gen/sources_1/ip/ila_scope/hdl/verilog" \
"../../../../lab2.gen/sources_1/ip/ila_scope/sim/ila_scope.v" \


vlog -work xil_defaultlib \
"glbl.v"

