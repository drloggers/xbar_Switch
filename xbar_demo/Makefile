all: puresim

VLOG = \
hdl/xbar_dut/packages/xbar_pkg.sv \
hdl/xbar_dut/interfaces/xbar_if.sv hdl/xbar_dut/interfaces/xbar_sys_if.sv \
hdl/xbar_dut/input_logic/decoder.sv hdl/xbar_dut/input_logic/deserializer.sv hdl/xbar_dut/input_logic/des.sv hdl/xbar_dut/input_logic/input_logic.sv \
hdl/xbar_dut/switching_logic/switching_logic.sv \
hdl/xbar_dut/control_logic/counter.sv hdl/xbar_dut/control_logic/control_logic.sv \
hdl/xbar_dut/output_logic/encoder.sv hdl/xbar_dut/output_logic/serializer.sv hdl/xbar_dut/output_logic/ser.sv hdl/xbar_dut/output_logic/output_logic.sv \
hdl/xbar_dut/b8b10/b5b6.sv hdl/xbar_dut/b8b10/b3b4.sv hdl/xbar_dut/b8b10/b4b3.sv hdl/xbar_dut/b8b10/b6b5.sv hdl/xbar_dut/b8b10/b10b8.sv hdl/xbar_dut/b8b10/disparity.sv hdl/xbar_dut/b8b10/b8b10.sv \
hdl/xbar_dut/transmitter/transmitter.sv \
hdl/xbar_dut/receiver/receiver.sv \
hdl/xbar_dut/xbar_top/xbar.sv \
hdl/top.sv

SVLOG = \
        hdl/xbar_dut/packages/xbar_pkg.sv \
        hdl/xbar_dut/interfaces/xbar_if.sv hdl/xbar_dut/interfaces/xbar_sys_if.sv \
	hvl/xbar_hvl.sv

puresim:
	vlib puresim_work
	vmap work puresim_work 
	vlog -f $(TBX_HOME)/questa/hdl/xtlm_files.f
	vlog $(VLOG)
	vlog $(SVLOG)
	tbxsvlink -puresim
	
	
veloce:
	vlib tbx_work
	vmap work tbx_work
	vlog -f $(TBX_HOME)/questa/hdl/xtlm_files.f
	vlog $(SVLOG)
	tbxcomp -top top $(VLOG) -veloce
	tbxsvlink -veloce


launch: 
	vsim -c -novopt -do "run -all" top xbar_hvl TbxSvManager +TESTCASE=no_contention +DEBUG=0 +ERROR=1
	vsim -c -novopt -do "run -all" top xbar_hvl TbxSvManager +TESTCASE=half_contention +DEBUG=0 +ERROR=0
	vsim -c -novopt -do "run -all" top xbar_hvl TbxSvManager +TESTCASE=no_valid_packets +DEBUG=0 +ERROR=0
	vsim -c -novopt -do "run -all" top xbar_hvl TbxSvManager +TESTCASE=only_one_valid +DEBUG=0 +ERROR=0
	vsim -c -novopt -do "run -all" top xbar_hvl TbxSvManager +TESTCASE=message +DEBUG=0 +ERROR=0
	vsim -c -novopt -do "run -all" top xbar_hvl TbxSvManager +TESTCASE=random_packets +DEBUG=0 +ERROR=0
	
