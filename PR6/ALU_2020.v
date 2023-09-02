module ALU_2020
#(parameter BIT = 4, FLAG = 1, OPCODE = 4)
//описание портов модуля в соответствии с 
//принятыми назначениями из файла .csv
(
   output  [OPCODE-1:0] LEDR,
	output [6:0]  HEX0, HEX1, HEX2, HEX3, HEX4,
   input   [17:0] SW
);

wire [BIT-1:0] w_a, w_b, w_c;
wire [OPCODE-1:0] w_op;
wire w_flag;
assign w_op = SW[17:(17-OPCODE+1)];
assign w_a = SW[BIT-1:0];
assign w_b = SW[BIT*2-1:BIT];

assign LEDR = w_op;

ALU_2020_f ALU 
(	.c (w_c),
	.flag (w_flag),
	.instr (w_op),
	.a (w_a),
	.b (w_b)
);

SevenSeg op (.d(w_op), .segments (HEX4) );
SevenSeg a1 (.d(w_a), .segments (HEX3) );
SevenSeg b1(.d(w_b), .segments (HEX2) );
SevenSeg c1(.d(w_c), .segments (HEX0) );
SevenSeg flag (.d({3'b000, w_flag}), .segments (HEX1) );
endmodule
