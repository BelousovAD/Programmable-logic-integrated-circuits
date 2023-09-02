// сумматор на основе арифметических функций
module sum4 (A, B, P0, S, P);

input wire [3:0] A;
input wire [3:0] B;
input wire P0;
output wire [3:0] S;
output wire P;

assign {P, S} = A + B + P0;
endmodule

// модуль определения ошибки и правильного ответа
module cmp_err_3(sum_1, c_1, sum_2, c_2, sum_3, c_3, sum, c_out, err);

output wire [3:0] sum;
output wire c_out;
output wire err;
input wire [3:0] sum_1;
input wire [3:0] sum_2;
input wire [3:0] sum_3; 
input wire c_1;
input wire c_2;
input wire c_3;

assign err = ({c_1, sum_1} ^ {c_2, sum_2}) && ({c_3, sum_3} ^ {c_2, sum_2}) && ({c_1, sum_1} ^ {c_3, sum_3});
assign {c_out, sum} = err ? 0 : (!({c_1, sum_1} ^ {c_2, sum_2}) ? {c_1, sum_1} : {c_3, sum_3});

endmodule

//высоконадежный сумматор - модуль верхнего уровня для тестирования
//с дополнительной шиной помех
//с именованным назначением портов субмодулей
module PR41(a, b,	c_in, sum, c_out, err, interference_1, interference_3);

output wire [3:0] sum;
output wire c_out, err;
input wire [3:0] a;
input wire [3:0] b; 
input wire c_in;
input wire [3:0]interference_1;
input wire [3:0]interference_3;

wire [3:0] w_s1, w_s2, w_s3;
wire w_c1, w_c2, w_c3;

sum4 ADD_1 (.S(w_s1), .P(w_c1), .A(a), .B(b), .P0(c_in));
sum4 ADD_2 (.S(w_s2), .P(w_c2), .A(a), .B(b), .P0(c_in));
sum4 ADD_3 (.S(w_s3), .P(w_c3), .A(a), .B(b), .P0(c_in));
cmp_err_3 ERR (.sum_1(w_s1 | interference_1), .c_1(w_c1), .sum_2(w_s2), .c_2(w_c2), .sum_3(w_s3 | interference_3), .c_3(w_c3), .sum(sum), .c_out(c_out), .err(err));

endmodule