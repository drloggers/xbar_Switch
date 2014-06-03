//Control Logic
import xbar_pkg::*;


module control_logic#(parameter MOD=80)(xbar_sys_if.control_logic port);
  
wire [$clog2(MOD)-1:0] count80;
wire [$clog2(MOD/4)-1:0] count20;
wire [$clog2(MOD/8)-1:0] count10;

 
counter #(.MOD(MOD))counter80(.clk(port.clk),.rst(port.rst),.enable('1),.count(count80));
counter #(.MOD(MOD/4)) counter20(.clk(port.clk),.rst(port.rst),.enable('1),.count(count20));
counter #(.MOD(MOD/8)) counter10(.clk(port.clk),.rst(port.rst),.enable('1),.count(count10));

always_ff@(posedge port.clk)
begin
    if(!port.rst)
      begin
      port.running_slot<='1;
      port.header_present<='1;
      port.bank_sel <='1;
      port.sys_status <= '0;
      port.header2_present <= '0;
      port.bank2_sel <= '0;
      port.running2_slot <= '0;
     
       end
    else 
    begin
      
      if(count80==78)
        begin
           port.bank2_sel <=~port.bank2_sel;
           
         if(port.sys_status <3)
          port.sys_status <= port.sys_status+1; 
        end
          
      if(count80==79)
        begin
        port.bank_sel <=~port.bank_sel;
        end
      
      
    if(count20==19)
      begin
          port.running_slot <= port.running_slot + 1;
      end
      
       if(count20==18)
      begin
          port.running2_slot <= port.running2_slot + 1;
      end
    
    
    if(count10==9)
          port.header_present <= ~port.header_present; 
          
          if(count10==8)
          port.header2_present <= ~port.header2_present; 
      //$display("Running Slot=%d",port.running_slot);
    end
end
  
always_comb
begin
  if(count80==79)
    port.clk80=1;
  else
    port.clk80=0;
    
  if(count20==19)
    port.clk20=1;
  else
    port.clk20=0;
    
 /* if(!((count80-1)%10))
    port.load=1;
  else
    port.load=0; */
    
    if(count20==19)
    port.load=1;
  else
    port.load=0;
    
    if(count10==9)
    port.clk10=1;
    else
    port.clk10=0; 
    
   
  if(count80<ports*slots)
    port.mux_sel=count80;
  else
    begin
    if(count80<=78)
    port.mux_sel=ports*slots-1;
  else
    port.mux_sel=0;
  end
    

  if(count80>=71 && count80<=74)
    port.mem_clr =1;
  else
    port.mem_clr=0;
    
  if(count80>32)
    port.swdone = 1;
  else
    port.swdone = 0;
   
        
end  

endmodule 