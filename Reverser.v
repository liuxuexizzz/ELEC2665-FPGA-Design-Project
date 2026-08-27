module Reverser (
	
	input [7:0] 	RevIn,			//The 8-bit BCD value input. Tips that is two 4-bit BCDs
	input 			ModeSel,			//Control signal to make the counting upwards RevIn to Counting downwards RevOut (HIGH) or pass the RevIn to the RevOut (LOW).
	
	output [7:0] 	RevOut			//the 8-bit BCD value out
	
);


    // separate high and low bits
    wire [3:0] 	high_dig = RevIn[7:4];
    wire [3:0] 	low_dig  = RevIn[3:0];
	 

    // when ModeSel = 1, the high and low bits are respectively processed as 9-digit; otherwise, RevIn is directly output
    assign RevOut = ModeSel
                    ? { 4'd9 - high_dig,  4'd9 - low_dig  }
                    : RevIn;

endmodule


