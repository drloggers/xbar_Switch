//This is a top level testbench. HDL side. Contains XRTL Transactor
	import xbar_pkg::*;
	module top;

	//clk generation logic 

	reg clk,rst;
	//tbx clkgen
	initial
	begin
        clk=0;
        forever #5 clk=~clk;
	end

	//tbx clkgen
	initial 
	begin
		rst =0;
		#10 rst=1;
	end
	

	//Pipe Instantiation
	//Input Pipe Instantiation.  Receives Header (1 byte) and Payload (1 byte) together (2 bytes)
    	scemi_input_pipe #(.BYTES_PER_ELEMENT((2*ports*packet_width)/8),
                   .PAYLOAD_MAX_ELEMENTS((2*ports*packet_width)/8),
                   .BUFFER_MAX_ELEMENTS(100)
                   ) input_pipe(clk);

	//Output Pipe Instantiation.  Transmits Header (1 byte) and Payload (1 byte) together (2 bytes)

   	scemi_output_pipe #(.BYTES_PER_ELEMENT((2*ports*packet_width)/8),
                   .PAYLOAD_MAX_ELEMENTS(1),
                   .BUFFER_MAX_ELEMENTS(1)
                   ) output_pipe(clk);


//Crossbar 1 Interface & DUT Instantiation
	xbar_if xbar_pins1(.clk(clk),.rst(rst));
	xbar xbar_DUT1(xbar_pins1);

//Crossbar 2 Interface & DUT Instantiation
xbar_if xbar_pins2(.clk(clk),.rst(rst));
xbar xbar_DUT2(xbar_pins2);
int howmany=0;
assign xbar_pins2.serial_in = xbar_pins1.serial_out;
	//DUT Instantiation 
	

	packet [ports-1:0]data;
	packet [ports-1:0]result;

	typedef struct packed{
	  packet header;
	  packet payload;} full_packet;

	full_packet [ports-1:0]intemp,outtemp;
	
	transmitter tx(.clk,.rst,.clk10(xbar_pins1.clk10),.data,.serial_out(xbar_pins1.serial_in));

	receiver rx(.clk,.rst,.clk10(xbar_pins2.clk10),.serial_in(xbar_pins2.serial_out),.data(result));

	


	//XRTL FSM to obtain operands from the HVL side
	bit eom=0;
	reg [7:0] ne_valid=0;
	bit first_issued=0;
  int count;
  
	always@(posedge clk)
	begin
	  
	  if(!rst && !first_issued) begin
	    count<=0;
	    input_pipe.receive(1,ne_valid,intemp,eom);
	    first_issued<=1;
	    foreach(data[i])
      data[i] <= intemp[i].header;
	    end
	    
	    else
	begin
		 if(count==19)
		  count<=0;
		    else
		  count<=count+1;

    if(count==8 || count== 19)
      begin
         if(xbar_pins1.header_present)
         foreach(data[i])
         data[i] <= intemp[i].header;
         else
        foreach(data[i])
        data[i] <= intemp[i].payload;
      end
      
		if(count == 18)
		  begin
		    input_pipe.receive(1,ne_valid,intemp,eom);
		//foreach(intemp[i])
   //$display("Received for Port %d - Header %p  Payload  %p",i,intemp[i].header,intemp[i].payload.payload);
		      

		    end
		 
      
		if(count==1)
		begin
		  
		  first_issued<=0;
		  if(!first_issued) begin
		 output_pipe.send(1,outtemp,1); 	
		 //foreach(outtemp[i])
     //$display("howmany %0d HDL Sent for Port %d - Header %p  Payload  %p",howmany, i,outtemp[i].header,outtemp[i].payload.payload);
		 // howmany++;
		end
				end 

	if(xbar_pins1.clk10) 
          begin
            if(!xbar_pins1.header_present)
	           foreach(outtemp[i])
             outtemp[i].header <= result[i];
            else
          foreach(outtemp[i])
             outtemp[i].payload <= result[i];
          end
        end    
       
                   
	end


endmodule
