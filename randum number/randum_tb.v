module randum_tb;
  reg clk,clr;
  wire o;
  randum sh(.clk(clk),.clr(clr),.o(o));
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
    clk=1'b0;
    clr=1'b0;
     #2 clr=1'b1;
  end
  always #1 clk=~clk;
 
  initial #10 $finish;
endmodule
