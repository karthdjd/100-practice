module cn_flipflop_tb;
	reg c;
	reg n;
	reg clk;
	wire q,qbar;
	cn_flipflop dut (
		.c(c), 
		.n(n), 
		.clk(clk), 
		.q(q),
		.qbar(qbar)
	);

	initial begin
    $dumpfile("cn_flipflop.vcd");
		$dumpvars;
		c = 0;
		n = 0;
		clk = 0;
		
		#10 c=0;n=1;
		#10 c=1;n=0;
		#10 c=1;n=1;

	
	end
	always #5 clk=~clk;
	initial
	begin $monitor("C=%b | N=%b | Q=%b | Qbar=%b",c,n,q,qbar);
	#100 $finish;
	end
      
endmodule
