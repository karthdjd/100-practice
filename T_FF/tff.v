module tff(output reg q,input clk1,rst1,T);
wire a,b;
assign b=T^a;
always@(*)
	q=a;
dff aa(.q(a), .d(b), .clk(clk1), .rst(rst1));
endmodule
