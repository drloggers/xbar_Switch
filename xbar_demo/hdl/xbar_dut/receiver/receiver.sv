// Receiver
import xbar_pkg::*;

module receiver( input clk,rst,clk10, input [ports-1:0] serial_in, output packet [ports-1:0]data);


genvar me;
generate
  for(me=0;me<ports;me++)
   des  deserializer (.clk(clk),.rst(rst),.enable(clk10),.serial_in(serial_in[me]),.decoded_out(data[me]));
endgenerate

endmodule 



