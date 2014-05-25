//Dummy Serializer

import xbar_pkg::*;
module ser(input clk,rst,clk10, input [packet_width-1:0]data[ports-1:0], output[ports-1:0]serial_out);
  
  
  wire [packet_width+1:0]encoded_val[ports-1:0];
  //b10b8 decoder(.decoded_val(data),.clk(pins.clk),.rst(pins.rst),.data(pins.parallel_out));
  
 genvar instances;
  generate
    for(instances=0; instances< ports; instances+=1) begin
      encoder b8b10(.clk(clk),.rst(rst),.encoded_out(encoded_val[instances]),.data(data[instances]));
      
      serializer sez(.clk(clk),.rst(rst),.load(clk10),.serial_out(serial_out[instances]),.parallel_in(encoded_val[instances]));
  end
endgenerate 
  
 
  



endmodule 
