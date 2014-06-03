// No Contention child class. Generates unique frames

class message extends stimulus_gen;
      int message_file;
 reg r;

      function new();
      begin
        super.new();
      end
    endfunction
    logic [7:0] message_arr[32]= {"H","E","L","L","O"," ","V","E","L","O","C","E",",","Y","O","U"," ","A","R","E"," ","T","O","O"," ","F","A","S","T",".",".","."};
   //  string message_arr[32];
		  task run();
		    begin
		     /* message_file=$fopen("message_file.txt","r");
		      while(!$feof(message_file)) begin
		        r = $fscanf(message_file,"%s",$cast(message_arr));
		        end*/
		      
		    repeat(2)				
			   begin	
			int k =0;
		      for(int j=0;j<slots;j++)
		      begin
			     for(int i=0;i<ports;i++)
			       begin
			         packgen(i,j,tx_packet[i].header);
			         // packgen($random(),i*j%19,tx_packet[i].header);
			        tx_packet[i].payload=message_arr[k++];
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
