// No Contention child class. Generates unique frames

class no_valid_packets extends stimulus_gen;
      
      function new();
      begin
        super.new();
      end
    endfunction
    
     
		  task run();
		    begin
		    repeat(2)				
			   begin	
			
		      for(int j=0;j<slots;j++)
		      begin
			     for(int i=0;i<ports;i++)
			       begin
			         tx_packet[i].header= '0;
			         // packgen($random(),i*j%19,tx_packet[i].header);
			         tx_packet[i].payload=i+j;
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
