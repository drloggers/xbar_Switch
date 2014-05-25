#do file

vlog xbar_pkg.sv xbar_if.sv xbar_sys_if.sv 
vlog deserializer.sv decoder.sv des.sv input_block.sv 
vlog serializer.sv encoder.sv ser.sv 
vlog counter.sv control_logic.sv
vlog xbar.sv xbar_tb.sv
vsim -novopt xbar_tb
add wave *
add wave -position insertpoint sim:/xbar_tb/xbar_DUT/ib/deserializer/*
add wave -position insertpoint  \
sim:/xbar_tb/xbar_DUT/ib/deserializer/serial_in \
sim:/xbar_tb/xbar_DUT/ib/deserializer/data \
sim:/xbar_tb/xbar_DUT/sys_port/in2sw_out \
sim:/xbar_tb/xbar_DUT/sys_port/mux_sel \
sim:/xbar_tb/xbar_DUT/sys_port/clk10 \
sim:/xbar_tb/xbar_DUT/sys_port/clk80 \
sim:/xbar_tb/xbar_DUT/sys_port/clk20 
add wave -position insertpoint sim:/xbar_tb/sank/*