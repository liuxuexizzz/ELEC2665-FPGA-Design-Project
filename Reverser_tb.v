`timescale 1ns/1ps

module Reverser_tb;
    reg  [7:0] 	RevIn;     // 8-bit BCD input
    reg        	ModeSel;   // Mode selection: 0 Direct; 1 Reverse
    wire [7:0] 	RevOut;    // 8-bit BCD output

    Reverser uut (
        .RevIn   (RevIn),
        .ModeSel (ModeSel),
        .RevOut  (RevOut)
    );

	 
    initial begin
        $monitor("Time=%0dns | RevIn=%b | ModeSel=%b => RevOut=%b",
                 $time, RevIn, ModeSel, RevOut);

        // test direct mode
        RevIn   = 8'b0010_0101;  	// High = 2, low = 5
        ModeSel = 1'b0;          	// mode 0
        #10;

        // test reverse mode
        RevIn   = 8'b0010_0101;  	// 2,5 →  7,4
        ModeSel = 1'b1;          	// mode 1
        #10;

        // test edge
        RevIn   = 8'h59;         	// 5,9 →  4,0
        ModeSel = 1'b1; #10;

        RevIn   = 8'h00;         	// 0,0 →  9,9
        ModeSel = 1'b1; #10;

        RevIn   = 8'h99;         	// 9,9 →  0,0
        ModeSel = 1'b1; #10;

		  $display("test finish");
        $stop;
    end

	 
	 
endmodule






