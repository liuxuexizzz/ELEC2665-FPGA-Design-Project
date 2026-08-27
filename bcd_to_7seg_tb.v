 `timescale 1ns/1ps

module bcd_to_7seg_tb;

    reg  [3:0] 	bcd;
    wire [6:0] 	seg;

    bcd_to_7seg dut (
        .bcd	(bcd),
        .seg	(seg)
    );

    initial begin
        $display("time(ns)  bcd  ->  seg(abcdefg)");
        // test 0
        bcd = 4'd0; #10; $display("%0t    %0d  ->  %b", $time, bcd, seg);
        // test 1
        bcd = 4'd1; #10; $display("%0t    %0d  ->  %b", $time, bcd, seg);
        // test 2
        bcd = 4'd2; #10; $display("%0t    %0d  ->  %b", $time, bcd, seg);
        // test 3
        bcd = 4'd3; #10; $display("%0t    %0d  ->  %b", $time, bcd, seg);
        // test 4
        bcd = 4'd4; #10; $display("%0t    %0d  ->  %b", $time, bcd, seg);
        // test 5
        bcd = 4'd5; #10; $display("%0t    %0d  ->  %b", $time, bcd, seg);
        // test 6
        bcd = 4'd6; #10; $display("%0t    %0d  ->  %b", $time, bcd, seg);
        // test 7
        bcd = 4'd7; #10; $display("%0t    %0d  ->  %b", $time, bcd, seg);
        // test 8
        bcd = 4'd8; #10; $display("%0t    %0d  ->  %b", $time, bcd, seg);
        // test 9
        bcd = 4'd9; #10; $display("%0t    %0d  ->  %b", $time, bcd, seg);
        // out-of-bound input: Expect seg to be completely wiped out.
        bcd = 4'd10; #10; $display("%0t    %0d  ->  %b  (off-limits)", $time, bcd, seg);

        $display("test finish");
        $stop;
    end

endmodule
