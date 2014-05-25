// Input Logic. 
// Receives frames in the memory. 

import xbar_pkg::*;

module input_block(xbar_sys_if.input_logic port);
 
   

des  deserializer (.clk(port.clk),.rst(port.rst),.serial_in(port.serial_in),.decoded_out(port.decoded_out));


/*genvar instances;
generate
  for(instances=0; instances< ports; instances+=1) begin
  des  d[instances] (.port(serdes_port[instances]));
  end
endgenerate */ 

 
  
//Memory for input block. 
logic [packet_width-1:0]header[ports-1:0];
logic [packet_width-1:0]payload[ports-1:0];
logic header_in;

always_ff@(posedge port.clk)
begin
    if(!port.rst)
    header_in<=1;
    else begin:reset_else
            
              
      if(port.clk10) begin:clk10_if
                    
      header_in <= ~header_in;
      
      if(!header_in)begin
          header=port.decoded_out;
              end
      else begin
        payload=port.decoded_out;
        
        end
        
      
      end:clk10_if
    end:reset_else
end

always_comb
begin
  unique case(port.mux_sel)
    0: port.in2sw_out = {header[0],payload[0]};
    1: port.in2sw_out = {header[1],payload[1]};
    2: port.in2sw_out = {header[2],payload[2]};
    3: port.in2sw_out = {header[3],payload[3]};
    4: port.in2sw_out = {header[4],payload[4]};
    5: port.in2sw_out = {header[5],payload[5]};
    6: port.in2sw_out = {header[6],payload[6]};
    7: port.in2sw_out = {header[7],payload[7]};
  endcase
end


  
endmodule 