module bidirect_cnt8
2		(input wire clk, reset, en, load, up_downb,
5			input wire [7:0] d,
6			output reg [7:0] q
7		);
	
8		reg [7:0] q_next;
	
9	// The storage elements
10		always @(posedge clk, posedge reset)
11			if (reset)
12				q <= 8'h00;
13			else
14				q <= q_next;

15	//The next state logic
16		always @*
17			if(load)
18				q_next = d;
19			else if (~en)
20				q_next = q;
21			else if (up_downb)
22				q_next = q + 8'h01;
23			else 
24				q_next = q - 8'h01;
			

25	endmodule
