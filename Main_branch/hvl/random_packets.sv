
// No Contention child class. Generates unique frames

class random_packets extends stimulus_gen;
      random_packet_data_generator RPDG;
      function new();
      begin
        super.new();
      end
    endfunction
    
  
		  task run();
		    begin
		       RPDG = new();
		    repeat(2)				
			   begin	
			    
			      
		      for(int j=0;j<slots;j++)
		      begin
			     for(int i=0;i<ports;i++)
			       begin
			         assert(RPDG.randomize());
			         packgen(RPDG.port_address,RPDG.slot_id,tx_packet[i].header);
			         tx_packet[i].payload = i+j;
			        // $display("%p ::::: %p ", tx_packet[i].header,tx_packet[i].payload.payload);
			    		 end
			     for(int i=0; i<ports; i++)
			     sent_queue.push_back(tx_packet[i]);
 			   driverChannel.put(tx_packet);
			 
			 
			 //foreach(tx_packet[i])
			 //$display("\nHVL: Port %0d Sent Header=%p   Payload=%p",i,tx_packet[i].header,tx_packet[i].payload.payload);

		end
   end
   repeat(56)
   begin
		 tx_packet=0;
		 for(int i=0; i<ports; i++)
		 sent_queue.push_back(tx_packet[i]);
		 driverChannel.put(tx_packet);
		 
		
		 //foreach(tx_packet[i])
		 //$display("\nHVL: Port %0d Sent Header=%p   Payload=%p",i,tx_packet[i].header,tx_packet[i].payload.payload);
	 end
		     
    	driverChannel.flush_pipe;		
       end        
		endtask
               
    endclass

