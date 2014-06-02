// Very Very Top Module

module xbar(xbar_if xbar_port);

import xbar_pkg::*;

xbar_sys_if sys_port(.clk(xbar_port.clk),.rst(xbar_port.rst));
  
assign sys_port.serial_in=xbar_port.serial_in;
assign xbar_port.serial_out=sys_port.serial_out;
assign xbar_port.running_slot=sys_port.running_slot;
assign xbar_port.header_present=sys_port.header_present;  
assign xbar_port.clk10 = sys_port.clk10;
assign xbar_port.clk20 = sys_port.clk20;
//Input Block
input_logic ib(sys_port.input_logic);
 
//Switching
switching_logic sw(sys_port.switching_logic);



//Output Block
output_logic op(sys_port.output_logic);

//Control   
  control_logic cl(sys_port.control_logic);
endmodule