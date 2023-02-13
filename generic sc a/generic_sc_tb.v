`include "timescale.v"

module test;


///////////////////////////////////////////////////////////////////
//
// Local IOs and Vars
//

reg		clk;
reg		rd_clk, wr_clk;
reg		rst;

///////////////////////////////////////////////////////////////////
//
// Test Definitions
//


///////////////////////////////////////////////////////////////////
//
// Misc test Development vars
//

integer		n,x,rwd;
reg		we, re;
reg	[7:0]	din;
reg		clr;
wire	[7:0]	dout;
wire		full, empty;
wire		full_r, empty_r;
wire		full_n, empty_n;
wire		full_n_r, empty_n_r;
wire	[1:0]	level;

reg             we2,re2;
reg	[7:0]	din2;
reg		clr2;
wire	[7:0]	dout2;
wire		full2, empty2;
wire		full_n2, empty_n2;
wire	[1:0]	level2;

reg	[7:0]	buffer[0:1024000];
integer		wrp, rdp;

///////////////////////////////////////////////////////////////////
//
// Initial Startup and Simulation Begin
//

real		rcp;

initial
   begin
	$timeformat (-9, 1, " ns", 12);

`ifdef WAVES
  	$shm_open("waves");
	$shm_probe("AS",test,"AS");
	$display("INFO: Signal dump enabled ...\n\n");
