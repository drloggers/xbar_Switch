// No Contention child class. Generates unique frames

class contention_by_invalid_frame extends stimulus_gen;
      
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
			          if(i==3 && j==3) begin
			         packgen(i,j,tx_packet[i].header);
			         tx_packet[i].payload=8'hAA;
			         end
			         else if(i==3 && j==2) begin
			         tx_packet[i].header = {1'b0,3'b011,2'b11,1'b0,1'b1}; 
			         tx_packet[i].payload=8'h03;
			         end
			         else begin
			          tx_packet[i].header='0;
			          tx_packet[i].payload=8'hCC;
			          end
			         // packgen($random(),i*j%19,tx_packet[i].header);
			         
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


