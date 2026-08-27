`timescale 1ns/1ps

module SevenSegEncoder_tb;
    reg  [7:0] 	LSBBinary;
    reg  [7:0] 	MSBBinary;
    reg        	ModeSel;

	 
    wire [6:0] 	HexMSBH, HexMSBL, HexLSBH, HexLSBL;

    SevenSegEncoder uut (
        .LSBBinary (LSBBinary),
        .MSBBinary (MSBBinary),
        .ModeSel   (ModeSel),
        .HexMSBH   (HexMSBH),
        .HexMSBL   (HexMSBL),
        .HexLSBH   (HexLSBH),
        .HexLSBL   (HexLSBL)
    );

	 
    initial begin
        $display("Time   Mode MSB LSB | MSBH    MSBL    LSBH    LSBL");

		  
        // mode A (ModeSel=0): show MSBBinary.LSBBinary
        ModeSel   = 0;
        MSBBinary = 8'd0;   LSBBinary = 8'd0;   #20;				// 00.00, mode = 0
        $display("%4dns     %b    %2d   %2d | %b %b  %b %b",
                 $time, ModeSel, MSBBinary, LSBBinary,
                 HexMSBH, HexMSBL, HexLSBH, HexLSBL);

        MSBBinary = 8'd34;  LSBBinary = 8'd12;  #20;				// 34.12, mode = 0
        $display("%4dns     %b    %2d   %2d | %b %b  %b %b",
                 $time, ModeSel, MSBBinary, LSBBinary,
                 HexMSBH, HexMSBL, HexLSBH, HexLSBL);

        MSBBinary = 8'd99;  LSBBinary = 8'd99;  #20;				// 99.99, mode = 0
        $display("%4dns     %b    %2d   %2d | %b %b  %b %b",
                 $time, ModeSel, MSBBinary, LSBBinary,
                 HexMSBH, HexMSBL, HexLSBH, HexLSBL);

					  
        // mode B (ModeSel=1): count down，show 2:00
        ModeSel   = 1;
        MSBBinary = 8'd0;   LSBBinary = 8'd0;   #20;				// 2.00, mode = 1
        $display("%4dns     %b    %2d   %2d | %b %b  %b %b",
                 $time, ModeSel, MSBBinary, LSBBinary,
                 HexMSBH, HexMSBL, HexLSBH, HexLSBL);

        // count down 00:05 -> show 01:55
        MSBBinary = 8'd0;   LSBBinary = 8'd5;   #20;				// 1.55, mode = 1
        $display("%4dns     %b    %2d   %2d | %b %b  %b %b",
                 $time, ModeSel, MSBBinary, LSBBinary,
                 HexMSBH, HexMSBL, HexLSBH, HexLSBL);

        // count down 02:00 -> show MSB=2,LSB=0
        MSBBinary = 8'd2;   LSBBinary = 8'd0;   #20;				// 0.00, mode = 1
        $display("%4dns     %b    %2d   %2d | %b %b  %b %b",
                 $time, ModeSel, MSBBinary, LSBBinary,
                 HexMSBH, HexMSBL, HexLSBH, HexLSBL);

					  
        $display("test finish");
        $stop;
    end
	 
	 
endmodule
