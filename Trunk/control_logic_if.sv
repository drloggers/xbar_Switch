//Control Logic Interface

import xbar_pkg::*;

interface control_logic_if(input clk,rst);
logic clk80,clk20,clk10;
logic[$clog2(ports)-1:0]mux_sel;
endinterface