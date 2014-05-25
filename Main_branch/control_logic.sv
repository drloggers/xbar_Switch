//Control Logic
import xbar_pkg::*;


module control_logic#(parameter MOD=80)(xbar_sys_if.control_logic port);
  
wire [$ceil($clog2(MOD))-1:0] count80;
wire [$ceil($clog2(MOD/4))-1:0] count20;

 
counter #(.MOD(MOD))counter80(.clk(port.clk),.rst(port.rst),.count(count80));
counter #(.MOD(MOD/4)) counter20(.clk(port.clk),.rst(port.rst),.count(count20));
   

  
always_comb
begin
  if(!(count80%MOD))
    port.clk80=1;
  else
    port.clk80=0;
    
  if(!(count20%20))
    port.clk20=1;
  else
    port.clk20=0;
    
  if(!((count80-1)%10))
    port.clk10=1;
  else
    port.clk10=0; 
    
  if(count20>ports)
    port.mux_sel=ports-1;
  else
    port.mux_sel=count20-1;
   
        
end  

endmodule 