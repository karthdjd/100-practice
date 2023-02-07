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

// Misc test Development vars
//

integer		n,x,rwd;
reg		mwe, mre;
reg	[7:0]	mdin;
reg		mclr;
wire	[7:0]	mdout;
wire		mfull, mempty;
wire		full_r, empty_r;
wire		mfull_n, mempty_n;
wire		full_n_r, empty_n_r;
wire	[1:0]	mlevel;

reg		we, re;
reg	[7:0]	din;
reg		clr;
wire	[7:0]	dout;
wire		full, empty;
wire		full_n, empty_n;
wire	[1:0]	level;

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

	mwe = 0;
	mre = 0;
	mclr = 0;

	we = 0;
	re = 0;
	clr = 0;

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

	        test_dc_fifo;
	   end

	   begin

		rwd=4;
		wr_dc(50);
		rd_dc(50);
		wr_dc(50);
		rd_dc(50);

	   end



   	repeat(10)	@(posedge clk);

$display("rdp=%0d, wrp=%0d delta=%0d", rdp, wrp, wrp-rdp);

   	$finish;
   end





task test_dc_fifo;
begin


$display("\n\n");
$display("*****************************************************");
$display("*** DC FIFO Sanity Test                           ***");
$display("*****************************************************\n");

for(rwd=0;rwd<5;rwd=rwd+1)
	
for(rcp=10;rcp<30;rcp=rcp+10)
begin
	$display("rwd=%0d, rcp=%0f",rwd, rcp);

	$display("pass 0 ...");
	for(x=0;x<50;x=x+1)
	   begin
		rd_wr_dc;
		wr_dc(1);
	   end
	$display("pass 1 ...");
	for(x=0;x<50;x=x+1)
	   begin
		rd_wr_dc;
		rd_dc(1);
	   end
	$display("pass 2 ...");
	for(x=0;x<50;x=x+1)
	   begin
		rd_wr_dc;
		wr_dc(1);
	   end
	$display("pass 3 ...");
	for(x=0;x<50;x=x+1)
	   begin
		rd_wr_dc;
		rd_dc(1);
	   end
   end
$display("");
$display("*****************************************************");
$display("*** DC FIFO Sanity Test DONE                      ***");
$display("*****************************************************\n");
end
endtask


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
	for(x=0;x<50;x=x+1)
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
	$dumpfile("fifionew.vcd");
	$dumpvars;
end

///////////////////////////////////////////////////////////////////
//
// Data tracker
//

always @(posedge clk)
	if(mwe & !full)
	   begin
		buffer[wrp] = mdin;
		wrp=wrp+1;
	   end

always @(posedge clk)
	if(mre & !mempty)
	   begin
		#3;
		if(dout != buffer[rdp])
			$display("ERROR: Data (%0d) mismatch, expected %h got %h (%t)",
			 rdp, buffer[rdp], dout, $time);
		rdp=rdp+1;
	   end

always @(posedge wr_clk)
	if(we & !full)
	   begin
		buffer[wrp] = din;
		wrp=wrp+1;
	   end

always @(posedge rd_clk)
	if(re & !empty)
	   begin
		#3;
		if(dout != buffer[rdp] | ( ^dout )===1'bx)
			$display("ERROR: Data (%0d) mismatch, expected %h got %h (%t)",
			 rdp, buffer[rdp], dout, $time);
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
		.clr(		mclr		),
		.din(		mdin		),
		.we(		(mwe & !mfull)	),
		.dout(		mdout		),
		.re(		(mre & !mempty)	),
		.full(		mfull		),
		.empty(		mempty		),
		.full_r(	full_r		),
		.empty_r(	empty_r		),
		.full_n(	full_n		),
		.empty_n(	empty_n		),
		.full_n_r(	full_n_r	),
		.empty_n_r(	empty_n_r	),
		.level(		mlevel		)
		);

generic_fifo_dc #(8,8,9) u1(
		.rd_clk(	rd_clk		),
		.wr_clk(	wr_clk		),
		.rst(		rst		),
		.clr(		clr		),
		.din(		din		),
		.we(		(we & !full)	),
		.dout(		dout		),
		.re(		(re & !empty)	),
		.full(		full		),
		.empty(		empty		),
		.full_n(	full_n		),
		.empty_n(	empty_n	),
		.level(		level		)
		);

///////////////////////////////////////////////////////////////////
//
// Test and test lib 
//


task wr_dc;
input	cnt;
integer	n, cnt;

