module PR5
(
input wire [7:0] in,
output reg [3:0] out
);

always @(*)
	case (in)
		8'd48: out = 4'd0;
		8'd49: out = 4'd1;
		8'd50: out = 4'd2;
		8'd51: out = 4'd3;
		8'd52: out = 4'd4;
		8'd53: out = 4'd5;
		8'd54: out = 4'd6;
		8'd55: out = 4'd7;
		8'd56: out = 4'd8;
		8'd57: out = 4'd9;
		default: out = 4'd0;
	endcase
endmodule