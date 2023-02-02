module rippletb;
  reg clk,rst;
  wire [3:0]out;
  ripple ri(.clk(clk),.rst(rst),.out(out));
  always#1 clk=~clk;
  initial begin
    clk<=0;
    rst<=0;
    #10 rst=1;
    #20 rst=0;
    #10 rst=1;
    $dumpfile("dump.vcd");
    $dumpvars;
     #30$finish;
  end
endmodule
