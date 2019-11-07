module timer(clk, rst, m, out) ;
 input clk, rst, m ;
 output out ;

 reg state ;
 reg out ;

 always @(posedge clk or posedge rst) begin
  if (rst)
   state <= 0 ;
  else
   case(state)
    0:
     if (m)
      state <= 3 ;
     else
      state <= 4 ;
    1: state <= 5 ;
    2: state <= 1 ;
    3: state <= 2 ;
    4: state <= 3 ;
   endcase
 end

 always @(state) begin
  case(state)
   0: out = 0 ;
   1: out = 1 ;
   2: out = 2 ;
   3: out = 3 ;
   4: out = 4 ;
  endcase
 end
endmodule

module control(clk, rst, m, out) ;
 input clk, rst, m ;
 output [1:0] out ;

 wire state ;
 reg out ;

 timer test1(clk, rst, m, state) ;

 always @(state) begin
  case(state)
   0: out = 2'b00 ;
   1: out = 2'b10 ;
   2: out = 2'b11 ;
   3: out = 2'b01 ;
   4: out = 2'b00 ;
  endcase
 end

endmodule

module simpleFSM(clk, rst, in, out) ;
 input clk, rst, in ;
 output [1:0] out ;

 reg state ;
 reg out ;

 always @(posedge clk or posedge rst) begin
  if(rst)
   state <= 0 ;
  else
   case(state)
    0:
     if(in)
      state <= 3 ;
     else
      state <= 4 ;
    1: state <= 5 ;
    2: state <= 1 ;
    3: state <= 2 ;
    4: state <= 3 ;
   endcase
 end

 always @(state) begin
  case(state)
   0: out = 2'b00 ;
   1: out = 2'b10 ;
   2: out = 2'b11 ;
   3: out = 2'b01 ;
   4: out = 2'b00 ;
  endcase
end

endmodule

module TestBench ;
  reg clk, rst, in ;
  reg match ;
  wire [1:0] out1 ;
  wire [1:0] out2 ;

  simpleFSM test1(clk, rst, in, out1) ;
  control test2(clk, rst, in, out2) ;

  initial begin
  clk = 1 ; #5 clk = 0 ;
    $display("*Cough* TestBenches are hard *Cough*") ;
    $display("Clock|Reset|Select|State|CtrlState|Match") ;
    $display("-----+-----+------+-----+---------+-----") ;
  forever begin
    match = out1 == out2 ;
    $display("    %b|    %b|     %b|   %b|       %b| %b",clk,rst,in,out1,out2,match) ;
    #5 clk = 1 ;

  #5 clk = 0;
    end
  end

  initial begin
   rst=1;in=0;
   #10
   #10 rst=0;in=0;
   #10 rst=0;in=1;
   #50 rst=1;in=1;
   #50 rst=1;in=0;
    #50
    $stop ;
  end
endmodule