`endif
	rcp=5;
   	clk = 0;
   	rd_clk = 0;
   	wr_clk = 0;
   	rst = 1;

	we = 0;
	re = 0;
	clr = 0;

	we2 = 0;
	re2 = 0;
	clr2 = 0;

	rwd=0;
	wrp=0;
	rdp=0;

   	repeat(10)	@(posedge clk);
   	rst = 0;
   	repeat(10)	@(posedge clk);
   	rst = 1;
   	repeat(10)	@(posedge clk);


	if(1)
	   begin
		test_sc_fifo;
		
	   end
	else
	   begin

		rwd=4;
		wr_sc(50);
		rd_sc(50);
		wr_sc(50);
		rd_sc(50);

	   end


   	repeat(5)	@(posedge clk);

$display("rdp=%0d, wrp=%0d delta=%0d", rdp, wrp, wrp-rdp);

   	$finish;
   end
task test_sc_fifo;
begin

$display("\n\n");
$display("*****************************************************");
$display("*** SC FIFO Sanity Test                           ***");
$display("*****************************************************\n");

for(rwd=0;rwd<5;rwd=rwd+1)	// read write delay
   begin
	$display("rwd=%0d",rwd);
	$display("pass 0 ...");
	for(x=0;x<25;x=x+1)
	   begin
		rd_wr_sc;
		wr_sc(1);
	   end
	$display("pass 1 ...");
	for(x=0;x<50;x=x+1)
	   begin
		rd_wr_sc;
		rd_sc(1);
	   end
	$display("pass 2 ...");
	for(x=0;x<50;x=x+1)
	   begin
		rd_wr_sc;
		wr_sc(1);
	   end
	$display("pass 3 ...");
	for(x=0;x<50;x=x+1)
	   begin
		rd_wr_sc;
		rd_sc(1);
	   end
   end

$display("");
$display("*****************************************************");
$display("*** SC FIFO Sanity Test DONE                      ***");
$display("*****************************************************\n");

end
endtask
initial begin
	$dumpfile("genericsc.vcd");
	$dumpvars;
end
///////////////////////////////////////////////////////////////////
//
// Data tracker
//

always @(posedge clk)
	if(we & !full)
	   begin
		buffer[wrp] = din;
		wrp=wrp+1;
	   end

always @(posedge clk)
	if(re & !empty)
	   begin
		#3;
		if(dout != buffer[rdp])
			$display("ERROR: Data (%0d) mismatch, expected %h got %h (%t)",
			 rdp, buffer[rdp], dout, $time);
		rdp=rdp+1;
	   end

always @(posedge wr_clk)
	if(we2 & !full2)
	   begin
		buffer[wrp] = din2;
		wrp=wrp+1;
	   end

always @(posedge rd_clk)
	if(re2 & !empty2)
	   begin
		#3;
		if(dout2 != buffer[rdp] | ( ^dout2 )===1'bx)
			$display("ERROR: Data (%0d) mismatch, expected %h got %h (%t)",
			 rdp, buffer[rdp], dout2, $time);
		rdp=rdp+1;
	   end

///////////////////////////////////////////////////////////////////
//
// Clock generation
//

always #5 clk = ~clk;
always #(rcp) rd_clk = ~rd_clk;
always #50 wr_clk = ~wr_clk;

///////////////////////////////////////////////////////////////////
//
// Module Instantiations
//

generic_fifo_sc_a #(8,8,9) u0(
		.clk(		clk		),
		.rst(		rst		),
		.clr(		clr		),
		.din(		din		),
		.we(		(we & !full)	),
		.dout(		dout		),
		.re(		(re & !empty)	),
		.full(		full		),
		.empty(		empty		),
		.full_r(	full_r		),
		.empty_r(	empty_r		),
		.full_n(	full_n		),
		.empty_n(	empty_n		),
		.full_n_r(	full_n_r	),
		.empty_n_r(	empty_n_r	),
		.level(		level		)
		);

///////////////////////////////////////////////////////////////////
//
// Test and test lib 
//
task wr_sc;
input	cnt;
integer	cnt;

begin
@(posedge clk);
	for(n=0;n<cnt;n=n+1)
	   begin
		//@(posedge clk);
		#1;
		we = 1;
		din = $random;
		@(posedge clk);
		#1;
		we = 0;
		din = 8'hxx;
		repeat(rwd)	@(posedge clk);
	   end
end
endtask


task rd_sc;
input	cnt;
integer	cnt;

begin
@(posedge clk);
	for(n=0;n<cnt;n=n+1)
	   begin
		//@(posedge clk);
		#1;
		re = 1;
		@(posedge clk);
		#1;
		re = 0;
		repeat(rwd)	@(posedge clk);
	   end
end
endtask


task rd_wr_sc;

begin
   		repeat(5)	@(posedge clk);
		// RD/WR 1
		for(n=0;n<10;n=n+1)
		   begin
			@(posedge clk);
			#1;
			re = 0;
			we = 1;
			din = $random;
			@(posedge clk);
			#1;
			we = 0;
			din = 8'hxx;
			re = 1;
		   end
		@(posedge clk);
		#1;
		re = 0;

   		repeat(5)	@(posedge clk);

		// RD/WR 2
		for(n=0;n<10;n=n+1)
		   begin
			@(posedge clk);
			#1;
			we = 1;
			din = $random;
			@(posedge clk);
			#1;
			din = $random;
			@(posedge clk);
			#1;
			we = 0;
			din = 8'hxx;
			re = 1;
			@(posedge clk);
			@(posedge clk);
			#1;
			re = 0;
		   end

		// RD/WR 3
		for(n=0;n<10;n=n+1)
		   begin
			@(posedge clk);
			#1;
			we = 1;
			din = $random;
			@(posedge clk);
			#1;
			din = $random;
			@(posedge clk);
			#1;
			din = $random;
			@(posedge clk);
			#1;
			we = 0;
			din = 8'hxx;
			re = 1;
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			#1;
			re = 0;
		   end


		// RD/WR 4
		for(n=0;n<10;n=n+1)
		   begin
			@(posedge clk);
			#1;
			we = 1;
			din = $random;
			@(posedge clk);
			#1;
			din = $random;
			@(posedge clk);
			#1;
			din = $random;
			@(posedge clk);
			#1;
			din = $random;
			@(posedge clk);
			#1;
			we = 0;
			din = 8'hxx;
			re = 1;
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			#1;
			re = 0;
		   end
end
endtask



endmodule

