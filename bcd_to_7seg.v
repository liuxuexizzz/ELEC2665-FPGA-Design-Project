module bcd_to_7seg (
    input  wire [3:0] 	bcd,    			// bcd code
    output wire [6:0] 	seg     			// 7-seg code
);

    // LUT
    wire [6:0] seg_show [0:9];
    assign seg_show[0] = 7'b1000000;
    assign seg_show[1] = 7'b1111001;
    assign seg_show[2] = 7'b0100100;
    assign seg_show[3] = 7'b0110000;
    assign seg_show[4] = 7'b0011001;
    assign seg_show[5] = 7'b0010010;
    assign seg_show[6] = 7'b0000010;
    assign seg_show[7] = 7'b1111000;
    assign seg_show[8] = 7'b0000000;
    assign seg_show[9] = 7'b0010000;

    // output according to the index
    assign seg = ( bcd <= 4'd9 ) 
                 ? seg_show[bcd] 
                 : 7'b1111111;    		// if out of range, all segments will be extinguished.

endmodule
