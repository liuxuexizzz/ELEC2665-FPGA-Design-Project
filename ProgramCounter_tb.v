`timescale 1ns/1ps


module ProgramCounter_tb;
    reg         	clk;
    reg         	reset;      // asynchronous high-level reset
    reg         	load;       // synchronous loading
    reg         	inc;        // synchronous auto-increment
    reg  [7:0]  	ResetVal;   // value loaded during reset
    reg  [7:0]  	LoadVal;    // value loaded during loading
    wire [7:0]  	PCoutput;   // counter output

	 
    ProgramCounter dut (
        .clk      (clk),
        .ResetVal (ResetVal),
        .LoadVal  (LoadVal),
        .reset    (reset),
        .load     (load),
        .inc      (inc),
        .PCoutput (PCoutput)
    );

	 
    // clk：period 10ns（100MHz）
    initial clk = 0;
    always #5 clk = ~clk;

	 
    initial begin
        // initial value
        ResetVal = 8'hA5;
        LoadVal  = 8'd5;
        reset    = 0;
        load     = 0;
        inc      = 0;
        #10;

		  
        // asynchronous reset test
        reset 	  = 1;
        #1;
        $display("after reset PCoutput = 0x%h (expectation = 0xA5)", PCoutput);
        reset 	  = 0;
        #10;

		  
        // sStep loading test
        LoadVal  = 8'd10;
        load     = 1;
        #10;
        load     = 0;
        $display("after load PCoutput = %0d (expectation = 10)", PCoutput);
        #10;

		  
        // synchronous auto-increment test
        inc      = 1;
        #10; $display("1'st auto-increment PCoutput = %0d (expectation = 11)", PCoutput);
        #10; $display("2'st auto-increment PCoutput = %0d (expectation = 12)", PCoutput);
        inc      = 0;
        #10; $display("stop auto-increment PCoutput = %0d (expectation maintain 12)", PCoutput);

		  
        // priority test: When both load and inc are valid simultaneously, load takes priority.
        LoadVal  = 8'd7;
        load     = 1;
        inc      = 1;
        #10;
		  
		  
        $display("when load and inc =1 , PCoutput = %0d (expectation = 7)", PCoutput);
        load 	  = 0; 
		  inc  	  = 0;
        #10;
        $display("test finish");
        $stop;
		  
    end
	 
endmodule










