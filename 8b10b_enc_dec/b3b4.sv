//

module b3b4(
            input [2:0]HGF,
            input disparity,
            output reg[3:0]fghj);
     
  always_comb begin
   if(disparity == 1'b0) begin
   case(HGF)
    0 : fghj = 4'b1011; 
    1 : fghj = 4'b1001;
    2 : fghj = 4'b0101;
    3 : fghj = 4'b1100;
    4 : fghj = 4'b1101;
    5 : fghj = 4'b1010;
    6 : fghj = 4'b0110;
    7 : fghj = 4'b0111;
   endcase
   end
   else begin
     case(HGF)
    0 : fghj = 4'b0100;
    1 : fghj = 4'b1001;
    2 : fghj = 4'b0101;
    3 : fghj = 4'b0011;
    4 : fghj = 4'b0010;
    5 : fghj = 4'b1010;
    6 : fghj = 4'b0110;
    7 : fghj = 4'b1000;
    
//7 111 0001 or 1110 or 1000 or 0111
     endcase
  end
  end
endmodule