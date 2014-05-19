//

module b4b3(
            output reg [2:0]HGF,
            input disparity,
            input[3:0]fghj);
     
  always_comb begin
   if(disparity == 1'b0) begin
   case(fghj)
    4'b1011: HGF = 0; 
    4'b1001: HGF = 1;
    4'b0101: HGF = 2;
    4'b1100: HGF = 3;
    4'b1101: HGF = 4;
    4'b1010: HGF = 5;
    4'b0110: HGF = 6;
    4'b0111: HGF = 7;
   endcase
   end
   else begin
     case(fghj)
    4'b0100: HGF = 0;
    4'b1001: HGF = 1;
    4'b0101: HGF = 2;
    4'b0011: HGF = 3;
    4'b0010: HGF = 4;
    4'b1010: HGF = 5;
    4'b0110: HGF = 6;
    4'b1000: HGF = 7;
    
//7 111 0001 or 1110 or 1000 or 0111
     endcase
  end
  end
endmodule
