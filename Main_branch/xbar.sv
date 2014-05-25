// Very Very Top Module

module xbar(xbar_if xbar_port);

import xbar_pkg::*;

xbar_sys_if sys_port(.clk(xbar_port.clk),.rst(xbar_port.rst));
  
assign sys_port.serial_in=xbar_port.serial_in;
assign xbar_port.serial_out=sys_port.serial_out;  
  
//Input Block
input_block ib(sys_port.input_logic);
 
//Switching


//Output Block


//Control   
  control_logic cl(sys_port.control_logic);
endmodule