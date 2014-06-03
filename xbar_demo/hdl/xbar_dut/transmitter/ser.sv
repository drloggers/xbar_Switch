//Dummy Serializer

import xbar_pkg::*;
module ser(input clk,rst,clk10, input [packet_width-1:0]data, output serial_out);
  
  
  wire [packet_width+1:0]encoded_val;
  //b10b8 decoder(.decoded_val(data),.clk(pins.clk),.rst(pins.rst),.data(pins.parallel_out));
 
   b8b10 encoder(.clk(clk),.rst(rst),.enable(clk10),.encoded_out(encoded_val),.data(data));
      
  serializer sez(.clk(clk),.rst(rst),.load(clk10),.serial_out(serial_out),.parallel_in(encoded_val));
 
  
endmodule 
