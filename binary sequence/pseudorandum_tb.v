module pseudorandum_tb;
  reg clk,rst;
  wire [6:0]y;
  pseudorandum dut(.clk(clk),.rst(rst),.y(y));
  initial
  begin 
    #1 rst=1;
  end
  initial clk=0;
  always #2clk =~clk;
  initial begin
    $dumpfile("pseudorandum.vcd");
	  $dumpvars;
	  #5 rst=0;
  #5 rst =1;
  
  end
endmodule
