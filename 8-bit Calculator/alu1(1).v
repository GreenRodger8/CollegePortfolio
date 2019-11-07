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

//	ADDER, SUBTRACTOR, AND MULTIPLIER ADAPTED FROM MOHAMED
//	REMOVED SOLE USE OF DFF AND INCLUDED CAPABILITY TO USE res IF NEEDED
//	ADDED TO THE IF STATEMENTS TO SINCE USING res IS A POSSIBILITY NOW
//	CHECK THAT IF STATEMENTS CHECK THE RIGHT CONDITIONS ON if(uas)
module Adder(uas, res, in1, in2, ans) ;
	parameter n=8 ;
	input [0:0] uas;
	input [n-1:0] in1, in2, res ;
	output [n-1:0] ans ;

	assign ans = uas? in1+res : in1+in2 ;

	always @* begin
	if(uas) begin
		if (in1 + res > 9'b011111111) begin
			$display("\t\tout of range ERROR");
			//$stop;
			end
		end
	else begin
		if(in1 + in2 > 9'b011111111) begin
			$display("\t\tout of range ERROR");
			//$stop;
			end
		end
	end
endmodule

module Subtractor(uas, res, in1, in2, ans) ;
	parameter n=8 ;
	input [0:0] uas;
	input [n-1:0] in1, in2, res ;
	output [n-1:0] ans ;

	assign ans = uas? in1-res : in1-in2 ;

	always @* begin
	if(uas) begin
		if (in1 < res) begin
			$display("\t\tout of range ERROR");
			//$stop;
			end
		end
	else begin
		if(in1 < in2) begin
			$display("\t\tout of range ERROR");
			//$stop;
			end
		end
	end
endmodule

module Multiplier(uas, res, in1, in2, ans) ;
	parameter n=8 ;
	input [0:0] uas;
	input [n-1:0] in1, in2, res ;
	output [n-1:0] ans ;

	assign ans = uas? in1*res : in1*in2 ;

	always @* begin
	if(uas) begin
		if (in1 * res > 9'b011111111) begin
			$display("\t\tout of range ERROR");
			//$stop;
			end
		end
	else begin
		if(in1 * in2 > 9'b011111111) begin
			$display("\t\tout of range ERROR");
			//$stop;
			end
		end
	end
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
// CHANGED TO USE ope INSTEAD OF SEL, MOVED PARAMETERS AROUND
// CHANGED CASEX TO INCLUDE NEW MODULES AND TO ONLY USE THE 3-BIT ope 
module Mux(res, in1, in2, ope, uas, ans) ;
	parameter k = 1 ;
	input [7:0] res ;
	input [2:0] ope ;
	input [7:0] in1, in2 ;
	output reg [7:0] ans ;
	wire [7:0] sum, diff, product, andAns, orAns, notAns, xorAns ;
	//wire [7:0] psum, pdiff, pprod, pand, por, pnot, pxor ;

	Adder ad(uas, res, in1, in2, sum) ;
	Subtractor su(uas, res, in1, in2, diff) ;
	Multiplier mu(uas, res, in1, in2, product) ;
	logicAnd la(uas, res, in1, in2, andAns) ;
	logicOr lo(uas, res, in1, in2, orAns) ;
	logicNot ln(uas, res, in1, notAns) ;
	logicXor lx(uas, res, in1, in2, xorAns) ;
	
	always @(*) begin
		casex(ope)
		3'b000: ans = 0;
		3'b001: ans = sum ;
		3'b010: ans = diff ;
		3'b011: ans = product ;
		3'b100: ans = andAns  ;
		3'b101: ans = orAns ;
		3'b110: ans = notAns ;
		3'b111: ans = xorAns ;
		endcase
	end
endmodule
	
//CHANGED TO USE ope INSTEAD OF SEL, REMOVED CONCATENATION
module controlUnit(clk, in1, in2, ope, uas, out) ;
	parameter n = 8 ;
	input clk, uas ;
	input [2:0] ope ;
	input [n-1:0] in1, in2 ;
	output [n-1:0] out ;
	wire [n-1:0] ans ;
	
	DFF #(n) count(clk, ans, out) ;
	Mux #(n) mux(out, in1, in2, ope, uas, ans) ;	
endmodule





//	DID NOT CHANGE ANYTHING FROM TESTBENCH, PLEASE FIX AND ENSURE THAT IT WORKS
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
