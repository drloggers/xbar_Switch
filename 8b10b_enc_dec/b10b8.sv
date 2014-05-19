module b10b8(
            output reg [7:0]data,
            input clk,
            input rst,
            input [9:0]encoded_val
);

  b4b3 b3(.HGF(data[7:5]),
          .disparity(disparity_out),
          .fghj(encoded_val[3:0]));
          
  b6b5 b5(.EDCBA(data[4:0]),
          .disparity(disparity_out),
          .abcdei(encoded_val[9:4]));
          
  disparity d(.data(encoded_val),
              .rst(rst),
              .clk(clk),
              .disparity(disparity_out));

endmodule