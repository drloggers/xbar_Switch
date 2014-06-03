// This is HVL for Booth's Multiplier verification environment that runs on the Workstation

import xtlm_pkg::*; // For trans-language TLM channels.
import xbar_pkg::*;

int debug=0,error=0;
int error_count=1;
typedef struct packed{
  packet header;
  packet payload;} full_packet;
  
full_packet sent_queue [$];

`include "./hvl/random_packet_data_generator.sv";
`include "./hvl/stimulus_gen.sv";  
`include "./hvl/scoreboard.sv";
`include "./hvl/no_contention.sv";  
`include "./hvl/only_one_valid.sv";
`include "./hvl/assert_test.sv"; 
`include "./hvl/message.sv"; 
`include "./hvl/half_contention.sv"; 
`include "./hvl/contention_by_invalid_frame.sv"; 
`include "./hvl/no_valid_packets.sv";
`include "./hvl/random_packets.sv";
`include "./hvl/testcase_factory.sv";
`include "./hvl/testbench.sv";     

    
    
	module xbar_hvl;

		testbench tb;
		string testcase;
		

		initial 
		begin
		if($value$plusargs("TESTCASE=%s",testcase));
		if($value$plusargs("DEBUG=%d",debug));
		if($value$plusargs("ERROR=%d",error));
		    $display("***************************************************************************");
        $display("***************************************************************************\n");
		    $display("\t\tRunning TestCase %s \n",testcase);
		    $display("***************************************************************************");
        $display("***************************************************************************\n");
		   

		tb = new(testcase);
		tb.run(); 	    		
	
		end

final
begin
  if(!error_count) begin
    $display("***************************************************************************");
    $display("***************************************************************************\n");
    $display("\t\tSUCCESS! All test cases passed without error\n");
    $display("***************************************************************************");
    $display("***************************************************************************\n");
  end
  else
    begin
    $display("***************************************************************************");
    $display("***************************************************************************\n");
    $display("\t\tFAILURE! %0d cases failed\n",error_count-1);
    $display("***************************************************************************");
    $display("***************************************************************************\n");
    end
end
	endmodule
 







