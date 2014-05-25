//Dummy Decoder

module decoder (input clk,rst, input [9:0] encoded_in, output [7:0]decoded_out);

assign decoded_out=encoded_in[7:0];

endmodule