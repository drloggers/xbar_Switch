//Counter

module counter #(parameter MOD=80)
  (input clk,rst,enable,output logic [$clog2(MOD)-1:0]count);
 
 always_ff@(posedge clk)
 begin
    if(!rst)
     count<=MOD-1;
    else begin
      if(enable)begin
        if(count==MOD-1)
         count<=0; 
       else
        count<=count+1;     
     end
   end
   
 end
endmodule
