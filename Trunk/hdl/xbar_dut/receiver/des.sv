



//Dummy Deserializer 
import xbar_pkg::*;
module des(input clk,rst,enable, input serial_in, output [packet_width-1:0]decoded_out);
  
  
  wire [packet_width+1:0] parallel_out;
  //b10b8 decoder(.decoded_val(data),.clk(pins.clk),.rst(pins.rst),.data(pins.parallel_out));
  
      b10b8 decoder (.clk(clk),.rst(rst),.enable(enable),.encoded_val(parallel_out),.data(decoded_out));
      
      deserializer dsez(.clk(clk),.rst(rst),.serial_in(serial_in),.parallel_out(parallel_out));

endmodule 