// Output Logic


import xbar_pkg::*;

module output_logic(xbar_sys_if.output_logic port);

localparam banks=2;
assign primeup = port.sys_status[1];
genvar instances;
generate
  for(instances=0;instances<ports;instances++)
   ser sez(.clk(port.clk),.rst(port.rst),.clk10(port.clk10),.data(port.parallel_in[instances]),.serial_out(port.serial_out[instances]));
endgenerate

wire[$clog2(slots)-1:0]count4;
counter #(.MOD(slots))counter4(.clk(port.clk),.rst(port.rst),.enable(port.mem_clr),.count(count4));

packet [slots-1:0]header0[ports-1:0];
packet [slots-1:0]header1[ports-1:0];
packet [slots-1:0]payload0[ports-1:0];
packet [slots-1:0]payload1[ports-1:0];

always_ff@(posedge port.clk)
begin
            
      if(!port.bank_sel)
        begin
          if(port.output_header.header.valid)
            begin
            header0[port.sw2op_wcs][port.sw2op_wad] <= port.output_header;
            payload0[port.sw2op_wcs][port.sw2op_wad] <= port.output_payload;
          end
        else
           begin
            //header0[port.sw2op_wcs][port.sw2op_wad] <= '0;
           // payload0[port.sw2op_wcs][port.sw2op_wad] <= '0;
          end
        end
      else
        begin
        if(port.output_header.header.valid)
        begin
          header1[port.sw2op_wcs][port.sw2op_wad] <= port.output_header;
          payload1[port.sw2op_wcs][port.sw2op_wad] <= port.output_payload;
        end  
        else
        begin
         // header1[port.sw2op_wcs][port.sw2op_wad] <= '0;
         // payload1[port.sw2op_wcs][port.sw2op_wad] <= '0;
        end  
      end  
      
      if(port.mem_clr)
        begin
          if(!port.bank_sel)
            begin
              foreach(header1[i])
              header1[i][count4] <= '0;
              foreach(payload1[i])
              payload1[i][count4] <= '0;
            end
          else
            begin
              foreach(header0[i])
              header0[i][count4] <= '0;
              foreach(payload0[i])
              payload0[i][count4] <= '0;
            end
        end
     
end

always_comb
begin
if(!port.header2_present)begin
        if(!port.bank2_sel)
          begin
            foreach(header1[i])
             port.parallel_in[i] = (primeup)? header1[i][port.running2_slot]:'0;
         end
        else
          begin
           foreach(header0[i])
           port.parallel_in[i] = (primeup)? header0[i][port.running2_slot]:'0;
          end  
      end
      else begin
        if(!port.bank2_sel)
          begin
            foreach(payload1[i])
            port.parallel_in[i] = (primeup)? payload1[i][port.running2_slot]:'0;
         end
        else
          begin
            foreach(payload0[i])
            port.parallel_in[i] = (primeup)? payload0[i][port.running2_slot]:'0;
          end
        end
      end
     endmodule 