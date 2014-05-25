import xbar_pkg::*;

module xbar_tb;

logic clk,rst;

//tbx clkgen
initial
begin
  clk=0;
  forever #5 clk=~clk;
end

logic [packet_width-1:0]data[ports-1:0];
//tbx clkgen
initial
begin
  rst=0;
  #8;
  rst=1;
  foreach(data[i])
  data[i]=$urandom();
  #200;
 // xbar_pins.serial_in=$urandom();
end

// Pipe Instantiation 


// 8b10b Serializer 
reg clk10;
xbar_if xbar_pins(.clk(clk),.rst(rst));
xbar xbar_DUT(xbar_pins);

wire[3:0]count10;
counter #(.MOD(10)) counter10(.clk(clk),.rst(rst),.count(count10));

ser sank(.clk,.rst,.clk10,.data,.serial_out(xbar_pins.serial_in));

always_comb
begin
 if(!(count10%10))
    clk10=1;
  else
    clk10=0;
end
endmodule