// Scoreboard Class
// Performs checking with model

	class scoreboard;
	  
full_packet obtained_result[ports*slots-1:0];
		  full_packet expected_result[ports*slots-1:0];
		xtlm_fifo #(bit[(packet_width*ports*2)-1:0]) monitorChannel;
		function new ();
		begin
			monitorChannel = new ("top.output_pipe");
		 end
		endfunction

		task run();
		  full_packet [ports-1:0]rxpacket;
		  
		  int count=0;
		  int running_slot=0;
		  int primeup=0;
      
      
			while (1)
			begin
				
				monitorChannel.get(rxpacket);
				
			
			
				foreach(rxpacket[i])begin
				obtained_result[running_slot+(i*slots)]=rxpacket[i];//running_slot*ports+i
				//$display("rxpacket %0d Obtained Header %p Obtained Payload %p",i,rxpacket[i].header,rxpacket[i].payload.payload);
				end
				running_slot++;
				if(running_slot>3)
				  begin
				  running_slot=0;
				  if(primeup<=4)primeup++;    //First two sets of data are zero! Primeup in system.
				 
				
				  if(primeup==5)
				    begin
				    check();
				    if(debug > 0) begin
				    
				    $display("\t Received Data");
				    $display("----------------------------------------------------------------------");
				    $display("\n Port # \tSlot 0 \t\tSlot 1\t\tSlot 2\t\tSlot 3");
				    $display("\t      SP:SS:PL\t       SP:SS:PL\t       SP:SS:PL\t      SP:SS:PL");
				    for(int i=0;i<ports;i++) begin
				      $write("\n |%0d  ",i);
				      for(int j=0;j<slots;j++) begin
				        if(obtained_result[i+j].header.header.valid)
				        $write("\t|\t%0h:%0d:%0c",obtained_result[i*slots+j].header.header.port_address,obtained_result[i*slots+j].header.header.slot_id,obtained_result[i*slots+j].payload.payload);
				        else
				        $write("\t|\t     ");
				      end
				     end
				     $display("\n----------------------------------------------------------------------");
				     end
			   /*  $display("IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII");
			     $display("                     Obtained Result                        ");
			     foreach(obtained_result[i])
			     $display("\nLOC %0d  Header=%p Payload=%p",i,obtained_result[i].header.header, obtained_result[i].payload.payload);
			     $display("IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII");*/
				   end
      end
			
				
			end
		endtask
    
    task check();
      begin
        for(int j=0;j<slots;j++)
        for(int i=0;i<ports;i++)
			  expected_result[i*slots+j]=sent_queue.pop_front;
   				  if(debug > 2) begin
   				    $display("\t Data Sent By TestBench");
   				    $display("----------------------------------------------------------------------");
				   $display("\n Port # \tSlot 0 \t\tSlot 1\t\tSlot 2\t\tSlot 3");
				    $display("\t      SP:SS:PL\t       SP:SS:PL\t       SP:SS:PL\t      SP:SS:PL");
				    for(int i=0;i<ports;i++) begin
				      $write("\n |%0d  ",i);
				      for(int j=0;j<slots;j++) begin
				        if(expected_result[i+j].header.header.valid)
				        $write("\t|\t%0h:%0d:%0c",expected_result[i*slots+j].header.header.port_address,expected_result[i*slots+j].header.header.slot_id,expected_result[i*slots+j].payload.payload);
				        else
				        $write("\t|\t     ");
				      end
				     end
				     $display("\n----------------------------------------------------------------------");
				     end	
			for(int i=ports*slots-1; i>=0; i--)
      begin
    
      if(!(expected_result[i].header.header.valid))
        {expected_result[i].header,expected_result[i].payload} = '0;
      else
        begin
           for(int j=i-1; j>=0; j--)
           begin
            if(!(expected_result[j].header.header.valid))
            {expected_result[j].header,expected_result[j].payload} = '0;
          else
          if((expected_result[i].header.header.port_address) == (expected_result[j].header.header.port_address))
           if((expected_result[i].header.header.slot_id) == (expected_result[j].header.header.slot_id))
          {expected_result[j].header,expected_result[j].payload} = '0;
        end
       
    end
  end
    if(debug > 1) begin
      
				   $display("\t Gloden Model Memory");
				   $display("----------------------------------------------------------------------");
				   $display("\n Port # \tSlot 0 \t\tSlot 1\t\tSlot 2\t\tSlot 3");
				   $display("\t      SP:SS:PL\t       SP:SS:PL\t       SP:SS:PL\t      SP:SS:PL");
				  for(int i=0;i<ports;i++) begin
				   $write("\n |%0d  ",i);
				 for(int j=0;j<slots;j++) begin
				  if(expected_result[i+j].header.header.valid)
				   $write("\t|\t%0h:%0d:%0c",expected_result[i*slots+j].header.header.port_address,expected_result[i*slots+j].header.header.slot_id,expected_result[i*slots+j].payload.payload);
				 else
				 $write("\t|\t     ");
			end
			end
			$display("\n----------------------------------------------------------------------");
			end
  /*$display("EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE");
  $display("                        Expected Result                        ");
  foreach(expected_result[i])
	$display("\nLOC %0d Header %p Payload %p",i,expected_result[i].header.header,expected_result[i].payload.payload);
	$display("EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE");*/
	
			   
			   foreach(expected_result[i])
			//    result_PROPERTY: assert(expected_result[i]!==obtained_result[i])
			//      else $error("Expected result not met!!!");
			   if(expected_result[i]!==obtained_result[i])
			   begin			     $display("\nERROR: %0d Output Mismatch Expected %p, Obtained %p",error_count++,expected_result[i],obtained_result[i]);
			     
			     end 
			    // else
			    //$display("Success");
				//no_contention no_contention; $display("\n>>>>>Expected Result Port %d Header=%p    Payload=%p",i/slots,expected_result[i].header,expected_result[i].payload.payload);
           
        
      end
    endtask
    
   
    
    
	endclass