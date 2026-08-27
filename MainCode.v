module MainCode (
    input  wire        		CLK_50MHz,    // 50MHz clk
    input  wire        		rst_n,        // reset(effective low)
    input  wire        		StartStop,    // start/stop
    input  wire        		ModeSel,      // mode select：0 Stopwatch（100Hz），1 count down（1Hz）

    output wire	[6:0]  	HexMSBH,      // MSB 7-seg
    output wire	[6:0]  	HexMSBL,      // MSB 7-seg
    output wire	[6:0]		HexLSBH,      // LSB 7-seg
    output wire	[6:0]  	HexLSBL,      // LSB 7-seg
    output wire				DOT           // dot control
);


    // clock divider：50MHz → 100Hz / 1Hz
    wire					 clk100Hz, clk1Hz;
	 
    ClockDivider u_clkdiv (
        .CLK_50MHz 	 (CLK_50MHz),
        .rst_n     	 (rst_n),
        .CLK_100Hz 	 (clk100Hz),
        .CLK_1Hz   	 (clk1Hz)
    );

	 
    // mode-driven clock selection: 100Hz for stopwatch, 1Hz for timer.
    wire					 select_clk;
    assign 				 select_clk = ModeSel ? clk1Hz : clk100Hz;

	 
    // parameter (ModeSel = 0 → Stopwatch; = 1 → Timer)
    wire	[7:0]			 ResetValLSB = 8'd0;
    wire	[7:0]			 MaxValLSB   = 8'd99;
    wire	[7:0] 		 ResetValMSB = 8'd0;
    wire	[7:0] 		 MaxValMSB   = 8'd99;

	 
    // core counting logic
    wire [7:0] LSBbinaryout, MSBbinaryout;
    TimerCoreLogic u_timer (
        .clk          (select_clk),
        .rst_n        (rst_n),
        .StartStop    (StartStop),
        .ResetValLSB  (ResetValLSB),
        .MaxValLSB    (MaxValLSB),
        .ResetValMSB  (ResetValMSB),
        .MaxValMSB    (MaxValMSB),
        .LSBbinaryout (LSBbinaryout),
        .MSBbinaryout (MSBbinaryout)
    );

	 
    // Binary to Seven-Segment Code (Internal Reverser for Up and Down Counting)
    SevenSegEncoder u_seg (
        .LSBBinary 	 (LSBbinaryout),
        .MSBBinary 	 (MSBbinaryout),
        .ModeSel   	 (ModeSel),
        .HexMSBH   	 (HexMSBH),
        .HexMSBL   	 (HexMSBL),
        .HexLSBH   	 (HexLSBH),
        .HexLSBL   	 (HexLSBL)
    );

	 
    // Decimal point blinking: Blinking at the same frequency as the selected clock
    assign DOT = select_clk;

	 
endmodule



