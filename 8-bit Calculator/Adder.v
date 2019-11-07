module Adder(clk, rst, in1, in2, sum) ; 
	parameter n=9 ; 
	input rst, clk;
	input [n-1:0] in1;
	input [n-1:0] in2; 
	output [n-1:0] sum;

	wire [n-1:0] next = rst? 0 : in1+in2 ;
	
	always @* begin
	if (in1 + in2 >= 9'b011111111)
	   begin
		$display("\t\tout of range ERROR");
		$stop;
	   end  
	end
   DFF #(n) count(clk, next, sum) ;
endmodule

module DFF(clk,in,out);
  parameter n=1;//width
  input clk;
  input [n-1:0] in;
  output [n-1:0] out;
  reg [n-1:0] out;
  
  always @(posedge clk)
  out = in;
 endmodule

module test;
	reg clk, rst;
	parameter n=9;
	reg [n-1:0] in1;
	reg [n-1:0] in2;
	wire [n-1:0] sum;

	Adder adder(clk, rst, in1, in2, sum);

	initial begin
    clk = 1 ; #5 clk = 0 ;
	    
    forever
      begin
	$display("    %b|    %b| %b|   %b|   %b",clk,rst, in1, in2, sum ) ;
        #5 clk = 1 ; 
		
		#5 clk = 0 ;
      end
    end

	initial begin
		rst =0; in1 = 9'b000000001; in2=9'b000000001;
			#0
	#10 rst= 1; in1 = 9'b000000001; in2=9'b000000001;
	#10 rst = 0; in1 = 9'b000000001; in2=9'b000000001;
	#10 rst = 0; in1 = 9'b011111111; in2=9'b00000001;
	#10 rst = 0; in1 = 9'b000001001; in2=9'b000000011;
#10
      $stop;
   end
endmodule