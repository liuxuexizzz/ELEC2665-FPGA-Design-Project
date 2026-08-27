module TimerCoreLogic #(
    // reset value of the counter and the wraparound value when the value reaches the upper limit
    parameter 		RESET_VAL_LSB = 8'd0,
    parameter 		MAX_VAL_LSB   = 8'd99,
    parameter 		RESET_VAL_MSB = 8'd0,
    parameter 		MAX_VAL_MSB   = 8'd99
)(


    input         clk,            // 100Hz or 1Hz clk
    input         rst_n,          // reset(effective low)
    input         StartStop,      // start/stop
    input  [7:0]  ResetValLSB,
    input  [7:0]  MaxValLSB,
    input  [7:0]  ResetValMSB,
    input  [7:0]  MaxValMSB,
    output [7:0]  LSBbinaryout,   // LSB counter
    output [7:0]  MSBbinaryout    // MSB counter
);


    wire	  [7:0] 		count_lsb;
    wire   [7:0] 		count_msb;
    wire       		carry_lsb = (count_lsb == MaxValLSB) & StartStop;	// overflow control: when lower bit reaches the upper limit and is running, a carry pulse is generated
    wire       		carry_msb = (count_msb == MaxValMSB) & carry_lsb;  // Overflow control: when higher bit reaches the upper limit and the low bit also generates a carry, a high-bit wraparound pulse is produced.
	 
    // output assignment
    assign	LSBbinaryout = count_lsb;
    assign	MSBbinaryout = count_msb;

	 
    // low-bit counter: rising edge driven
    ProgramCounter pc_lsb (
        .clk      (clk),
        .ResetVal (ResetValLSB),
        .LoadVal  (ResetValLSB),
        .reset    (~rst_n),
        .load     (carry_lsb),
        .inc      (StartStop),
        .PCoutput (count_lsb)
    );

	 
    // high-order counter: carry from the lower order driven
    ProgramCounter pc_msb (
        .clk      (clk),
        .ResetVal (ResetValMSB),
        .LoadVal  (ResetValMSB),
        .reset    (~rst_n),
        .load     (carry_msb),
        .inc      (carry_lsb),
        .PCoutput (count_msb)
    );

	 
endmodule




