module ALU
#(parameter DATA_WIDTH = 4, COMAND_WIDTH = 4)
(
   output reg [(DATA_WIDTH-1):0] c,
	output reg flag,
	input [(COMAND_WIDTH-1):0] instr,
	input [(DATA_WIDTH-1):0] a, b
);
parameter
NOP = 	4'b0000,
NOT = 	4'b0001,
LSHIFT = 4'b0010,
RSHIFT = 4'b0011,
RCSHIFT = 4'b0100, /* новая операция циклический сдвиг через знак переноса */
LAND = 	4'b1001,
LOR = 	4'b1010,
ADD = 	4'b1011,
SUB = 	4'b1100,
XOR = 	4'B1101; /* новая операция поразрядный xor */

always @ (*)
begin
	case (instr)
		NOP: {flag,c} = 0; 				
		NOT: {flag, c} = {1'b0, ~a}; 		
		LSHIFT: {flag, c} = {a, 1'b0};		
		RSHIFT: {c, flag} = {1'b0, a};		
		LAND: {flag, c} = {1'b0, a & b}; 
		LOR: {flag, c} = {1'b0, a | b};
		ADD: {flag, c} = a+b; 
		SUB: {flag, c} = a-b; 
		RCSHIFT: {c, flag} = {flag, a};
		XOR: {flag, c} = {1'b0, a ^ b};
		default: {flag, c} = {DATA_WIDTH+1{1'b0}}; 
   endcase	
end
endmodule

module RAM
#(parameter DATA_WIDTH = 4, ADDR_WIDTH = 4)
(
	input clk, wr_re, clr,
	input [(DATA_WIDTH-1):0] d,
	input [(ADDR_WIDTH-1):0] addr_a, addr_b,
	output reg [(DATA_WIDTH-1):0] q_a, q_b
);


reg [(DATA_WIDTH-1):0] ram [2**ADDR_WIDTH-1:0];

initial
begin
	ram[4'b0000] = 4'b0001;
	ram[4'b0001] = 4'b0010;
	ram[4'b0010] = 4'b0011;
	ram[4'b0011] = 4'b0100;
	ram[4'b0100] = 4'b0101;
	ram[4'b0101] = 4'b0110;
	ram[4'b0110] = 4'b0111;
	ram[4'b0111] = 4'b1000;
	ram[4'b1000] = 4'b1001;
	ram[4'b1001] = 4'b1010;
	ram[4'b1010] = 4'b1011;
	ram[4'b1011] = 4'b1100;
	ram[4'b1100] = 4'b1101;
	ram[4'b1101] = 4'b1110;
	ram[4'b1110] = 4'b1111;
	ram[4'b1111] = 4'b0000;
end

always @(posedge clk or negedge clr)
begin
	if(~clr)
	begin
		q_a <= {DATA_WIDTH{1'b0}};
		q_b <= {DATA_WIDTH{1'b0}};
	end
	else
		if (wr_re)
			ram [addr_a] <= d;
		else
		begin
			q_a <= ram [addr_a];
			q_b <= ram [addr_b];
		end
end
endmodule

module PR8
#(parameter DATA_WIDTH=4, ADDR_WIDTH=4, COMAND_WIDTH=4)
(
input clk, clr, wr_re,
input [(COMAND_WIDTH-1):0] instr,
input [(ADDR_WIDTH-1):0] addr_a, addr_b
//шины для отладки
//output [(DATA_WIDTH-1):0] a, b, c,
//output f
);
wire [(DATA_WIDTH-1):0] a, b, c;
ALU #(.DATA_WIDTH(DATA_WIDTH), .COMAND_WIDTH(COMAND_WIDTH)) alu
	(.c(c), .flag(f), .instr(instr), .a(a), .b(b));
RAM #(.DATA_WIDTH(DATA_WIDTH), .ADDR_WIDTH(ADDR_WIDTH)) ram
	(.clk(clk), .wr_re(wr_re), .clr(clr), .d(c), .addr_a(addr_a), .addr_b(addr_b), .q_a(a), .q_b(b));
endmodule
