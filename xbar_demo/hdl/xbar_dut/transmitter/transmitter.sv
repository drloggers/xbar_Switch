// Transmitter
import xbar_pkg::*;

module transmitter( input clk,rst,clk10, input packet [ports-1:0]data, output [ports-1:0] serial_out);


genvar me;
generate
  for(me=0;me<ports;me++)
   ser sez(.clk(clk),.rst(rst),.clk10(clk10),.data(data[me]),.serial_out(serial_out[me]));
endgenerate

endmodule 


