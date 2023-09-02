`timescale 1ns / 1ns
module tb1(); 

parameter N=8; 
wire sr_out; 
reg control; 
reg clk; 
reg sr_in; 
reg reset;

event event_start, event_test_control_complete, event_test_reset_complete;


PR13 DUT
(
	.sr_out(sr_out),
	.control(control),
	.clk(clk),
	.sr_in(sr_in),
	.reset(reset)
); 

initial 
begin 
    clk = 1'b0; 
    reset = 1'b0; 
    control = 1'b0;
	 sr_in = 1'b0;
    $display("Running testbench"); 
	 #1000;
	 -> event_start;
end  

//generate reset
initial
begin
	@(event_start);
	reset = 1;
	#2;
	reset = 0;
end

//clk
always #20 clk = ~clk;

initial
begin: test_control
	@(event_start);
	@(negedge clk);
	sr_in = 1;
	@(negedge clk);
	sr_in = 0;
	repeat(N-1) @(negedge clk);
	#10;
	if(sr_out == 1)
		$display("Test control: Failed (on value 0)");
	else
		begin
			@(negedge clk)
			control = 1;
			sr_in = 1;
			@(negedge clk);
			sr_in = 0;
			repeat(N-1) @(negedge clk);
			#10;
			control = 0;
			if(sr_out == 0)
				$display("Test control: Failed (on value 1)");
			else
				$display("Test control: Passed all");
			
		end
	-> event_test_control_complete;
end

initial
begin: test_reset
	@(event_test_control_complete);
	@(negedge clk);
	control = 1;
	sr_in = 1;
	repeat(N) @(negedge clk);
	reset = 1;
	#2;
	if (sr_out == 0)
		$display("Test reset: Passed");
	else
		begin
			@(posedge clk);
			#2;
			if (sr_out == 0)
				$display("Test reset: Failed (is synchronous)");
			else
				$display("Test reset: Failed (not work)");
		end
	control = 0;
	sr_in = 0;
	reset = 0;
	-> event_test_reset_complete;
end

initial
begin
	@(event_test_reset_complete);
	$display("Stop testbench");
	#5 $stop;
end
endmodule
