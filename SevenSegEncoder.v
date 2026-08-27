module SevenSegEncoder (
	
	input  [7:0]	LSBBinary,			//The LSB binary value input
	input  [7:0]	MSBBinary,			//The MSB bianry value input
	input 			ModeSel,				//Control signal for the interal Reverser
	
	output [6:0] 	HexMSBH,				//The 7-Seg display Signal for higer-digit in MSB
	output [6:0] 	HexMSBL,				//The 7-Seg display Signal for lower-digit in MSB
	output [6:0] 	HexLSBH,				//The 7-Seg display Signal for higer-digit in LSB
	output [6:0] 	HexLSBL				//The 7-Seg display Signal for lower-digit in LSB
	

);


    // 2-minute countdown: min
	 wire	[7:0] 	show_bin_min = ModeSel
			 ? (8'd2 - MSBBinary - (LSBBinary != 8'd0 ? 8'd1 : 8'd0))
			 : MSBBinary;

			 
    // 2-minute countdown: sec
    wire [7:0] 	show_bin_sec = ModeSel
			 ? ((LSBBinary == 8'd0) ? 8'd0 : 8'd60 - LSBBinary)
			 : LSBBinary;

			 
    // binary to BCD
    wire [3:0] 	bcd_min_tens, bcd_min_ones;
    wire [3:0] 	bcd_sec_tens, bcd_sec_ones;
	 
    bin2bcd u_b2b_min (
        .bin  (show_bin_min),
        .tens (bcd_min_tens),
        .ones (bcd_min_ones)
    );
	 
    bin2bcd u_b2b_sec (
        .bin  (show_bin_sec),
        .tens (bcd_sec_tens),
        .ones (bcd_sec_ones)
    );

	 
    // BCD counvert to 7-seg
    bcd_to_7seg u_seg_min_h (.bcd(bcd_min_tens), .seg(HexMSBH));
    bcd_to_7seg u_seg_min_l (.bcd(bcd_min_ones), .seg(HexMSBL));
    bcd_to_7seg u_seg_sec_h (.bcd(bcd_sec_tens), .seg(HexLSBH));
    bcd_to_7seg u_seg_sec_l (.bcd(bcd_sec_ones), .seg(HexLSBL));


endmodule



