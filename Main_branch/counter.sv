//Counter

module counter #(parameter MOD=80)
  (input clk,rst,output logic [$ceil($clog2(MOD))-1:0]count);
 
 always_ff@(posedge clk)
 begin
    if(!rst)
     count<=0;
    else begin
        
        count<=count+1;     
        if(count==MOD)begin
         count<=1;
        end
   end
   
 end
endmodule
