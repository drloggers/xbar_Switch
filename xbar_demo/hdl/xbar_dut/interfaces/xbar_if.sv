/*
ECE 571 - Intro to SystemVerilog. Spring 2014
Design & Verification of 8x8 Time-Space Crossbar Switch
Sameer Ghewari, Sanket Borhade 
*/

// This is primary interface of the system for connection to the outer world

import xbar_pkg::*;

interface xbar_if(input clk,rst);

logic [ports-1:0]serial_in;
logic [ports-1:0]serial_out;
logic [$clog2(slots)-1:0]running_slot;
logic header_present,clk10,clk20;

endinterface
