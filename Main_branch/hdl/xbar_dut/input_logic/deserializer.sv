import xbar_pkg::*;

module deserializer(input clk,rst,serial_in, output [packet_width+1:0]parallel_out );
 
 logic [packet_width:0] data;
  assign parallel_out = {data,serial_in};
 always_ff@(posedge clk)
  begin
   if(!rst)
   data <= '0;
  else
    data <= {data[packet_width-1:0],serial_in};
  end



endmodule