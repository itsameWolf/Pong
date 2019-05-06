transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/Lupo/Documents/GitHub/Pong {C:/Users/Lupo/Documents/GitHub/Pong/BinaryToBCD.v}

vlog -vlog01compat -work work +incdir+C:/Users/Lupo/Documents/GitHub/Pong/simulation {C:/Users/Lupo/Documents/GitHub/Pong/simulation/BinaryToBCD_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  BinaryToBCD_tb

do C:/Users/Lupo/Documents/GitHub/Pong/simulation/load_sim.tcl
