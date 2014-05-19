//

module disparity(
                input [9:0]data,
                input rst,
                input clk,
                output logic disparity
                );
logic [2:0]sum;
assign sum = data[0] + data[1] + data[2] + data[3] + data[4] + data[5] + data[6] + data[7] + data[8] + data[9];

always_ff@(posedge clk) begin
  if(!rst) 
    disparity <= 1;
else begin
  if(sum < 5) disparity <= ~disparity;
  end
end

endmodule