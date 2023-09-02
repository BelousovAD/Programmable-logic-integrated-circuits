module PR14
#(parameter N=8)
(
	input clk, control, reset,
	input sr_in,
	output sr_out
);
	reg [N-1:0] sr;
	assign sr_out = sr[N-1];
	always @ (posedge clk or posedge reset)
	begin
		if (reset) sr <= {N{1'b0}};
		else
			if (control)
			begin
			sr[N-1:1] <= sr[N-2:0];
			sr[0] <= sr_in;
			end
	end
endmodule

module DUT
#(parameter N=8)
(
	input clk, control, reset,
	input sr_in,
	output reg sr_out
);
	reg [N-1:0] sr;
	always @ (posedge clk or posedge reset)
	begin
		if (reset) begin sr <= {N{1'b0}}; sr_out <= 1'b0; end
		else
			if (control)
			begin
			sr_out <= sr[N-1];
			sr[N-1:1] <= sr[N-2:0];
			sr[0] <= sr_in;
			end
	end
endmodule
