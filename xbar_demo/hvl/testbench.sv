// Testbench class

class testbench;

scoreboard scb;
stimulus_gen stim_gen;

function new(string testcase);
  begin
    stim_gen = testcase_factory::return_testcase(testcase);
    scb = new();
  end
endfunction
		
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
endclass