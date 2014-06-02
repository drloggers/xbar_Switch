import xbar_pkg::*;

module xbar_tb(input clk,rst, input packet [ports-1:0]data, output [7:0]serial2_out);


xbar_if xbar_pins(.clk(clk),.rst(rst));
xbar_if xbar_pins1(.clk(clk),.rst(rst));

assign xbar_pins1.serial_in = xbar_pins.serial_out;
assign serial2_out = xbar_pins1.serial_out;

xbar xbar_DUT(xbar_pins);
xbar xbar_DUT1(xbar_pins1);


genvar me;
generate
  for(me=0;me<ports;me++)
   ser sez(.clk(clk),.rst(rst),.clk10(xbar_pins.clk10),.data(data[me]),.serial_out(xbar_pins.serial_in[me]));
endgenerate



endmodule
