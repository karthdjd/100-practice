module apb_slave_tb ();

  logic        clk;
  logic        reset;

  logic        psel_i;
  logic        penable_i;
  logic[9:0]   paddr_i;
  logic        pwrite_i;
  logic[31:0]  pwdata_i;
  logic[31:0]  prdata_o;
  logic        pready_o;

  logic [9:0] [9:0] rand_addr_list;

 
apb_slave (.*);

  
  always begin
    clk = 1'b0;
    #5;
    clk = 1'b1;
    #5;
  end

  
  initial begin
    reset     <= 1'b1;
    psel_i    <= 1'b0;
    penable_i <= 1'b0;
    @(posedge clk);
    reset     <= 1'b0;
    @(posedge clk);
    
    for (int i=0; i<10; i++) begin
      psel_i  <= 1'b1;      
      @(posedge clk);
      penable_i <= 1'b1;   
      paddr_i   <= $urandom_range(0, 10'h3FF);
      pwrite_i  <= 1'b1;    
      pwdata_i  <= $urandom_range(0, 16'hFFFF);
      
      while (~(psel_i & penable_i & pready_o)) @(posedge clk);
      psel_i    <= 1'b0;
      penable_i <= 1'b0;
      rand_addr_list[i] = paddr_i;
      @(posedge clk);
    end

    
    for (int i=0; i<10; i++) begin
      psel_i  <= 1'b1;      
      @(posedge clk);
      penable_i <= 1'b1;    
      paddr_i   <= rand_addr_list[i];
      pwrite_i  <= 1'b0;    
      pwdata_i  <= $urandom_range(0, 16'hFFFF);
      
      while (~(psel_i & penable_i & pready_o)) @(posedge clk);
      psel_i    <= 1'b0;
      penable_i <= 1'b0;
      @(posedge clk);
    end
    $finish();
  end

 
  initial begin
    $dumpfile("apb_slave.vcd");
    $dumpvars;
  end

endmodule
