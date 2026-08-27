module bin2bcd (
    input  wire [7:0] 		bin,    			// binary in 0~255
    output wire [3:0] 		tens,   			// bcd out tens
    output wire [3:0] 		ones    			// bcd out ones
);


    wire [7:0]		bcd_value[0:8];
    assign 			bcd_value[0] = 8'd0;		// init

	 
    genvar i;
    generate
        for (i = 0; i < 8; i = i + 1) begin : gen_shift

            wire [3:0] cur_tens = bcd_value[i][7:4];
            wire [3:0] cur_ones = bcd_value[i][3:0];
				
            // if >=5 + 3
            wire [3:0] cor_tens = (cur_tens >= 5) ? (cur_tens + 4'd3) : cur_tens;
            wire [3:0] cor_ones = (cur_ones >= 5) ? (cur_ones + 4'd3) : cur_ones;
				
            // result after merging and correcting.
            wire [7:0] corrected = { cor_tens, cor_ones };
				
            // Shift left by 1 bit and assign the value of bin[7-i] to the least significant bit.
            assign bcd_value[i+1] = { corrected[6:0], bin[7-i] };
				
        end
    endgenerate

	 
    // assignment of high 4 bits / low 4 bits
    assign tens = bcd_value[8][7:4];
    assign ones = bcd_value[8][3:0];

	 
endmodule

