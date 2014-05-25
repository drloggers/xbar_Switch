import xbar_pkg::*;

module deserializer(input clk,rst,serial_in, output logic[packet_width+1:0]parallel_out);
 
 always_ff@(posedge clk)
  begin
  // $display("in %m port.serial_in=%0b",port.serial_in);
   parallel_out <= {parallel_out[packet_width:0],serial_in};
 // $display("in %m data=%0b",data);
  end



endmodule