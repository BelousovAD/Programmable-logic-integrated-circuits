module PR42
(
input wire [7:0] in,
output wire [5:0] out
);

assign out = (in < 8'd48 || in > 8'd57) ? 6'd0 : in - 6'd48;
endmodule