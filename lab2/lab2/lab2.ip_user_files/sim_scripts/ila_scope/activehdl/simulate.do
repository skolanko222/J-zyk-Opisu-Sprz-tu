transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

asim +access +r +m+ila_scope  -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -O2 xil_defaultlib.ila_scope xil_defaultlib.glbl

do {ila_scope.udo}

run

endsim

quit -force
