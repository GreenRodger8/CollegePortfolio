// DFF to save the result of an operation
module DFF(clk,in,out);
  parameter n=1;//width
  input clk;
  input [n-1:0] in;
  output [n-1:0] out;
  reg [n-1:0] out;

  always @(posedge clk)
  out = in;
 endmodule

// Performs bitwise AND on two 8-bit numbers
module logicAnd(uas, res, in1, in2, ans) ;
  input [0:0] uas ;
  input [7:0] in1, in2, res ;
  output [7:0] ans ;

  assign ans = uas ? res & in1 : in1 & in2 ;
endmodule


// Performs bitwise OR on two 8-bit numbers
module logicOr(uas, res, in1, in2, ans) ;
  input [0:0] uas ;
  input [7:0] in1, in2, res ;
  output [7:0] ans ;

  assign ans = uas ? res | in1 : in1 | in2 ;
endmodule

// Performs bitwise NOT on two 8-bit numbers
module logicNot(uas, res, in1, ans) ;
  input [0:0] uas ;
  input [7:0] in1, res ;
  output [7:0] ans ;

  assign ans = uas ? ~res : ~in1 ;
endmodule

// Performs bitwise XOR on two 8-bit numbers
module logicXor(uas, res, in1, in2, ans) ;
  input [0:0] uas ;
  input [7:0] in1, in2, res ;
  output [7:0] ans ;

  assign ans = uas ? res ^ in1 : in1 ^ in2 ;
endmodule

// Oh my god here's a MUX or what I think is one
module Mux(res, in1, in2, sel, ans) ;
  parameter k = 1 ;
  input [7:0] res ;
  input [8:0] sel ;
  input [7:0] in1, in2 ;
  output reg [7:0] ans ;
  wire [7:0] sum, diff, product, andAns, orAns, notAns, xorAns ;
  wire [7:0] psum, pdiff, pprod, pand, por, pnot, pxor ;

  logicAnd la(sel[7], res, in1, in2, andAns) ;
  logicOr lo(sel[7], res, in1, in2, andAns) ;
  logicNot ln(sel[7], res, in1, notAns) ;
  logicXor lx(sel[7], res, in1, in2, andAns) ;


  always @(*) begin
    casex(sel)
      9'b1xxxxxxx: ans = 0;
      9'bxxxxx1xxx: ans = andAns ;
      9'bxxxxxx1xx: ans = orAns ;
      9'bxxxxxxx1x: ans = notAns ;
      9'bxxxxxxxx1: ans = xorAns ;
    endcase
  end
endmodule




module controlUnit(clk, rst, in1, in2, add, sub, mul, an, ors, no, nox, uas, out) ;
  parameter n = 8 ;
  input clk, rst, add, sub, mul, an, ors, no, nox, uas ;
  input [7:0] in1, in2 ;
  output [7:0] out ;
  wire [n-1:0] ans ;

  DFF #(n) count(clk, ans, out) ;
  Mux #(n) mux(out, in1, in2, {rst, uas, add, sub, mul, an, ors, no, nox}, ans) ;

endmodule






//===========================================================
/*module TestBench ;
  parameter n = 8 ;
  reg clk, rst, add, sub, mul, an, ors, no, nox, uas ;
  reg [7:0] in1, in2 ;
  wire [n-1:0] out;


 controlUnit central(clk, rst, in1, in2, add, sub, mul, an, ors, no, nox, uas, out) ;


  initial begin
    clk = 1 ; #5 clk = 0 ;
	    $display("Clock|Reset| Number1| Number2|Add|Sub|Mul|AND|OR|NOT|XOR|UseSvd| Result");
	    $display("-----+-----+-------+-------+---+---+---+---+--+---+---+------+-------");
    forever
      begin
        $display("    %b|    %b|%b|%b|  %b|  %b|  %b|  %b| %b|  %b|  %b|     %b| %b",clk,rst,in1,in2,add,sub,mul,an,ors,no,nox,uas,out) ;
        #5 clk = 1 ;

		#5 clk = 0 ;
      end
    end

  // input stimuli
  initial begin

    rst = 0;add=0;sub=0;mul=0;an=0;ors=0;no=0;nox=0;uas=0;in1=8'b00000000;in2=8'b00000000;


    rst = 0;up=0;down=0;load=0;in=4'b0000;
	#0
    #10 rst = 1 ;up=0;down=0;load=0;in=4'b0000;
    #10 rst = 0 ;up=0;down=0;load=0;in=4'b0000;
    #10 rst = 0 ;up=1;down=0;load=0;in=4'b0000;
	#50 rst = 0 ;up=0;down=0;load=0;in=4'b0000;
    #10 rst = 0 ;up=0;down=1;load=0;in=4'b0000;
	#50 rst = 0 ;up=0;down=0;load=0;in=4'b0000;
	#10 rst = 0 ;up=0;down=0;load=1;in=4'b0111;
	#50 rst = 0 ;up=0;down=0;load=0;in=4'b0000;
	#10 rst = 0 ;up=0;down=0;load=0;in=4'b0000;
    $stop ;
  end
endmodule*/
