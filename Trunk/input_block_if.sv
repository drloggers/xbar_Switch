// Interface for Input Block 

import xbar_pkg::*;

interface input_block_if(input clk,rst);

  logic clk10;
  logic [ports-1:0]A;
  logic [$clog2(ports)-1:0]mux_sel;
  logic [2*packet_width-1:0]out;
  
    
endinterface