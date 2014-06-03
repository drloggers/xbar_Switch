//Dummy Encoder

module encoder (input clk,rst,input [7:0]data,output [9:0] encoded_out);

assign encoded_out={2'b00,data};

endmodule