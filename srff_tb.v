module tb;
  reg clk, rst_n;
  reg s, r;
  wire q, q_bar;
  
  srff ff(clk, rst_n, s, r, q, q_bar);
  
  always #2 clk = ~clk;
  initial begin
	  $dumpfile("srff.vcd");
	  $dumpvars;
    clk = 0; rst_n = 0;
    $display("Reset=%b --> q=%b, q_bar=%b", rst_n, q, q_bar);
    #3 rst_n = 1;
    $display("Reset=%b --> q=%b, q_bar=%b", rst_n, q, q_bar);
    
    {s,r}=2'b00;
   {s,r}=2'b01;
     {s,r}=2'b10;
   {s,r}=2'b11;
    #5;
    $finish;
  end
  
  
endmodule
