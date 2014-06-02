// Interface for Input Block 

import xbar_pkg::*;

interface xbar_sys_if(input clk,rst);

logic [ports-1:0]serial_in;
logic [ports-1:0]serial_out;
wire [7:0][ports-1:0]decoded_out;
logic [7:0][ports-1:0]parallel_in;

//logic [2*packet_width-1:0]in2sw_out, sw2op_out;
packet input_header,input_payload,output_header,output_payload;
logic [$clog2(slots)-1:0]sw2op_wad;
logic [$clog2(ports)-1:0]sw2op_wcs;
  
  logic clk80,clk20,clk10,load,mux_en;
  logic[$clog2(ports*slots)-1:0]mux_sel;
  logic [$clog2(slots)-1:0]running_slot;
  logic header_present;
  logic bank_sel;
  logic mem_clr;
  logic [1:0]sys_status;
  logic header2_present;
  logic bank2_sel;
  logic swdone;
 logic [$clog2(slots)-1:0]running2_slot;
   
  modport input_logic(input clk,rst,mux_sel,serial_in,clk10,header_present,clk80,running_slot,bank_sel, output input_header,input_payload,decoded_out);
  
  
  modport control_logic(input clk,rst, output clk80,clk20,clk10,load,mux_sel,running_slot,header_present,bank_sel,mem_clr,sys_status,header2_present,bank2_sel,running2_slot,swdone);
  
  modport switching_logic(input input_header,input_payload,mux_sel,running_slot,swdone, output sw2op_wad,sw2op_wcs,output_header,output_payload);
  
  modport output_logic(input clk,rst,running2_slot,bank2_sel,header2_present,header_present, bank_sel, sys_status, output_header, output_payload, mem_clr, parallel_in, clk10,clk80, running_slot,sw2op_wad,sw2op_wcs, output serial_out);
  
  
endinterface
