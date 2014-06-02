import xbar_pkg::*;

module serializer(input clk,rst,load,[packet_width+1:0]parallel_in, output serial_out);
 
 logic [packet_width+1:0]data;
 
 always_ff@(posedge clk)
  begin
     if(!rst)
       data<=0;
     else if(load)
      data<=parallel_in;
     else 
      data <= {data[packet_width:0],1'b0};

  end

assign serial_out = data[packet_width+1];
//assign serial_out = (load==1)? parallel_in[packet_width+1]:data[packet_width];


endmodule