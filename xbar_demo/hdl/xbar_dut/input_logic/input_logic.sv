// Input Logic. 
// Receives frames in the memory. 

import xbar_pkg::*;

module input_logic(xbar_sys_if.input_logic port);
 

genvar instances;
generate
  for(instances=0; instances< ports; instances+=1) begin
  des  deserializer (.clk(port.clk),.rst(port.rst),.enable(port.clk10),.serial_in(port.serial_in[instances]),.decoded_out(port.decoded_out[instances]));
  end
endgenerate  

 
  
//Memory for input block. 
packet [slots-1:0]header0[ports-1:0];
packet [slots-1:0]header1[ports-1:0];
packet [slots-1:0]payload0[ports-1:0];
packet [slots-1:0]payload1[ports-1:0];


always_ff@(posedge port.clk)
begin
       
      if(port.clk10)
      begin
                   
      if(!port.header_present)begin
        if(!port.bank_sel)
          begin
            foreach(header0[i])
            begin
            if(port.decoded_out[i][0] == ~(^port.decoded_out[i][packet_width-1:1]))
             header0[i][port.running_slot] <= port.decoded_out[i];
              else
                 header0[i][port.running_slot] <= '0;
           end
          
          end
        else
          begin
            foreach(header1[i])
            begin
            if(port.decoded_out[i][0] == ~(^port.decoded_out[i][packet_width-1:1]))
            header1[i][port.running_slot] <= port.decoded_out[i]; 
          else
              header1[i][port.running_slot]  <= '0;
            end      
            end     
      end
      else begin
        if(!port.bank_sel)
          begin
            foreach(payload0[i])
             payload0[i][port.running_slot] <= port.decoded_out[i];
          end
        else
          begin
            foreach(payload1[i])
            payload1[i][port.running_slot] <= port.decoded_out[i];
            end
        
        end
        
      end
        
       
     
end

always_comb
begin
   if(!port.bank_sel)
        begin
          port.input_header =  header1[port.mux_sel[4:2]][port.mux_sel[1:0]];
          port.input_payload = payload1[port.mux_sel[4:2]][port.mux_sel[1:0]];
        end
      else
        begin
           port.input_header =  header0[port.mux_sel[4:2]][port.mux_sel[1:0]];
          port.input_payload = payload0[port.mux_sel[4:2]][port.mux_sel[1:0]];
        end
end


  
endmodule 