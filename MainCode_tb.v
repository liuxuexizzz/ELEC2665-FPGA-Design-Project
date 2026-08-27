`timescale 1ns/1ps

module MainCode_tb;

    reg  				CLK_50MHz = 0;
    reg  				rst_n      = 0;
    reg  				StartStop  = 0;
    reg  				ModeSel    = 0;

    wire [6:0] 		HexMSBH, HexMSBL, HexLSBH, HexLSBL;
    wire       		DOT;

    MainCode uut (
        .CLK_50MHz 	(CLK_50MHz),
        .rst_n      	(rst_n),
        .StartStop  	(StartStop),
        .ModeSel    	(ModeSel),
        .HexMSBH    	(HexMSBH),
        .HexMSBL    	(HexMSBL),
        .HexLSBH    	(HexLSBH),
        .HexLSBL    	(HexLSBL),
        .DOT        	(DOT)
    );

	 
    // system clk 50MHz, period 20ns
    always #10 CLK_50MHz = ~CLK_50MHz;

	 
    // show message
    initial begin
        $monitor("T=%0t | ModeSel=%b rst_n=%b StartStop=%b | MSBH=%h MSBL=%h LSBH=%h LSBL=%h DOT=%b",
                 $time, ModeSel, rst_n, StartStop, HexMSBH, HexMSBL, HexLSBH, HexLSBL, DOT);
    end

	 
	 initial begin
		  // reset
		  rst_n = 0; #100; rst_n = 1; #100;
		 
		  // mode A
		  ModeSel   = 0;
		  StartStop = 1;
		  
		  // wait 20 ms (100 Hz output for 2 cycles)
		  #20000000;
		  StartStop = 0;
		 
		 
		  // mode B
		  rst_n     = 0; #100; rst_n = 1; #100;
		  ModeSel   = 1;
		  StartStop = 1;
		  
		  // wait 2 s (2 cycles output at 1 Hz)
		  #2000000000;
		  StartStop = 0;
		 
		  $stop;
	 end


endmodule
