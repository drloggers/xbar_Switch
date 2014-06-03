// This is HVL for Booth's Multiplier verification environment that runs on the Workstation

import xtlm_pkg::*; // For trans-language TLM channels.
import xbar_pkg::*;

parameter debug=1;
int error_count=0;
typedef struct packed{
  packet header;
  packet payload;} full_packet;
  
full_packet sent_queue [$];
  
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
			/*     $display("IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII");
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
  
  /*$display("EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE");
  $display("                        Expected Result                        ");
  foreach(expected_result[i])
	$display("\nLOC %0d Header %p Payload %p",i,expected_result[i].header.header,expected_result[i].payload.payload);
	$display("EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE");*/
	
			   
			   foreach(expected_result[i])
			   if(expected_result[i]!==obtained_result[i])
			   begin			     $display("\nERROR: %0d Output Mismatch Expected %p, Obtained %p",i,expected_result[i],obtained_result[i]);
			     error_count++;
			     end
				// $display("\n>>>>>Expected Result Port %d Header=%p    Payload=%p",i/slots,expected_result[i].header,expected_result[i].payload.payload);
           
        
      end
    endtask
	endclass

	

	class stimulus_gen ;

		xtlm_fifo #(bit[(packet_width*ports*2)-1:0]) driverChannel;
   
		function new();			//Constructor 
			begin
				driverChannel = new ("top.input_pipe");		
			
				
			end
		endfunction
      
      task packgen;
      input [2:0]port; input [1:0]slot; output packet packet;
      begin
         packet={1'b1,port,slot,1'b0,~(^{1'b1,port,slot,1'b0})};
    //$display("Packet Is=%p",packet);
      end
      endtask

		task run;
		  full_packet [ports-1:0] tx_packet;
		  
		repeat(2)				
			begin	
			
		for(int j=0;j<slots;j++)
		begin
			for(int i=0;i<ports;i++)
			begin
			    packgen(i,j,tx_packet[i].header);
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
   repeat(64)
   begin
		 tx_packet=0;
		 for(int i=0; i<ports; i++)
		 sent_queue.push_back(tx_packet[i]);
		 driverChannel.put(tx_packet);
		 
		
		 //foreach(tx_packet[i])
		 //$display("\nHVL: Port %0d Sent Header=%p   Payload=%p",i,tx_packet[i].header,tx_packet[i].payload.payload);
	 end
		     
    	driverChannel.flush_pipe;		
                 
		endtask

	endclass


	module xbar_hvl;

		scoreboard scb;
		stimulus_gen stim_gen;
		
		task run();
		 	fork
			begin
				scb.run();
			end
			join_none
        
			fork			
			begin
				stim_gen.run();
			end			
			join_none
		endtask

		initial 
		fork
		 	    		
			scb = new();
			stim_gen = new();
			run();
			
			
		join_none

final
begin
  if(!error_count)
    $display("SUCCESS! All test cases passed without error");
end
	endmodule
 







