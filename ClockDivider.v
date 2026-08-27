module ClockDivider (

	input wire 		CLK_50MHz, 		//50MHz clock input
	input wire 		rst_n, 			//Active-LOW reset signal
	
	output reg 		CLK_100Hz,	 	//100Hz clock; You can tweak the output type accordingly.
	output reg 		CLK_1Hz			//1Hz clock; You can tweak the output type accordingly.

);


	// Frequency divider counter
	reg [17:0] 		count_100;
	reg [25:0] 		count_1;
	

	// main logic: Reset triggered by the rising edge of the clock
	always @(posedge CLK_50MHz or negedge rst_n) begin
		 if (!rst_n) begin
			  // reset
			  count_100    <= 18'd0;
			  CLK_100Hz   	<= 1'b0;
			  count_1      <= 26'd0;
			  CLK_1Hz     	<= 1'b0;
			  
		 end else begin
			  // At 100 Hz frequency division, the counter flips when it reaches 250000 - 1
			  if (count_100 == 18'd250_000 - 1) begin  
					count_100   <= 18'd0;
					CLK_100Hz   <= ~CLK_100Hz;
					
			  // If not full, continue counting
			  end else begin
					count_100   <= count_100 + 1;
					
			  end

			  // At 1 Hz frequency division, the counter flips when it reaches 25000000 - 1
			  if (count_1 == 26'd25_000_000 - 1) begin
					count_1     <= 26'd0;
					CLK_1Hz     <= ~CLK_1Hz;
					
			  end else begin
					count_1     <= count_1 + 1;
					
			  end
		 end
	end
	
endmodule















