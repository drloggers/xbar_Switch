//Stimulus Gen virtual base class
//Provides template for child classes

virtual class stimulus_gen ;

		xtlm_fifo #(bit[(packet_width*ports*2)-1:0]) driverChannel;
    full_packet [ports-1:0] tx_packet;
		function new();			//Constructor 
			begin
				driverChannel = new ("top.input_pipe");		
			
				
			end
		endfunction
		
		task packgen;
      input [2:0]port; input [1:0]slot; output packet packet;
      logic parity; int choice;
      begin
        parity = ~(^{1'b1,port,slot,1'b0});
        if(error == 1)
         begin
           choice=$urandom_range(1,4);
           if(choice%2) parity=~parity;
         end
        packet={1'b1,port,slot,1'b0,parity};
    //$display("Packet Is=%p",packet);
      end
      endtask

		pure virtual task run();
		 

	endclass