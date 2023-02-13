module dss_as_tb;
  reg clk, rst;
  reg d;
  wire q;
  
  dff_as dut(clk, rst, d, q);
  always #2 clk = ~clk;
  initial begin
    $dumpfile("dff_as.vcd");
    $dumpvars;
    clk = 0; rst = 0;
    d = 0;
    #3 rst = 1;
  repeat(6) begin
      d = 0;
      #3;
    end
    rst = 0; #3;
    rst = 1;
    repeat(6) begin
      d = 1;
      #3;
    end
    $finish;
  end
endmodule
