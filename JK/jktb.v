module tb;
  reg clk, rst_n;
  reg j, k;
  wire q, q_bar;
  
  jk ff(clk, rst_n, j, k, q, q_bar);
  
  always #2 clk = ~clk;
  initial begin

	  $dumpfile("jk.vcd");
	  $dumpvars;
    clk = 0; rst_n = 0;
    $display("Reset=%b --> q=%b, q_bar=%b", rst_n, q, q_bar);
    #3 rst_n = 1;
    $display("Reset=%b --> q=%b, q_bar=%b", rst_n, q, q_bar);
    
    {j,k}=2'b00;
   {j,k}=2'b01;
     {j,k}=2'b10;
   {j,k}=2'b11;
    #5;
    $finish;
  end
  
  
endmodule
