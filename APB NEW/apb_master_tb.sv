module apb_master_tb ();

  logic        clk;
  logic        reset;

  logic[1:0]   cmd_i;

  logic        psel_o;
  logic        penable_o;
  logic[31:0]  paddr_o;
  logic        pwrite_o;
  logic[31:0]  pwdata_o;
  logic        pready_i;
  logic[31:0]  prdata_i;

 
apb_master amba (.*);

  
  always begin
    clk = 1'b0;
    #5;
    clk = 1'b1;
    #5;
  end

  int wait_cycles;
  
  always begin
    pready_i = 1'b0;
    wait_cycles = $urandom_range (1, 10);
    while (wait_cycles) begin
      @(posedge clk);
      wait_cycles--;
    end
    pready_i = 1'b1;
    @(posedge clk);
  end

 
  initial begin
    reset <= 1'b1;
    cmd_i <= 2'b00;
    prdata_i <= 32'h0;
    @(posedge clk);
    reset <= 1'b0;
    @(posedge clk);
    @(posedge clk);
    for (int i=0; i<10; i=i+1) begin
      cmd_i <= i%2 ? 2'b10 : 2'b01;
      prdata_i <= $urandom_range(0, 4'hF);
     
      while (~pready_i | ~psel_o) @(posedge clk);
      @(posedge clk);
    end
    $finish();
  end

  
  initial begin
    $dumpfile("day16.vcd");
    $dumpvars(0, day16_tb);
  end

endmodule
