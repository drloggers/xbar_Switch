/***************************************
* package for 8b-10b Encoder-Decoder
*
* Created on 26th April 2014
***************************************/
module b6b5(
            input [5:0]abcdei,
            input disparity,        
            output reg [4:0]EDCBA);
  
 always_comb begin
     case(abcdei)
     6'b011000: EDCBA =0;
     6'b100010: EDCBA =1;
     6'b010010: EDCBA =2; 
     6'b110001: EDCBA =3;
     6'b001010: EDCBA =4;
     6'b101001: EDCBA =5;
     6'b011001: EDCBA =6;
     6'b000111: EDCBA =7;
     6'b000110: EDCBA =8;
     6'b100101: EDCBA =9;
     6'b010101: EDCBA =10;
     6'b110100: EDCBA =11;
     6'b001101: EDCBA =12;
     6'b101100: EDCBA =13;
     6'b011100: EDCBA =14;
     6'b101000: EDCBA =15;
     6'b100100: EDCBA =16;
     6'b100011: EDCBA =17;
     6'b010011: EDCBA =18;
     6'b110010: EDCBA =19;
     6'b001011: EDCBA =20;
     6'b101010: EDCBA =21;
     6'b011010: EDCBA =22;
     6'b000101: EDCBA =23;
     6'b001100: EDCBA =24;
     6'b100110: EDCBA =25;
     6'b010110: EDCBA =26;
     6'b001001: EDCBA =27;
     6'b001110: EDCBA =28;
     6'b010001: EDCBA =29;
     6'b100001: EDCBA =30;
     6'b010100: EDCBA =31;
     6'b100111: EDCBA =0;
     6'b011101: EDCBA =1;
     6'b101101: EDCBA =2; 
     6'b110001: EDCBA =3;
     6'b110101: EDCBA =4;
     6'b101001: EDCBA =5;
     6'b011001: EDCBA =6;
     6'b111000: EDCBA =7;
     6'b111001: EDCBA =8;
     6'b100101: EDCBA =9;
     6'b010101: EDCBA =10;
     6'b110100: EDCBA =11;
     6'b001101: EDCBA =12;
     6'b101100: EDCBA =13;
     6'b011100: EDCBA =14;
     6'b010111: EDCBA =15;
     6'b011011: EDCBA =16;
     6'b100011: EDCBA =17;
     6'b010011: EDCBA =18;
     6'b110010: EDCBA =19;
     6'b001011: EDCBA =20;
     6'b101010: EDCBA =21;
     6'b011010: EDCBA =22;
     6'b111010: EDCBA =23;
     6'b110011: EDCBA =24;
     6'b100110: EDCBA =25;
     6'b010110: EDCBA =26;
     6'b110110: EDCBA =27;
     6'b001110: EDCBA =28;
     6'b101110: EDCBA =29;
     6'b011110: EDCBA =30;
     6'b101011: EDCBA =31;
   endcase
 end
  
  
endmodule

/*assign  i = (~A&~B&~C&D&E)|(~A&~B&C&~D&E)|(~A&B&~C&~D&E)|(A&B&~C&~D&~E)|(A&B&~C&D&E)|(A&B&C&~D&E)|(A&~B&~C&~D&~E)|(A&~B&C&~D&~E)|(A&~B&C&D&E)|(~A&C&D&~E)|(~A&B&D&~E)|(~A&B&C&~E)|(~A&B&C&D);
 assign  e = (~A&B&C&D&~E)|(A&~B&~C&~D&~E)|(~A&~B&~C&D)|(~A&~B&C&~D)|(~B&~C&D&E)|(~A&~B&C&E)|(~B&C&~D&E)|(~A&B&~C&~D)|(~A&B&~C&E)|(~A&B&~D&E)|(B&~C&~D&E);
 assign  d = (~B&~C&~D&E)|(~A&B&C&D)|(B&C&D&E)|(A&~C&~E)|(A&~D&~E)|(A&~C&~D)|(A&~B&~E)|(A&~B&~C)|(A&~B&~D);
 assign  c = (A&~B&C&D&E)|(~A&~C&~D&~E)|(A&~C&~D&E)|(~A&B&~C)|(~A&B&~D)|(A&B&~E);
 assign  b = (~A&~B&~D&~E)|(A&B&D&E)|(~A&~B&C)|(~B&C&~E)|(~A&C&~D)|(~B&C&~D)|(C&~D&~E);
 assign  a = (A&B&C&~D&E)|(~A&~B&~C&E)|(~A&~B&D)|(~A&~C&D)|(~B&~C&D)|(A&D&~E);
  */
