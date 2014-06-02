// This is HVL for Booth's Multiplier verification environment that runs on the Workstation

import xtlm_pkg::*; // For trans-language TLM channels.
`include "config.v"
//File Handlers
int product_file;
int multiplicand_file;
int multiplier_file;

parameter debug=0;

	class scoreboard;

		xtlm_fifo #(bit[(data_width*2)-1:0]) monitorChannel;
		function new ();
		begin
			monitorChannel = new ("top.outputpipe");
			
			 product_file=$fopen("product.txt","w");
			$fwrite(product_file,"Product\n");
			
		end
		endfunction

		task run();
			while (1)
			begin
				longint product;
				monitorChannel.get(product);
				$fwrite(product_file,"%0d\n",product);
				
				if(debug)
				$display("Product=%d",product);
			end
		endtask
    
	endclass

	

	class stimulus_gen ;

		xtlm_fifo #(bit[(data_width*2)-1:0]) driverChannel;
		int m,r;
		
    
		function new();			//Constructor 
			begin
				driverChannel = new ("top.inputpipe");		
							
				multiplicand_file=$fopen("multiplicand.txt","w");
				multiplier_file=$fopen("multiplier.txt","w");
				$fwrite(multiplicand_file,"Multiplicand\n");
				$fwrite(multiplier_file,"Multiplier\n");
				
			end
		endfunction

		task run;
		  input [31:0]runs;
		  input [15:0]signs;
		  
		repeat(runs)				
			begin			
				
				case(signs)
				       "++": 
							begin
								if(randomize(m) with {m>0;m<((2**31)-1);})
								if(debug) $display("m=%d",m);
								if(randomize(r) with { r>0;r<((2**31)-1);})
								if(debug) $display("r=%d",r);
							end
						
						"--":
							begin
								if(randomize(m) with {m<0;m>(-(2**31));});
								if(debug) $display("m=%d",m);
								if(randomize(r) with {r<0;r>(-(2**31));});
							end
      
						"+-":
							begin
								if(randomize(m) with { m>0;m<((2**31)-1);});
								if(debug) $display("m=%d",m);
								if(randomize(r) with { r<0;r>((-2**31));});
								if(debug) $display("m=%d",m);         
							end 
							
						"-+":
							begin
								if(randomize(m) with {m<0;m>(-(2**31));});
								if(debug) $display("m=%d",m);
								if(randomize(r) with {r>0;r<((2**31)-1);});
								if(debug) $display("m=%d",m);       
							end
      
					default:
							begin
								if(randomize(m) with { m>0;m<50;});
								if(debug) $display("m=%d",m);
								if(randomize(r) with { r>0;r<20;});
								if(debug) $display("m=%d",m);								
							end
				endcase	
				
				driverChannel.put({m,r});
				$fwrite(multiplicand_file,"%0d\n",m);
				$fwrite(multiplier_file,"%0d\n",r);
			end
		       	
       	driverChannel.flush_pipe;		
                 
		endtask

	endclass


	module booth_hvl;

		scoreboard scb;
		stimulus_gen stim_gen;
		integer runs;
		reg [15:0]signs;

		task run();
		  integer i;
			fork
			begin
				scb.run();
			end
			join_none
        
			fork			
			begin
				stim_gen.run(runs,signs);
			end			
			join_none
		endtask

		initial 
		fork
		  if($value$plusargs("RUNS=%d",runs))
		    $display("Generating %d Operands",runs);
		    
		   if($value$plusargs("SIGNS=%s",signs))
		    $display("Generating Multiplicand with %c Sign and Multiplier with %c Sign",signs[15:8],signs[7:0]);
		    		
			scb = new();
			stim_gen = new();
			run();
			
			
		join_none

	endmodule
 



