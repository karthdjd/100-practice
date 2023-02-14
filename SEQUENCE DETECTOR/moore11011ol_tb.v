module moore11011ol_tb.v;
reg clk, reset, in;
wire out;
moore11011ol FS(.clk(clk), .rst(reset), .in(in), .out(out));
initial
begin
clk = 0;
reset = 1;
in = 0;
#10 reset = 0;
#100 $finish;
end
always
#5 clk = ! clk;
initial begin
#5 in=1;
#5 in=1;
#5 in=1;
#5 in=1;
#5 in=0;
#5 in=0;
#5 in=1;
#5 in=1;
#5 in=1;
#5 in=1;
#5 in=1;
#5 in=0;
#5 in=1;
#5 in=1;
#5 in=0;
#5 in=0;
#5 in=1;
#5 in=1;
#5 in=1;
#5 in=1;

end

initial begin
  $dumpfile("mooreol.vcd");
   $dumpvars;
$display("\t\ttime,\tclk,\treset,\tin,\tout");
$monitor("%d,\t%b,\t%b,\t%b,\t%b",$time, clk,reset,in,out);
end
endmodule
