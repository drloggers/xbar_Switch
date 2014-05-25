//Dummy Deserializer 
import xbar_pkg::*;
module des(input clk,rst, input[ports-1:0]serial_in, output [packet_width-1:0]decoded_out[ports-1:0]);
  
  
  wire [packet_width+1:0] parallel_out[ports-1:0];
  //b10b8 decoder(.decoded_val(data),.clk(pins.clk),.rst(pins.rst),.data(pins.parallel_out));
  
 genvar instances;
  generate
    for(instances=0; instances< ports; instances+=1) begin
      decoder b10b8(.clk(clk),.rst(rst),.encoded_in(parallel_out[instances]),.decoded_out(decoded_out[instances]));
      
      deserializer dsez(.clk(clk),.rst(rst),.serial_in(serial_in[instances]),.parallel_out(parallel_out[instances]));
  end
endgenerate 
  
 
  



endmodule 