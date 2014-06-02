#do file
vlib xbar_work
vmap work xbar_work

vlog ./packages/xbar_pkg.sv
vlog ./interfaces/xbar_if.sv ./interfaces/xbar_sys_if.sv
vlog ./input_logic/decoder.sv ./input_logic/deserializer.sv ./input_logic/des.sv ./input_logic/input_logic.sv
vlog ./switching_logic/switching_logic.sv
vlog ./control_logic/counter.sv ./control_logic/control_logic.sv
vlog ./output_logic/encoder.sv ./output_logic/serializer.sv ./output_logic/ser.sv ./output_logic/output_logic.sv
vlog ./b8b10/b5b6.sv ./b8b10/b3b4.sv ./b8b10/b6b5.sv ./b8b10/b3b4.sv ./b8b10/b10b8.sv ./b8b10/disparity.sv ./b8b10/b8b10.sv
vlog ./transmitter/transmitter.sv 
vlog ./receiver/receiver.sv
vlog ./xbar_top/xbar.sv ./xbar_top/xbar_tb.sv
vsim -novopt xbar_tb

