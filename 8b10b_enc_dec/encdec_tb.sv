module encdec_tb( input clk,rst,enable, output[7:0]decoded);

reg [7:0]val;

encdec DUT(.clk(clk),.rst(rst),.data(val),.decoded_data(decoded));

always@(posedge clk)
begin
  if(!rst)
    val<=0;
  else if(enable)
    val<=val+1;
  
end
endmodule