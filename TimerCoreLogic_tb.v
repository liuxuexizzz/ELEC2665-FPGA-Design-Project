`timescale 1ns/1ps

module TimerCoreLogic_tb;

    reg         clk;
    reg         rst_n;
    reg         StartStop;

    reg 	[7:0]  ResetValLSB, MaxValLSB;
    reg 	[7:0]  ResetValMSB, MaxValMSB;

    wire [7:0]  LSBbinaryout;
    wire [7:0]  MSBbinaryout;

	 
    TimerCoreLogic #(
        .RESET_VAL_LSB	(8'd0),
        .MAX_VAL_LSB  	(8'd5),
        .RESET_VAL_MSB	(8'd0),
        .MAX_VAL_MSB  	(8'd3)
    ) uut (
        .clk         	(clk),
        .rst_n       	(rst_n),
        .StartStop   	(StartStop),
        .ResetValLSB 	(ResetValLSB),
        .MaxValLSB   	(MaxValLSB),
        .ResetValMSB 	(ResetValMSB),
        .MaxValMSB   	(MaxValMSB),
        .LSBbinaryout	(LSBbinaryout),
        .MSBbinaryout	(MSBbinaryout)
    );

	 
    // system clk
    initial 	clk = 1'b0;
    always #5 	clk = ~clk;

	 
    // reset, start/stop
    initial begin
        // initial value
        ResetValLSB 	= 8'd0;  
		  MaxValLSB 	= 8'd5;		// reaches 5, overflows by 1
		  
        ResetValMSB 	= 8'd0;  
		  MaxValMSB 	= 8'd3;		// reaches 3, overflows by 1
		  
        rst_n       	= 1'b0;
        StartStop   	= 1'b0;
        #20;

        // release and reset
        rst_n = 1'b1;
        #10;

        // start
        StartStop = 1'b1;
        #200;

        // stop
        StartStop = 1'b0;
        #30;

        // restart
        StartStop = 1'b1;
        #2000;

        $display("test finish");
        $stop;
    end

	 
    initial begin
        $display(" time(ns) | LSB | MSB ");
        $monitor(" %8t | %3d | %3d", $time, LSBbinaryout, MSBbinaryout);
    end

	 
endmodule
