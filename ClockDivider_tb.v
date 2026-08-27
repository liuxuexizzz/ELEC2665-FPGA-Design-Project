`timescale 1ns/1ps

module ClockDivider_tb;

    reg 		CLK_50MHz;    // 50 MHz clk
    reg 		rst_n;        // reset (effective low)
    wire 	CLK_100Hz;   // 100 Hz clk
    wire 	CLK_1Hz;     // 1 Hz clk


    ClockDivider uut (
        .CLK_50MHz	(CLK_50MHz),
        .rst_n			(rst_n),
        .CLK_100Hz	(CLK_100Hz),
        .CLK_1Hz		(CLK_1Hz)
    );

	 
    // 50 MHz clock generation: period 20 ns, rising edge interval 10 ns
    initial CLK_50MHz = 0;
    always #10 CLK_50MHz = ~CLK_50MHz;

	 
    // reset
    initial begin
        rst_n = 0;
        #100;
        rst_n = 1;
    end

	 
    // rising edge counting
    integer count100 = 0;
    integer count1   = 0;

	 
    // 100 Hz 
    always @(posedge CLK_100Hz) begin
        count100 = count100 + 1;
        $display("Time=%0t: %0d times CLK_100Hz rising edge", $time, count100);
    end

	 
    // 1 Hz 
    always @(posedge CLK_1Hz) begin
        count1 = count1 + 1;
        $display("Time=%0t:  %0d times CLK_1Hz rising edge", $time, count1);
    end

	 
    // process ends when the 100 Hz output occurs twice and the 1 Hz output occurs twice.
    initial begin
        wait(count100 == 2);
        wait(count1   == 2);
        $display("test finish: 100 Hz change 2 times，1 Hz change 2 times，finish time %0t", $time);
        $stop;
    end
endmodule
