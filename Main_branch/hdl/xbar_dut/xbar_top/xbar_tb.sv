import xbar_pkg::*;

module xbar_tb;
int i;
logic clk,rst;reg load;
packet [ports-1:0]data;
packet [ports-1:0]result;

//tbx clkgen
initial
begin
  clk=0;
  forever #5 clk=~clk;
end


//tbx clkgen
initial
begin
 
  rst=0;
  #8;
  rst=1;
end

xbar_if xbar_pins(.clk(clk),.rst(rst));
xbar_if xbar_pins1(.clk(clk),.rst(rst));

assign xbar_pins1.serial_in = xbar_pins.serial_out;

xbar xbar_DUT(xbar_pins);
xbar xbar_DUT1(xbar_pins1);

 transmitter tx(.clk,.rst,.clk10(xbar_pins.clk10),.data,.serial_out(xbar_pins.serial_in));
 
 receiver rx(.clk,.rst,.clk10(xbar_pins.clk10),.serial_in(xbar_pins1.serial_out),.data(result));
 
 always@(posedge xbar_pins.clk10)
 begin
   if(!xbar_pins.header_present & rst)
     begin
     $display("******************Received Header Data**************************");
     foreach(result[i])
     $display("\nPort[%0d]Received Header=%p",i,result[i]);
     $display("*************************************************");
     end 
   else if(rst)
     begin 
     $display("##################Received Payload Data########################");
     foreach(result[i])
     $display("\nPort[%0d]Received Payload=%p",i,result[i].payload);
     $display("#################################################");
     end
 end
 
 always@(negedge xbar_pins.clk10)
 begin
   if(!xbar_pins.header_present & rst)
     begin
     $display("******************Transmitted Header Data**********************");
     foreach(data[i])
     $display("\nPort[%0d]Generated Header=%p",i,data[i]);
     $display("*************************************************");
     end 
   else if(rst)
     begin 
     $display("##################Transmitted Payload Data####################");
     foreach(data[i])
     $display("\nPort[%0d]Generated Payload=%p",i,data[i].payload);
     $display("#################################################");
     end
 end
 
initial

begin
   @(posedge rst);
  repeat(2) 
  begin
  for(int j=0;j<4;j++)
  begin  
  
    //Slot 0 Header
    foreach(data[i])
    begin
    packgen(i,j,data[i]);
    //$monitor("\nPort[%0d]Generated Data=%p",i,result[i]);
    end
    //Slot 0 Payload
    @(posedge xbar_pins.clk10);
    foreach(data[i])
    data[i]=i;
    @(posedge xbar_pins.clk10);
    
end  
end
    data='0;
end

task packgen;
input [2:0]port; input [1:0]slot; output packet packet;
begin
    packet={1'b1,port,slot,1'b0,~(^{1'b1,port,slot,1'b0})};
    //$display("Packet Is=%p",packet);
end
endtask


endmodule
