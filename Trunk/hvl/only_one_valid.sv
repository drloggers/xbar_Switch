// No Contention child class. Generates unique frames

class only_one_valid extends stimulus_gen;
      
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
			         if(i==0 && j==0)
			         packgen(i,j,tx_packet[i].header);
			         else
			          tx_packet[i].header='0;
			         // packgen($random(),i*j%19,tx_packet[i].header);
			         tx_packet[i].payload=8'hAA;
			    		 end
			     for(int i=0; i<ports; i++)
			     sent_queue.push_back(tx_packet[i]);
 			   driverChannel.put(tx_packet);
			 
			 
			 //foreach(tx_packet[i])
			 //$display("\nHVL: Port %0d Sent Header=%p   Payload=%p",i,tx_packet[i].header,tx_packet[i].payload.payload);

		end
   end
   repeat(20)
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
