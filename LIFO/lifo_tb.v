module lifo_tb;
  wire [7:0] dataout;
  wire full, empty;
  reg clk, rst, wn, rn;
  reg [7:0] datain;  
  
  lifo dut(dataout, full, empty, clk, rst, wn, rn, datain);
  
    
  initial begin 
    $dumpfile("lifo.vcd"); $dumpvars;
  end

  
  initial
  begin
    clk= 0; datain = 8'd0;
    rst = 1; clk = 1; #5 ; clk = 0; #5;
    rst = 0;
    
    $display("Start testing");

    wn = 1; rn = 0;
    datain = 8'd100;
    clk = 1; #5 ; clk = 0; #5;
    datain= 8'd150;
    clk = 1; #5 ; clk = 0; #5;
    datain= 8'd200;
    clk = 1; #5 ; clk = 0; #5;
    datain = 8'd40;
    clk = 1; #5 ; clk = 0; #5;
    datain = 8'd70;
    clk = 1; #5 ; clk = 0; #5;
    datain = 8'd65;
    clk = 1; #5 ; clk = 0; #5;
    datain = 8'd15;
    clk = 1; #5 ; clk = 0; #5;
    
    wn = 0; rn = 1;
    clk = 1; #5 ; clk = 0; #5;
    clk = 1; #5 ; clk = 0; #5;
    if ( dataout == 8'd15 )
      $display("PASS %p ", dataout);
    else
      $display("FAIL %p ", dataout);

    clk = 1; #5 ; clk = 0; #5;
    if ( dataout == 8'd65 )
      $display("PASS %p ", dataout);
    else
      $display("FAIL %p ", dataout);

    clk = 1; #5 ; clk = 0; #5;
    if ( dataout == 8'd70 )
      $display("PASS %p ", dataout);
    else
      $display("FAIL %p ", dataout);

    clk = 1; #5 ; clk = 0; #5;
    if ( dataout == 8'd40 )
      $display("PASS %p ", dataout);
    else
      $display("FAIL %p ", dataout);

    clk = 1; #5 ; clk = 0; #5;
    if ( dataout == 8'd20 )
      $display("PASS %p ", dataout);
    else
      $display("FAIL %p ", dataout);

    clk = 1; #5 ; clk = 0; #5;
    if ( dataout == 8'd150 )
      $display("PASS %p ", dataout);
    else
      $display("FAIL %p ", dataout);

    clk = 1; #5 ; clk = 0; #5;
    if ( dataout == 8'd100 )
      $display("PASS %p ", dataout);
    else
      $display("FAIL %p ", dataout);

    clk = 1; #5 ; clk = 0; #5;
    if ( empty == 1 )
      $display("PASS %p ", empty);
    else
      $display("FAIL %p ", empty);
  end

endmodule
