module ALU_2020_f
#(parameter BIT = 4, OPCODE = 4)
(
   output reg [BIT-1:0] c,
	output reg flag,
	input [OPCODE-1:0] instr,
	input [BIT-1:0] a,
	input [BIT-1:0] b
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
		default: {flag, c} = {BIT+1{1'b0}}; 
   endcase	

endmodule

//module ALU_2020_f
//#(parameter BIT = 4, OPCODE = 4)
//(
//   output reg [BIT-1:0] c,
//	output reg flag,
//	input [OPCODE-1:0] instr,
//	input [BIT-1:0] a,
//	input [BIT-1:0] b
//);
//
//	always @ (*) 
//		case (instr)
//		4'b0000: {flag,c} = 0; 				// NOP
//		4'b0001: {flag, c} = {1'b0, ~a}; 		// NOT
//		4'b0010: {flag, c} = {a, 1'b0};		// LSHIFT 
//		4'b0011: {c, flag} = {1'b0, a};		// RSHIFT
//		4'b1001: {flag, c} = {1'b0, a & b}; // LAND
//		4'b1010: {flag, c} = {1'b0, a | b}; // LOR
//		4'b1011: {flag, c} = a+b; 			// ADD
//		4'b1100: {flag, c} = a-b; 			// SUB
//		4'b1000: {flag, c} = (~b) + (~a);// новая операция
//		default: {flag, c} = 0; 
//  endcase	
//
//endmodule

 
//module ALU_2020_f
////параметр - разрядность 
//#(parameter N = 32)
//(
////разрядность выходного порта на 1 больше
////выходной порт - результат
//    output reg [N:0] c,
//
////управляющая шина кода операции
//	 input wire [3:0] instr,
//	 input wire clock_sig,
//
//// входные информационные порты - операнды
//	 input [N-1:0] a,
//	 input [N-1:0] b
//);
//
////описание логики работы АЛУ		
//	always @ (*) 
//		case (instr)
//			4'b0000: c = 0; // NOP
//			4'b0001: c = ~a; // NOT A
//			4'b0010: c = a << 1; // LSHIFT A
//			4'b0011: c = a >> 1; // RSHIFT A
//			4'b0100: c = b; // MOV B
//			4'b0101: c = a & b; // AND A,B
//			4'b0110: c = a | b; // OR A,B
//			4'b0111: c = a + b; // SUM A,B
//			4'b1000: c = result_sig; // 		
//			default: c = 0; 
//	  	endcase	
//
//wire [N-1:0] result_sig;
//
//ALU_SQRT	ALU_SQRT_inst (.clock ( clock_sig ), .data ( a ), .result ( result_sig ) );
//		
//endmodule	
