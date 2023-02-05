module tb;
  reg clk, rst_n;
  reg t;
  wire q, q_bar;
  
  tff ff(clk, rst_n,t, q, q_bar);
  
  always #2 clk = ~clk;
  initial begin
	  $dumpfile("t.vcd");
	  $dumpvars;
    clk = 0; rst_n = 0;
    $display("Reset=%b --> q=%b, q_bar=%b", rst_n, q, q_bar);
    #3 rst_n = 1;
    $display("Reset=%b --> q=%b, q_bar=%b", rst_n, q, q_bar);
    
    t=1'b0;
   t=1'b1;
     t=1'b1;
   t=1'b0;
    #5;
    $finish;
  end
  
  
endmodule
