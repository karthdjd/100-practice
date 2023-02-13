module bi_count_tb;
reg clk,reset;
reg en,load,up_down;
reg [7:0]d;
wire [7:0]q;
 bidirect_cnt8 bi_c(.clk(clk),.reset(reset),.en(en),.load(load),.up_down(up_down),.d(d),.q(q));

 initial begin
	 clk=0;
	 reset=0;
	 en=0;
	 load=0;
	 up_down=0;
 end
 always#5 clk=~clk;
 initial begin
	 #4 reset=1;
	 #5 en=1;
	 #6 load=1;
	 #10 up_down=1;
	 #4 d=$randum;
	 #20 $finish;
	 $dumpfile("bic.vcd");
	 $dumpvars;
 end
 endmodule


