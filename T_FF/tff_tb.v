module test_tff;
reg clk, rst;
reg t;
wire q;
tff aa(.q(q), .T(t), .clk1(clk), .rst1(rst));
initial begin
	clk=0;
	forever #10 clk=~clk;
end
initial begin
	$dumpfile("tff.vcd");
	$dumpvars;
end
initial begin
	rst=0;
	t=0;
	#10 rst=1;
	t =1;
	#10 rst=1;
	t=0;
	#5 rst=1;
	t=1;
end
endmodule
