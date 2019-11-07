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
module Adder(uas, res, in1, in2, err, ans) ;
	parameter n=8 ;
	input [0:0] uas;
	input [n-1:0] in1, in2, res ;
	output reg [n-1:0] ans ;
	output reg [0:0] err ;

	always @(*) begin
		ans <= uas? in1+res : in1+in2 ;
	end

	always @* begin
	if(uas) begin
		if (in1 + res >= 9'b011111111) begin
			err <= 1 ;
			//$display("ERROR:Line immediately below this statement has a result greater than 8 bits. (add1)");
			//$stop;
			end
		else
			err <= 0 ;
		end
	else begin
		if(in1 + in2 >= 9'b011111111) begin
		err <= 1 ;
			//$display("ERROR:Line immediately below this statement has a result greater than 8 bits. (add2)");
			//$stop;
			end
		else
			err <= 0 ;
		end
	end
endmodule

module Subtractor(uas, res, in1, in2, err, ans) ;
	parameter n=8 ;
	input [0:0] uas;
	input [n-1:0] in1, in2, res ;
	output reg [n-1:0] ans ;
	output reg [0:0] err ;

	always @(*) begin
		ans <= uas? in1-res : in1-in2 ;
	end

	always @* begin
	if(uas) begin
		if (in1 < res) begin
			err <= 1;
			//$display("ERROR:Line immediately below this statement has a result greater than 8 bits. (sub1)");
			//$stop;
			end
			else
				err <= 0 ;
		end
	else begin
		if(in1 < in2) begin
			err <= 1 ;
			//$display("ERROR:Line immediately below this statement has a result greater than 8 bits. (sub2)");
			//$stop;
			end
		else
			err <= 0 ;
		end
	end
endmodule

module Multiplier(uas, res, in1, in2, err, ans) ;
	parameter n=8 ;
	input [0:0] uas;
	input [n-1:0] in1, in2, res ;
	output reg [n-1:0] ans ;
	output reg [0:0] err ;

	always @(*) begin
		ans <= uas? in1*res : in1*in2 ;
	end

	always @(*) begin
	if(uas) begin
		if (in1 * res >= 9'b011111111) begin
			err <= 1 ;
			//$display("ERROR:Line immediately below this statement has a result greater than 8 bits. (mul1)");
			//$stop;
			end
		else
			err <= 0 ;
		end
	else begin
		if(in1 * in2 >= 9'b011111111) begin
			err <= 1;
			//$display("ERROR:Line immediately below this statement has a result greater than 8 bits. (mul2)");
			//$stop;
			end
		else
			err <= 0;
		end
	end
endmodule

// Performs bitwise AND on two 8-bit numbers
module logicAnd(uas, res, in1, in2, ans) ;
	input [0:0] uas ;
	input [7:0] in1, in2, res ;
	output reg [7:0] ans ;

	always @(*) begin
		ans <= uas ? res & in1 : in1 & in2 ;
	end
endmodule


// Performs bitwise OR on two 8-bit numbers
module logicOr(uas, res, in1, in2, ans) ;
	input [0:0] uas ;
	input [7:0] in1, in2, res ;
	output reg [7:0] ans ;

	always @(*) begin
		ans <= uas ? res | in1 : in1 | in2 ;
	end
endmodule

// Performs bitwise NOT on two 8-bit numbers
module logicNot(uas, res, in1, ans) ;
	input [0:0] uas ;
	input [7:0] in1, res ;
	output reg [7:0] ans ;

	always @(*) begin
		ans <= uas ? ~res : ~in1 ;
	end
endmodule

// Performs bitwise XOR on two 8-bit numbers
module logicXor(uas, res, in1, in2, ans) ;
	input [0:0] uas ;
	input [7:0] in1, in2, res ;
	output reg [7:0] ans ;

	always @(*) begin
		ans <= uas ? res ^ in1 : in1 ^ in2 ;
	end
endmodule

// Oh my god here's a MUX or what I think is one
// CHANGED TO USE ope INSTEAD OF SEL, MOVED PARAMETERS AROUND
// CHANGED CASEX TO INCLUDE NEW MODULES AND TO ONLY USE THE 3-BIT ope
module Mux(sum, diff, product, andAns, orAns, notAns, xorAns, ope, ans) ;
  input [7:0] sum, diff, product, andAns, orAns, notAns, xorAns ;
	input [2:0] ope ;
	output reg [7:0] ans ;

	always @(*) begin
		casex(ope)
		3'b000: ans <= 0;
		3'b001: ans <= sum ;
		3'b010: ans <= diff ;
		3'b011: ans <= product ;
		3'b100: ans <= andAns  ;
		3'b101: ans <= orAns ;
		3'b110: ans <= notAns ;
		3'b111: ans <= xorAns ;
		endcase
	end
endmodule

module errMux(aer, ser, mer, ope, err) ;
	parameter k = 1 ;
	input [2:0] ope ;
  input [0:0] aer, ser, mer ;
	output reg [0:0] err ;

	always @(*) begin
		case(ope)
			3'b001: err <= aer ;
			3'b010: err <= ser ;
			3'b011: err <= mer ;
			default: err = 0 ;
		endcase
	end
endmodule


//CHANGED TO USE ope INSTEAD OF SEL, REMOVED CONCATENATION
module controlUnit(clk, in1, in2, ope, uas, out, err) ;
	parameter n = 8 ;
	input clk, uas ;
	input [2:0] ope ;
	input [n-1:0] in1, in2 ;
	output [n-1:0] out ;
	output [0:0] err ;
	wire [n-1:0] ans, res ;
  wire [0:0] aer, ser, mer ;
	wire [7:0] sum, diff, product, andAns, orAns, notAns, xorAns ;

  Adder ad(uas, res, in1, in2, aer, sum) ;
	Subtractor su(uas, res, in1, in2, ser, diff) ;
	Multiplier mu(uas, res, in1, in2, mer, product) ;
	logicAnd la(uas, res, in1, in2, andAns) ;
	logicOr lo(uas, res, in1, in2, orAns) ;
	logicNot ln(uas, res, in1, notAns) ;
	logicXor lx(uas, res, in1, in2, xorAns) ;

	DFF #(n) result(clk, ans, res) ;
	Mux #(n) mux(sum, diff, product, andAns, orAns, notAns, xorAns, ope, ans) ;
	errMux #(n) emx(aer, ser, mer, ope, err) ;

  assign out = ans ;
endmodule





//	DID NOT CHANGE ANYTHING FROM TESTBENCH, PLEASE FIX AND ENSURE THAT IT WORKS
//===========================================================
module TestBench ;
	parameter n = 8;
	reg clk, uas ;
	reg [n-1:0] in1, in2 ;
	reg [2:0] ope ;
	wire [n-1:0] out ;
	wire [0:0] err ;

	controlUnit central(clk, in1, in2, ope, uas, out, err) ;


  initial begin
    clk = 1 ; #5 clk = 0 ;
	    $display("Clock| Number1| Number2|Operation|UseSaved|  Result| Error");
	    $display("-----+--------+--------+---------+--------+--------+------");
    forever
      begin
        $write("    %b|%b|%b|%b (",clk,in1,in2,ope) ;
				casex(ope)
					3'b000: $write("Rst)") ;
					3'b001: $write("Add)") ;
					3'b010: $write("Sub)") ;
					3'b011: $write("Mul)") ;
					3'b100: $write("AND)") ;
					3'b101: $write(" OR)") ;
					3'b110: $write("NOT)") ;
					3'b111: $write("XOR)") ;
				endcase
				$write("|       %b|%b",uas, out) ;
				if (err == 0)
					$write("| None\n") ;
				else
					$write("| Out of Range Error\n") ;
        #5 clk = 1 ;

		#5 clk = 0 ;
      end
    end

  // input stimuli
  initial begin
    ope=000;uas=0;in1=8'b00000000;in2=8'b00000000;
	#0
		#10 ope=000;uas=0;in1=8'b00000000;in2=8'b00000000;
    #10 ope=001;uas=0;in1=8'b00000001;in2=8'b00000001;
    #10 ope=001;uas=0;in1=8'b00000001;in2=8'b00000010;
    #10 ope=001;uas=0;in1=8'b00000001;in2=8'b00000011;
		#10 ope=001;uas=0;in1=8'b00000100;in2=8'b00000010;
    #10 ope=001;uas=0;in1=8'b00000100;in2=8'b00000011;
		#10 ope=001;uas=1;in1=8'b00000010;in2=8'b00000010;
    #10 ope=001;uas=1;in1=8'b00000111;in2=8'b00000010;
    #10 ope=001;uas=1;in1=8'b00000001;in2=8'b00000010;
		#10 ope=001;uas=0;in1=8'b00000010;in2=8'b00000010;
    #10 ope=001;uas=0;in1=8'b00000011;in2=8'b00000011;
		#10 ope=001;uas=0;in1=8'b11111111;in2=8'b00000001;
		#10 ope=001;uas=0;in1=8'b11111111;in2=8'b00000011;
		#10 ope=001;uas=0;in1=8'b00000001;in2=8'b11111111;


		#10 ope=000;uas=0;in1=8'b00000001;in2=8'b00000010;
		#10 ope=000;uas=0;in1=8'b00000001;in2=8'b00000010;
		#10 ope=000;uas=0;in1=8'b00000001;in2=8'b00000010;
		#10 ope=000;uas=0;in1=8'b00000001;in2=8'b00000010;

		#10 ope=010;uas=0;in1=8'b00000000;in2=8'b00000000;
    #10 ope=010;uas=0;in1=8'b00000001;in2=8'b00000001;
    #10 ope=010;uas=0;in1=8'b00000001;in2=8'b00000010;
    #10 ope=010;uas=0;in1=8'b00000001;in2=8'b00000011;
		#10 ope=010;uas=0;in1=8'b00000100;in2=8'b00000010;
    #10 ope=010;uas=0;in1=8'b00000100;in2=8'b00000011;
		#10 ope=010;uas=1;in1=8'b00000010;in2=8'b00000010;
    #10 ope=010;uas=1;in1=8'b00000111;in2=8'b00000010;
    #10 ope=010;uas=1;in1=8'b00000001;in2=8'b00000010;
		#10 ope=010;uas=0;in1=8'b00000010;in2=8'b00000010;
    #10 ope=010;uas=0;in1=8'b00000011;in2=8'b00000011;
		#10 ope=010;uas=0;in1=8'b11111111;in2=8'b00000001;
		#10 ope=010;uas=0;in1=8'b11111111;in2=8'b00000011;
		#10 ope=010;uas=0;in1=8'b00000001;in2=8'b11111111;



		#10 ope=000;uas=0;in1=8'b00000001;in2=8'b00000010;
		#10 ope=000;uas=0;in1=8'b00000001;in2=8'b00000010;
		#10 ope=000;uas=0;in1=8'b00000001;in2=8'b00000010;
		#10 ope=000;uas=0;in1=8'b00000001;in2=8'b00000010;

		#10 ope=011;uas=0;in1=8'b00000000;in2=8'b00000000;
    #10 ope=011;uas=0;in1=8'b00000001;in2=8'b00000001;
    #10 ope=011;uas=0;in1=8'b00000001;in2=8'b00000010;
    #10 ope=011;uas=0;in1=8'b00000001;in2=8'b00000011;
		#10 ope=011;uas=0;in1=8'b00000100;in2=8'b00000010;
    #10 ope=011;uas=0;in1=8'b00000100;in2=8'b00000011;
		#10 ope=011;uas=1;in1=8'b00000010;in2=8'b00000010;
    #10 ope=011;uas=1;in1=8'b00000111;in2=8'b00000010;
    #10 ope=011;uas=1;in1=8'b00000001;in2=8'b00000010;
		#10 ope=011;uas=0;in1=8'b00000010;in2=8'b00000010;
    #10 ope=011;uas=0;in1=8'b00000011;in2=8'b00000011;
		#10 ope=011;uas=0;in1=8'b11111111;in2=8'b00000001;
		#10 ope=011;uas=0;in1=8'b11111111;in2=8'b00001111;
		#10 ope=011;uas=0;in1=8'b00000001;in2=8'b11111111;
		#10 ope=011;uas=0;in1=8'b00000010;in2=8'b11111111;
		#10 ope=011;uas=0;in1=8'b11111111;in2=8'b11111111;



		#10 ope=000;uas=0;in1=8'b00000001;in2=8'b00000010;
		#10 ope=000;uas=0;in1=8'b00000001;in2=8'b00000010;
		#10 ope=000;uas=0;in1=8'b00000001;in2=8'b00000010;
		#10 ope=000;uas=0;in1=8'b00000001;in2=8'b00000010;


		#10 ope=100;uas=0;in1=8'b11111111;in2=8'b00000001;
		#10 ope=100;uas=0;in1=8'b11111111;in2=8'b00000011;
		#10 ope=100;uas=0;in1=8'b11111111;in2=8'b00000111;
		#10 ope=100;uas=0;in1=8'b11111111;in2=8'b00001111;
		#10 ope=100;uas=0;in1=8'b11111111;in2=8'b00011111;
		#10 ope=100;uas=1;in1=8'b11111111;in2=8'b00011111;
    #10 ope=100;uas=1;in1=8'b00011111;in2=8'b00000001;
    #10 ope=100;uas=1;in1=8'b00001111;in2=8'b00000001;
		#10 ope=100;uas=1;in1=8'b00000111;in2=8'b00000001;
    #10 ope=100;uas=1;in1=8'b00000011;in2=8'b00000001;
		#10 ope=100;uas=1;in1=8'b00000001;in2=8'b00000001;
		#10 ope=100;uas=0;in1=8'b11111111;in2=8'b00000001;
		#10 ope=100;uas=0;in1=8'b11111111;in2=8'b00000011;
		#10 ope=100;uas=0;in1=8'b00000001;in2=8'b11111111;

		#10 ope=000;uas=0;in1=8'b00000001;in2=8'b00000010;
		#10 ope=000;uas=0;in1=8'b00000001;in2=8'b00000010;
		#10 ope=000;uas=0;in1=8'b00000001;in2=8'b00000010;
		#10 ope=000;uas=0;in1=8'b00000001;in2=8'b00000010;


		#10 ope=101;uas=0;in1=8'b11111111;in2=8'b00000000;
		#10 ope=101;uas=0;in1=8'b01111111;in2=8'b00000000;
		#10 ope=101;uas=0;in1=8'b00111111;in2=8'b00000000;
		#10 ope=101;uas=0;in1=8'b00011111;in2=8'b00000000;
		#10 ope=101;uas=0;in1=8'b00001111;in2=8'b00000000;
		#10 ope=101;uas=0;in1=8'b00000111;in2=8'b00000000;
    #10 ope=101;uas=0;in1=8'b00000011;in2=8'b00000000;
    #10 ope=101;uas=0;in1=8'b00000001;in2=8'b00000000;
		#10 ope=101;uas=1;in1=8'b00000110;in2=8'b00000001;
    #10 ope=101;uas=1;in1=8'b00011000;in2=8'b00000001;
		#10 ope=101;uas=1;in1=8'b01100000;in2=8'b00000000;
		#10 ope=101;uas=1;in1=8'b10000000;in2=8'b00000001;
		#10 ope=101;uas=0;in1=8'b11111111;in2=8'b00000011;
		#10 ope=101;uas=0;in1=8'b00000001;in2=8'b11111111;

		#10 ope=000;uas=0;in1=8'b00000001;in2=8'b00000010;
		#10 ope=000;uas=0;in1=8'b00000001;in2=8'b00000010;
		#10 ope=000;uas=0;in1=8'b00000001;in2=8'b00000010;
		#10 ope=000;uas=0;in1=8'b00000001;in2=8'b00000010;



		#10 ope=110;uas=0;in1=8'b11111111;in2=8'b00000001;
		#10 ope=110;uas=0;in1=8'b01111111;in2=8'b00000011;
		#10 ope=110;uas=0;in1=8'b00111111;in2=8'b00000111;
		#10 ope=110;uas=0;in1=8'b00011111;in2=8'b00001111;
		#10 ope=110;uas=0;in1=8'b00001111;in2=8'b00011111;
		#10 ope=110;uas=0;in1=8'b00000111;in2=8'b00011111;
    #10 ope=110;uas=0;in1=8'b00000011;in2=8'b00000001;
    #10 ope=110;uas=0;in1=8'b00000001;in2=8'b00000001;
		#10 ope=110;uas=0;in1=8'b00000000;in2=8'b00000001;
    #10 ope=110;uas=0;in1=8'b10101010;in2=8'b00000001;
		#10 ope=110;uas=0;in1=8'b01010101;in2=8'b00000001;
		#10 ope=110;uas=0;in1=8'b00110011;in2=8'b00000001;
		#10 ope=110;uas=0;in1=8'b11001100;in2=8'b00000011;
		#10 ope=110;uas=1;in1=8'b00000000;in2=8'b00000001;
		#10 ope=110;uas=1;in1=8'b00000000;in2=8'b00000001;

		#10 ope=000;uas=0;in1=8'b00000001;in2=8'b00000010;
		#10 ope=000;uas=0;in1=8'b00000001;in2=8'b00000010;
		#10 ope=000;uas=0;in1=8'b00000001;in2=8'b00000010;
		#10 ope=000;uas=0;in1=8'b00000001;in2=8'b00000010;



		#10 ope=111;uas=0;in1=8'b11111111;in2=8'b00000000;
		#10 ope=111;uas=0;in1=8'b11111111;in2=8'b11111111;
		#10 ope=111;uas=0;in1=8'b01010101;in2=8'b10101010;
		#10 ope=111;uas=0;in1=8'b00110011;in2=8'b11001100;
		#10 ope=111;uas=0;in1=8'b00001111;in2=8'b00001111;
		#10 ope=111;uas=0;in1=8'b00001111;in2=8'b11111111;
    #10 ope=111;uas=0;in1=8'b00000001;in2=8'b00000001;
    #10 ope=111;uas=0;in1=8'b00000011;in2=8'b00000001;
		#10 ope=111;uas=0;in1=8'b00000010;in2=8'b00000001;
    #10 ope=111;uas=1;in1=8'b00000100;in2=8'b00000001;
		#10 ope=111;uas=1;in1=8'b00001001;in2=8'b00000001;
		#10 ope=111;uas=1;in1=8'b00110000;in2=8'b00000001;

		#10 ope=000;uas=0;in1=8'b00000001;in2=8'b00000010;
		#10 ope=000;uas=0;in1=8'b00000001;in2=8'b00000010;
		#10 ope=000;uas=0;in1=8'b00000001;in2=8'b00000010;
		#10 ope=000;uas=0;in1=8'b00000001;in2=8'b00000010;
		#10


    $stop ;
  end
endmodule
