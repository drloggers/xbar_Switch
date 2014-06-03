//

module b8b10(
            input [7:0]data,
            input clk,
            input rst,
            input enable,
            output [9:0]encoded_out
);

  b3b4 b3(.HGF(data[7:5]),
          .disparity(disparity_out),
          .fghj(encoded_out[3:0]));
  b5b6 b5(.EDCBA(data[4:0]),
          .disparity(disparity_out),
          .abcdei(encoded_out[9:4]));
  disparity d(.data(encoded_out),
              .rst(rst),
              .clk(clk),
              .enable(enable),
              .disparity(disparity_out));


endmodule