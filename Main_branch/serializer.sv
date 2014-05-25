import xbar_pkg::*;

module serializer(input clk,rst,load,[packet_width+1:0]parallel_in, output serial_out);
 
 logic [packet_width+1:0]data;
 assign serial_out = data[packet_width+1];
 
 always_ff@(posedge clk)
  begin
    if(load)
      data<=parallel_in;
     else 
      data <= {data[packet_width:0],1'b0};

  end



endmodule