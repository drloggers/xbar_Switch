interface serdes_if(input clk,rst);

wire serial_in;
wire serial_out;
wire load;
wire [7:0]parallel_out;
wire [7:0]parallel_in;

modport serializer(input clk,rst,input parallel_in, input load, output serial_out);

modport deserializer(input clk,rst,input serial_in, output parallel_out);

modport xbar(input serial_in,output serial_out);

//Add Assertion Based verification for 8b10b here
endinterface