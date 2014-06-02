module encdec 
  ( input clk,rst,
    input [7:0]data,
    output [7:0]decoded_data
  );
  
  wire [9:0]encoded;
  
  b8b10 encoder(.data(data),.clk(clk),.rst(rst),.encoded_val(encoded));
  b10b8 decoder(.encoded_val(encoded),.clk(clk),.rst(rst),.data(decoded_data));
  
endmodule 