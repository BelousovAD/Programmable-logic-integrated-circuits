
`timescale 1ns / 1ns
module test  ; 

parameter COMAND_WIDTH  = 4 ;
parameter DATA_WIDTH  = 4 ;
parameter ADDR_WIDTH  = 4 ; 
  reg  [ADDR_WIDTH-1:0]  addr_b   ; 
  reg  [COMAND_WIDTH-1:0]  instr   ; 
  reg    clr   ; 
  reg    clk   ; 
  reg  [ADDR_WIDTH-1:0]  addr_a   ; 
  reg    wr_re   ; 
  PR8    #( COMAND_WIDTH , DATA_WIDTH , ADDR_WIDTH  )
   DUT  ( 
       .addr_b (addr_b ) ,
      .instr (instr ) ,
      .clr (clr ) ,
      .clk (clk ) ,
      .addr_a (addr_a ) ,
      .wr_re (wr_re ) ); 

   reg [3 : 0] \VARinstr ;
   reg [3 : 0] \VARaddr_a ;
   reg [3 : 0] \VARaddr_b ;


// "Clock Pattern" : dutyCycle = 50
// Start Time = 0 ns, End Time = 5 us, Period = 50 ns
  initial
  begin
	  clk  = 1'b0  ;
	 # 25 ;
// 25 ns, single loop till start period.
   repeat(99)
   begin
	   clk  = 1'b1  ;
	  #25  clk  = 1'b0  ;
	  #25 ;
// 4975 ns, repeat pattern in loop.
   end
	  clk  = 1'b1  ;
	 # 25 ;
// dumped values till 5 us
  end


// "Constant Pattern"
// Start Time = 0 ns, End Time = 5 us, Period = 0 ns
  initial
  begin
	  clr  = 1'b1  ;
	 # 0	  clr  = 1'b0  ;
	 # 60	  clr  = 1'b1  ;
	 # 4940 ;
// dumped values till 5 us
  end


// "Constant Pattern"
// Start Time = 0 ns, End Time = 5 us, Period = 0 ns
  initial
  begin
	  wr_re  = 1'b1  ;
	 # 0	  wr_re  = 1'b0  ;
	 # 2500	  wr_re  = 1'b1  ;
	 # 2500 ;
// dumped values till 5 us
  end


// "Counter Pattern"(Range-Up) : step = 1 Range(0000-1111)
// Start Time = 0 ns, End Time = 5 us, Period = 50 ns
  initial
  begin
	\VARinstr = 4'b0000 ;
	 instr  = 4'b0000  ;
	repeat(15)
	  begin
	  \VARinstr = \VARinstr  + 1 ;
	  #50  instr  = \VARinstr  ;
	  end
	  #50 ;
// 800 ns, repeat pattern in loop.
	\VARinstr = 4'b0000 ;
	 instr  = 4'b0000  ;
	repeat(3)
	  begin
	  \VARinstr = \VARinstr  + 1 ;
	  #50  instr  = \VARinstr  ;
	  end
	  #50 ;
// 1 us, periods remaining till edit start time.
	  instr  = 4'b0100  ;
	 # 50	  instr  = 4'b0101  ;
	 # 50	  instr  = 4'b0110  ;
	 # 50	  instr  = 4'b0111  ;
	 # 50	  instr  = 4'b1000  ;
	 # 50	  instr  = 4'b1001  ;
	 # 50	  instr  = 4'b1010  ;
	 # 50	  instr  = 4'b1011  ;
	 # 50	  instr  = 4'b1100  ;
	 # 50	  instr  = 4'b1101  ;
	 # 50	  instr  = 4'b1110  ;
	 # 50	  instr  = 4'b1111  ;
	 # 50	  instr  = 4'b0000  ;
	 # 50	  instr  = 4'b0001  ;
	 # 50	  instr  = 4'b0010  ;
	 # 50	  instr  = 4'b0011  ;
	 # 50	  instr  = 4'b0100  ;
	 # 50	  instr  = 4'b0101  ;
	 # 50	  instr  = 4'b0110  ;
	 # 50	  instr  = 4'b0111  ;
	 # 50	  instr  = 4'b1000  ;
	 # 50	  instr  = 4'b1001  ;
	 # 50	  instr  = 4'b1010  ;
	 # 50	  instr  = 4'b1011  ;
	 # 50	  instr  = 4'b1100  ;
	 # 50	  instr  = 4'b1101  ;
	 # 50	  instr  = 4'b1110  ;
	 # 50	  instr  = 4'b1111  ;
	 # 50	  instr  = 4'b0000  ;
	 # 50	  instr  = 4'b0001  ;
	 # 50	  instr  = 4'b0010  ;
	 # 50	  instr  = 4'b0011  ;
	 # 50	  instr  = 4'b0100  ;
	 # 50	  instr  = 4'b0101  ;
	 # 50	  instr  = 4'b0110  ;
	 # 50	  instr  = 4'b0111  ;
	 # 50	  instr  = 4'b1000  ;
	 # 50	  instr  = 4'b1001  ;
	 # 50	  instr  = 4'b1010  ;
	 # 50	  instr  = 4'b1011  ;
	 # 50	  instr  = 4'b1100  ;
	 # 50	  instr  = 4'b1101  ;
	 # 50	  instr  = 4'b1110  ;
	 # 50	  instr  = 4'b1111  ;
	 # 50	  instr  = 4'b0000  ;
	 # 50	  instr  = 4'b0001  ;
	 # 50	  instr  = 4'b0010  ;
	 # 50	  instr  = 4'b0011  ;
	 # 50	  instr  = 4'b0100  ;
	 # 50	  instr  = 4'b0101  ;
	 # 50	  instr  = 4'b0110  ;
	 # 50	  instr  = 4'b0111  ;
	 # 50	  instr  = 4'b1000  ;
	 # 50	  instr  = 4'b1001  ;
	 # 50	  instr  = 4'b1010  ;
	 # 50	  instr  = 4'b1011  ;
	 # 50	  instr  = 4'b1100  ;
	 # 50	  instr  = 4'b1101  ;
	 # 50	  instr  = 4'b1110  ;
	 # 50	  instr  = 4'b1111  ;
	 # 50	  instr  = 4'b0000  ;
	 # 50	  instr  = 4'b0001  ;
	 # 50	  instr  = 4'b0010  ;
	 # 50	  instr  = 4'b0011  ;
	 # 50	  instr  = 4'b0100  ;
	 # 50	  instr  = 4'b0101  ;
	 # 50	  instr  = 4'b0110  ;
	 # 50	  instr  = 4'b0111  ;
	 # 50	  instr  = 4'b1000  ;
	 # 50	  instr  = 4'b1001  ;
	 # 50	  instr  = 4'b1010  ;
	 # 50	  instr  = 4'b1011  ;
	 # 50	  instr  = 4'b1100  ;
	 # 50	  instr  = 4'b1101  ;
	 # 50	  instr  = 4'b1110  ;
	 # 50	  instr  = 4'b1111  ;
	 # 50	  instr  = 4'b0000  ;
	 # 50	  instr  = 4'b0001  ;
	 # 50	  instr  = 4'b0010  ;
	 # 50	  instr  = 4'b0011  ;
	 # 50 ;
// dumped values till 5 us
  end


// "Counter Pattern"(Range-Up) : step = 1 Range(0000-1111)
// Start Time = 0 ns, End Time = 5 us, Period = 50 ns
  initial
  begin
   repeat(6)
   begin
	\VARaddr_a = 4'b0000 ;
	 addr_a  = 4'b0000  ;
	repeat(15)
	  begin
	  \VARaddr_a = \VARaddr_a  + 1 ;
	  #50  addr_a  = \VARaddr_a  ;
	  end
	  #50 ;
// 4800 ns, repeat pattern in loop.
   end
	\VARaddr_a = 4'b0000 ;
	 addr_a  = 4'b0000  ;
	repeat(3)
	  begin
	  \VARaddr_a = \VARaddr_a  + 1 ;
	  #50  addr_a  = \VARaddr_a  ;
	  end
	  #50 ;
// 5 us, periods remaining till edit start time.
  end


// "Counter Pattern"(Range-Up) : step = 1 Range(0000-1111)
// Start Time = 0 ns, End Time = 5 us, Period = 50 ns
  initial
  begin
   repeat(6)
   begin
	\VARaddr_b = 4'b0000 ;
	 addr_b  = 4'b0000  ;
	repeat(15)
	  begin
	  \VARaddr_b = \VARaddr_b  + 1 ;
	  #50  addr_b  = \VARaddr_b  ;
	  end
	  #50 ;
// 4800 ns, repeat pattern in loop.
   end
	\VARaddr_b = 4'b0000 ;
	 addr_b  = 4'b0000  ;
	repeat(3)
	  begin
	  \VARaddr_b = \VARaddr_b  + 1 ;
	  #50  addr_b  = \VARaddr_b  ;
	  end
	  #50 ;
// 5 us, periods remaining till edit start time.
  end

  initial
	#10000 $stop;
endmodule
