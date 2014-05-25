// Interface for Input Block 

import xbar_pkg::*;

interface xbar_sys_if(input clk,rst);

logic [ports-1:0]serial_in;
logic [ports-1:0]serial_out;
wire load;
wire [7:0]decoded_out[ports-1:0];
wire [7:0]parallel_in[ports-1:0];

logic [2*packet_width-1:0]in2sw_out;
  
  logic clk80,clk20,clk10,mux_en;
  logic[$clog2(ports)-1:0]mux_sel;
  

  modport serializer(input clk,rst,input parallel_in, input load, output serial_out);
  
   
  modport input_logic(input clk,rst, clk10, mux_sel,serial_in, output in2sw_out,decoded_out);
  
  
  modport control_logic(input clk,rst, output clk80,clk20,clk10,mux_sel);
  
endinterface
