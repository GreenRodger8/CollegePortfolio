module Subtractor(clk, rst, in1, in2, ans) ; 
	parameter n=8 ; 
	input rst, clk;
	input [n-1:0] in1;
	input [n-1:0] in2; 
	output [n-1:0] ans;

	wire [n-1:0] next = rst? 0 : in1-in2 ;
	
	always @* begin
	if (in1 < in2)
	   begin
		$display("\t\tout of range ERROR");
		$stop;
	   end  
	end
   DFF #(n) count(clk, next, ans);
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
	parameter n=8;
	reg [n-1:0] in1;
	reg [n-1:0] in2;
	wire [n-1:0] ans;

	Subtractor subtractor(clk, rst, in1, in2, ans);

	initial begin
    clk = 1 ; #5 clk = 0 ;
	    
    forever
      begin
	$display("    %b|    %b| %b|   %b|   %b",clk,rst, in1, in2, ans) ;
        #5 clk = 1 ; 
		
		#5 clk = 0 ;
      end
    end

	initial begin
		rst =0; in1 = 9'b00000001; in2=8'b00000001;
			#0
	#10 rst= 1; in1 = 8'b00000001; in2=8'b00000001;
	#10 rst = 0; in1 = 8'b00000001; in2=8'b00000001;
	#10 rst = 0; in1 = 8'b00000000; in2=8'b0000001;
	#10 rst = 0; in1 = 8'b00001001; in2=8'b00000011;
#10
      $stop;
   end
endmodule