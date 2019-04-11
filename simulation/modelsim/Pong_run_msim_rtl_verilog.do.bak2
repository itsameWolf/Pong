transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/Lupo/OneDrive\ -\ University\ of\ Leeds/Pong {C:/Users/Lupo/OneDrive - University of Leeds/Pong/Ball.v}

vlog -vlog01compat -work work +incdir+C:/Users/Lupo/OneDrive\ -\ University\ of\ Leeds/Pong/simulation {C:/Users/Lupo/OneDrive - University of Leeds/Pong/simulation/Ball_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  Ball_tb

do C:/Users/Lupo/OneDrive - University of Leeds/Pong/simulation/load_sim.tcl
