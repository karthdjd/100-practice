module ms_tb;
	reg s;
	reg r;
	reg clk;
	wire qn;
	wire qn_bar;
	master_slave dut (
		.s(s), 
		.r(r), 
		.clk(clk), 
		.qn(qn), 
		.qn_bar(qn_bar)
	);
	initial begin
	clk=0;
	#10 s = 0;r = 0;
	#10 s = 0;r = 1;
   #10 s = 1;r = 0;
   #10 s = 1;r = 1;	
	#10 s = 0;r = 0;
   #10 s = 0;r = 1;
	end
	always #5 clk=~clk;
initial
begin
  $dumpfile("jk_ms.vcd");
$dumpvars;
$monitor("S=%b, R=%b, Q=%b, Q_bar=%b",s,r,qn,qn_bar);
#200 $finish;
end
endmodule
