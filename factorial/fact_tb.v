module fact_tb(); 

parameter N = 5;

reg [N:0] in;
wire [N*8:0] fact_out;

fact dut( .in(in), .fact_out(fact_out) );

initial
begin
	$dumpfile("fact.vcd");
	$dumpvars;
$monitor (" in = %d, factorial_out = %d ", in, fact_out );
end

initial
begin
 in = 2;
 #10;
 in = 10;
 #10;
 in = 13;
 #10;
 in = 9;
 #10;
 in = 4;
 #10;
 in = 8;
 #10;
 in = 3;
 #10;
 in = 15;
 #10;
end

endmodule