begin
@(posedge wr_clk);
for(n=0;n<cnt;n=n+1)
   begin
	#1;
	we = 1;
	din = $random;
	@(posedge wr_clk);
	#1;
	we = 0;
	din = 8'hxx;
	repeat(rwd)	@(posedge wr_clk);
   end
end
endtask


task rd_dc;
input	cnt;
integer	n, cnt;
begin
@(posedge rd_clk);
for(n=0;n<cnt;n=n+1)
   begin
	#1;
	re = 1;
	@(posedge rd_clk);
	#1;
	re = 0;
	repeat(rwd)	@(posedge rd_clk);
   end
end
endtask


task rd_wr_dc;

integer		n;
begin
   		repeat(10)	@(posedge wr_clk);
		// RD/WR 1
		for(n=0;n<20;n=n+1)
		   fork

			begin
				wr_dc(1);
			end

			begin
				@(posedge wr_clk);
				@(posedge wr_clk);
				rd_dc(1);
			end

		   join

   		repeat(10)	@(posedge wr_clk);

		// RD/WR 2
		for(n=0;n<5;n=n+1)
		   fork

			begin
				wr_dc(2);
			end

			begin
				@(posedge wr_clk);
				@(posedge wr_clk);
				@(posedge wr_clk);
				rd_dc(2);
			end

		   join

   		repeat(10)	@(posedge wr_clk);


		// RD/WR 3
		for(n=0;n<5;n=n+1)
		   fork

			begin
				wr_dc(3);
			end

			begin
				@(posedge wr_clk);
				@(posedge wr_clk);
				@(posedge wr_clk);
				@(posedge wr_clk);
				rd_dc(3);
			end

		   join

   		repeat(5)	@(posedge wr_clk);


		// RD/WR 4
		for(n=0;n<5;n=n+1)
		   fork

			begin
				wr_dc(4);
			end

			begin
				@(posedge wr_clk);
				@(posedge wr_clk);
				@(posedge wr_clk);
				@(posedge wr_clk);
				@(posedge wr_clk);
				rd_dc(4);
			end

		   join
   		repeat(5)	@(posedge wr_clk);
end
endtask




task wr_sc;
input	cnt;
integer	cnt;

begin
@(posedge clk);
	for(n=0;n<cnt;n=n+1)
	   begin
		//@(posedge clk);
		#1;
		mwe = 1;
		mdin = $random;
		@(posedge clk);
		#1;
		mwe = 0;
		mdin = 8'hxx;
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
		mre = 1;
		@(posedge clk);
		#1;
		mre = 0;
		repeat(rwd)	@(posedge clk);
	   end
end
endtask


task rd_wr_sc;

begin
   		repeat(10)	@(posedge clk);
		// RD/WR 1
		for(n=0;n<10;n=n+1)
		   begin
			@(posedge clk);
			#1;
			mre = 0;
			mwe = 1;
			mdin = $random;
			@(posedge clk);
			#1;
			mwe = 0;
			mdin = 8'hxx;
			mre = 1;
		   end
		@(posedge clk);
		#1;
		mre = 0;

   		repeat(10)	@(posedge clk);

		// RD/WR 2
		for(n=0;n<10;n=n+1)
		   begin
			@(posedge clk);
			#1;
			mwe = 1;
			mdin = $random;
			@(posedge clk);
			#1;
			mdin = $random;
			@(posedge clk);
			#1;
			mwe = 0;
			mdin = 8'hxx;
			mre = 1;
			@(posedge clk);
			@(posedge clk);
			#1;
			mre = 0;
		   end

		// RD/WR 3
		for(n=0;n<10;n=n+1)
		   begin
			@(posedge clk);
			#1;
			mwe = 1;
			mdin = $random;
			@(posedge clk);
			#1;
			mdin = $random;
			@(posedge clk);
			#1;
			mdin = $random;
			@(posedge clk);
			#1;
			mwe = 0;
			mdin = 8'hxx;
			mre = 1;
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			#1;
			mre = 0;
		   end


		// RD/WR 4
		for(n=0;n<10;n=n+1)
		   begin
			@(posedge clk);
			#1;
			mwe = 1;
			mdin = $random;
			@(posedge clk);
			#1;
			mdin = $random;
			@(posedge clk);
			#1;
			mdin = $random;
			@(posedge clk);
			#1;
			mdin = $random;
			@(posedge clk);
			#1;
			mwe = 0;
			mdin = 8'hxx;
			mre = 1;
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			@(posedge clk);
			#1;
			mre = 0;
		   end
end
endtask



endmodule


