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

module FSM_Moore (
input clk, reset, input in, 
output reg [2:0] out, 
output wire [1:0] w_state);//отладочный порт

	parameter S0=2'b00, S1=2'b01, S2=2'b10, S3=2'b11;
	parameter Y0=3'b000, Y1=3'b010, Y2=3'b001, Y3=3'b100;
	reg [1:0] state;
	assign w_state = state;//для отладки

	always @ (state)
	begin
			case (state)
				S1: out = Y1;
				S2: out = Y2;
				S3: out = Y3;
				default: out = Y0;
			endcase
	end
	
	always @ (posedge clk) begin // переходы
	if (!reset)
		state <= S0;
	else
		if (in)
			begin
				case (state)
					S0: state <= S1;
					S1: state <= S2;
					S2: state <= S3;
					default:
						state <= S0;
				endcase
			end
	end
endmodule

module RAM
#(parameter DATA_WIDTH = 4, ADDR_WIDTH = 1)
(
	input clk, wr_re_a, wr_re_b, wr_alu, clr,
	input [(DATA_WIDTH-1):0] data, data_alu,
	output reg [(DATA_WIDTH-1):0] q_a, q_b
);


reg [(DATA_WIDTH-1):0] ram [2**ADDR_WIDTH-1:0];

initial
begin
	ram[2'b00] = 4'b0000;
	ram[2'b01] = 4'b0000;
end

always @(posedge clk)
begin
	if(~clr)
	begin
		q_a <= {DATA_WIDTH{1'b0}};
		q_b <= {DATA_WIDTH{1'b0}};
	end
	else
		if (wr_re_a)
			ram [2'b00] = data;
		if (wr_re_b)
			ram [2'b01] = data;
		if (wr_alu)
			ram [2'b00] = data_alu;
		begin
			q_a <= ram [2'b00];
			q_b <= ram [2'b01];
		end
end
endmodule

module PR10
#(parameter DATA_WIDTH=4, ADDR_WIDTH=1, COMAND_WIDTH=4)
(
input clk, reset, ready,
input [(COMAND_WIDTH-1):0] instr,
input [(DATA_WIDTH-1):0] data,
//шины для отладки
output [2:0] out_fsm,
output [(DATA_WIDTH-1):0] out_a, out_b, out_alu,
output f
);

//wire [2:0] out_fsm;
//wire [DATA_WIDTH-1:0] out_a, out_b, out_alu;

FSM_Moore fsm
	(.clk(clk), .reset(reset), .in(ready), .out(out_fsm));
RAM #(.DATA_WIDTH(DATA_WIDTH), .ADDR_WIDTH(ADDR_WIDTH)) ram
	(.clk(clk), .wr_re_a(out_fsm[1]), .wr_re_b(out_fsm[0]), .wr_alu(out_fsm[2]),
	.clr(reset), .data_alu(out_alu), .data(data), .q_a(out_a), .q_b(out_b));
ALU #(.DATA_WIDTH(DATA_WIDTH), .COMAND_WIDTH(COMAND_WIDTH)) alu
	(.c(out_alu), .flag(f), .instr(instr), .a(out_a), .b(out_b));
endmodule
