`timescale 1ns / 1ns
module tb1(); 

parameter N=8; 
wire sr_out_ref;
wire sr_out_dut; 
reg control; 
reg clk; 
reg sr_in; 
reg reset;

event event_start, event_test_control_complete, event_test_reset_complete;

integer file, all;

PR14 ref
(
	.sr_out(sr_out_ref),
	.control(control),
	.clk(clk),
	.sr_in(sr_in),
	.reset(reset)
);

DUT dut
(
	.sr_out(sr_out_dut),
	.control(control),
	.clk(clk),
	.sr_in(sr_in),
	.reset(reset)
);

initial 
begin 
    file = $fopen("Dump.txt");
	 all = 1|file;
	 clk = 1'b0; 
    reset = 1'b0; 
    control = 1'b0;
	 sr_in = 1'b0;
    $fdisplay(all, "Running testbench"); 
	 #1000;
	 -> event_start;
end  

//generate reset
initial
begin
	@(event_start);
	reset = 1;
	#10;
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
	if(sr_out_dut != sr_out_ref)
		$fdisplay(all, "Test control: Failed (on value 0)");
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
			if(sr_out_dut != sr_out_ref)
				$fdisplay(all, "Test control: Failed (on value 1)");
			else
				$fdisplay(all, "Test control: Passed all");
			
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
	#5;
	if (sr_out_dut == sr_out_ref)
		$fdisplay(all, "Test reset: Passed");
	else
		begin
			@(posedge clk);
			#5;
			if (sr_out_dut != sr_out_ref)
				$fdisplay(all, "Test reset: Failed (is synchronous)");
			else
				$fdisplay(all, "Test reset: Failed (not work)");
		end
	#5;
	control = 0;
	sr_in = 0;
	reset = 0;
	-> event_test_reset_complete;
end

initial
begin
	@(event_test_reset_complete);
	$fdisplay(all, "Stop testbench");
	#5 $stop;
end
endmodule
