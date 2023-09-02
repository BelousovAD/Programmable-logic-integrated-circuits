module FSM_Mealy (
	input	clk, reset, input [1:0]in,
	output reg [2:0] out,
	output wire [2:0] w_state);//отладочный порт

	parameter A0=2'b00, A1=2'b01, A2=2'b10, A3=2'b11;
	parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11;
	parameter Y0=3'b000, Y1=3'b001, Y2=3'b010, Y3=3'b011, Y4=3'b100;
	reg [2:0] state;
	assign w_state = state;// для отладки
	
	always @ (posedge clk or negedge reset) begin
		if (!reset)
			state <= S0;
		else
			case (state)
				S0: begin
						case (in)
							A0: state <= S1;
							A1: state <= S1;
							A2: state <= S2;
							A3: state <= S2;
							default: state <= S0;
						endcase
					end
				S1: begin
						case (in)
							A0: state <= S2;
							A1: state <= S3;
							A2: state <= S0;
							A3: state <= S2;
							default: state <= S0;
						endcase
					end
				S2: begin
						case (in)
							A0: state <= S0;
							A1: state <= S2;
							A2: state <= S1;
							A3: state <= S2;
							default: state <= S0;
						endcase
					end
				S3: begin
						case (in)
							A0: state <= S0;
							A1: state <= S1;
							A2: state <= S3;
							A3: state <= S3;
							default: state <= S0;
						endcase
					end
			endcase
	end

	always @ (state or in)
	begin
		case (state)
			S0: begin
					case (in)
						A0: out <= Y1;
						A1: out <= Y1;
						A2: out <= Y1;
						A3: out <= Y1;
						default: out <= Y0;
					endcase
				end
			S1: begin
					case (in)
						A0: out <= Y3;
						A1: out <= Y1;
						A2: out <= Y1;
						A3: out <= Y3;
						default: out <= Y0;
					endcase
				end
			S2: begin
					case (in)
						A0: out <= Y2;
						A1: out <= Y0;
						A2: out <= Y1;
						A3: out <= Y4;
						default: out <= Y0;
					endcase
				end
			S3: begin
					case (in)
						A0: out <= Y2;
						A1: out <= Y3;
						A2: out <= Y3;
						A3: out <= Y3;
						default: out <= Y0;
					endcase
				end
		endcase
	end
endmodule
