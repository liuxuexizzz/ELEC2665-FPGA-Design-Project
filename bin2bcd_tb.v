`timescale 1ns/1ps

module bin2bcd_tb;

    reg  [7:0] bin;
    wire [3:0] tens, ones;

    bin2bcd dut (
        .bin(bin),
        .tens(tens),
        .ones(ones)
    );

	 
	 
    integer i;
    initial begin
        $display("time(ns)\t input\t tens\t ones\t result");
        // Conduct a traversal test on the range from 0 to 99.
        for (i = 0; i < 100; i = i + 1) begin
            bin = i;
            #10;
            if (tens !== i/10 || ones !== i%10) begin
                $display("%0t\t%d\t%d\t%d\tFAIL (should be %d,%d)",
                         $time, bin, tens, ones, i/10, i%10);
            end else begin
                $display("%0t\t%d\t%d\t%d\tPASS",
                         $time, bin, tens, ones);
            end
        end

        $display("test finish");
        $stop;
    end
endmodule
