/***************************************
* package for 8b-10b Encoder-Decoder
*
* Created on 26th April 2014
***************************************/
module b5b6(
            input [4:0]EDCBA,
            input disparity,
            output reg[5:0]abcdei);
  
 always_comb begin
   if(disparity == 0) begin
   case(EDCBA)
     0: abcdei = 6'b011000;
     1: abcdei = 6'b100010;
     2: abcdei = 6'b010010; 
     3: abcdei = 6'b110001;
     4: abcdei = 6'b001010;
     5: abcdei = 6'b101001;
     6: abcdei = 6'b011001;
     7: abcdei = 6'b000111;
     8: abcdei = 6'b000110;
     9: abcdei = 6'b100101;
    10: abcdei = 6'b010101;
    11: abcdei = 6'b110100;
    12: abcdei = 6'b001101;
    13: abcdei = 6'b101100;
    14: abcdei = 6'b011100;
    15: abcdei = 6'b101000;
    16: abcdei = 6'b100100;
    17: abcdei = 6'b100011;
    18: abcdei = 6'b010011;
    19: abcdei = 6'b110010;
    20: abcdei = 6'b001011;
    21: abcdei = 6'b101010;
    22: abcdei = 6'b011010;
    23: abcdei = 6'b000101;
    24: abcdei = 6'b001100;
    25: abcdei = 6'b100110;
    26: abcdei = 6'b010110;
    27: abcdei = 6'b001001;
    28: abcdei = 6'b001110;
    29: abcdei = 6'b010001;
    30: abcdei = 6'b100001;
    31: abcdei = 6'b010100;
   endcase
 end
 else begin
   case(EDCBA)
     0: abcdei = 6'b100111;
     1: abcdei = 6'b011101;
     2: abcdei = 6'b101101; 
     3: abcdei = 6'b110001;
     4: abcdei = 6'b110101;
     5: abcdei = 6'b101001;
     6: abcdei = 6'b011001;
     7: abcdei = 6'b111000;
     8: abcdei = 6'b111001;
     9: abcdei = 6'b100101;
    10: abcdei = 6'b010101;
    11: abcdei = 6'b110100;
    12: abcdei = 6'b001101;
    13: abcdei = 6'b101100;
    14: abcdei = 6'b011100;
    15: abcdei = 6'b010111;
    16: abcdei = 6'b011011;
    17: abcdei = 6'b100011;
    18: abcdei = 6'b010011;
    19: abcdei = 6'b110010;
    20: abcdei = 6'b001011;
    21: abcdei = 6'b101010;
    22: abcdei = 6'b011010;
    23: abcdei = 6'b111010;
    24: abcdei = 6'b110011;
    25: abcdei = 6'b100110;
    26: abcdei = 6'b010110;
    27: abcdei = 6'b110110;
    28: abcdei = 6'b001110;
    29: abcdei = 6'b101110;
    30: abcdei = 6'b011110;
    31: abcdei = 6'b101011;
   endcase
 end
 end
  
  
endmodule

/*assign  i = (~A&~B&~C&D&E)|(~A&~B&C&~D&E)|(~A&B&~C&~D&E)|(A&B&~C&~D&~E)|(A&B&~C&D&E)|(A&B&C&~D&E)|(A&~B&~C&~D&~E)|(A&~B&C&~D&~E)|(A&~B&C&D&E)|(~A&C&D&~E)|(~A&B&D&~E)|(~A&B&C&~E)|(~A&B&C&D);
 assign  e = (~A&B&C&D&~E)|(A&~B&~C&~D&~E)|(~A&~B&~C&D)|(~A&~B&C&~D)|(~B&~C&D&E)|(~A&~B&C&E)|(~B&C&~D&E)|(~A&B&~C&~D)|(~A&B&~C&E)|(~A&B&~D&E)|(B&~C&~D&E);
 assign  d = (~B&~C&~D&E)|(~A&B&C&D)|(B&C&D&E)|(A&~C&~E)|(A&~D&~E)|(A&~C&~D)|(A&~B&~E)|(A&~B&~C)|(A&~B&~D);
 assign  c = (A&~B&C&D&E)|(~A&~C&~D&~E)|(A&~C&~D&E)|(~A&B&~C)|(~A&B&~D)|(A&B&~E);
 assign  b = (~A&~B&~D&~E)|(A&B&D&E)|(~A&~B&C)|(~B&C&~E)|(~A&C&~D)|(~B&C&~D)|(C&~D&~E);
 assign  a = (A&B&C&~D&E)|(~A&~B&~C&E)|(~A&~B&D)|(~A&~C&D)|(~B&~C&D)|(A&D&~E);
  */