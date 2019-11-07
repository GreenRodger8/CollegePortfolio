module DFF(clk,in,out);
  parameter n=1;//width
  input clk;
  input [n-1:0] in;
  output [n-1:0] out;
  reg [n-1:0] out;

  always @(posedge clk)
  out = in;
 endmodule

module Counter(clk, rst, up, down, ldcnt, ldmax, in, out) ;
  parameter n = 5 ;
  input clk, rst, up, down, ldcnt, ldmax ;
  input [n-1:0] in ;
  output [n-1:0] out ;
  reg [n-1:0]   next ;
  reg [n-1:0]   newMax ;
  wire [n-1:0]   max  ;

  DFF #(n) count(clk, next, out) ;
  DFF #(n) max1(clk, newMax, max) ;

  always@(*) begin
    casex({rst, up, down, ldcnt, ldmax})
      5'b1xxxx: next = {n{1'b0}} ;
      //5'b01xxx: next = out + 1'b1 ;
      //5'b001xx: next = out - 1'b1 ;
      5'b0001x: next = in ;
      5'b00001: newMax = in ;
      default: next = out ;
    endcase

    if (next < max && up)
      casex({rst, up, down, ldcnt, ldmax})
        5'b01xxx: next = out + 1'b1 ;
      endcase

    if (next > 0 && down)
      casex({rst, up, down, ldcnt, ldmax})
        5'b001xx: next = out - 1'b1 ;
      endcase

    if (next > max)   // Sets out to max or min
      next = max;     // if the load count tries
    else if (next < 0)// to load a number outside
      next = 0;       // the range (in > max or in < 0)
  end
endmodule

//==================================
module TestBench ;
  reg clk, rst, up, down, loadcount, loadmax ;
  parameter n=5;
  reg [n-1:0] in;
  wire [n-1:0] out;


 Counter counting(clk,rst,up,down,loadcount,loadmax,in,out);


  initial begin
    clk = 1 ; #5 clk = 0 ;
      $display("Clock|Reset|Up|Down|LoadCount|LoadMax|   IN|  OUT|  MAX");
      $display("-----+-----+--+----+---------+-------+-----+-----+-----");
    forever
      begin
        $display("    %b|    %b| %b|   %b|        %b|      %b|%b|%b| %b",clk,rst,up,down,loadcount,loadmax,in,out,counting.next ) ;
        #5 clk = 1 ;

		#5 clk = 0 ;
      end
    end

  // input stimuli
  initial begin
    rst = 0;up=0;down=0;loadcount=0;loadmax=1;in=5'b00000;
	#0
    #10 rst = 1 ;up=0;down=0;loadcount=0;loadmax=0;in=5'b00000;
    #10 rst = 0 ;up=0;down=0;loadcount=0;loadmax=1;in=5'b00101;
    #10 rst = 0 ;up=1;down=0;loadcount=0;loadmax=0;in=5'b00001;
	#50 rst = 0 ;up=0;down=0;loadcount=0;loadmax=0;in=5'b00000;
    #10 rst = 0 ;up=0;down=1;loadcount=0;loadmax=0;in=5'b00000;
	#50 rst = 0 ;up=0;down=0;loadcount=0;loadmax=0;in=5'b00000;
	#10 rst = 0 ;up=0;down=0;loadcount=1;loadmax=0;in=5'b00111;
	#50 rst = 0 ;up=0;down=0;loadcount=0;loadmax=0;in=5'b00000;
	#10 rst = 0 ;up=0;down=0;loadcount=0;loadmax=0;in=5'b00000;
    $stop ;
  end
endmodule
