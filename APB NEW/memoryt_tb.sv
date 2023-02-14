module memory_tb ();

  logic        clk;
  logic        reset;
  logic        req_i;
  logic        req_rnw_i;
  logic[9:0]   req_addr_i;
  logic[31:0]  req_wdata_i;
  logic        req_ready_o;
  logic[31:0]  req_rdata_o;


memory (.*);

  logic [9:0] [9:0] addr_list;

 
  always begin
    clk = 1'b1;
    #5;
    clk = 1'b0;
    #5;
  end

 
  initial begin
    reset <= 1'b1;
    req_i <= 1'b0;
    @(posedge clk);
    reset <= 1'b0;
    @(posedge clk);
    for (int txn=0; txn<10; txn++) begin
     
      req_i       <= 1'b1;
      req_rnw_i   <= 0;
      req_addr_i  <= $urandom_range(0, 1023);
      addr_list[txn] = req_addr_i;
      req_wdata_i <= $urandom_range(0, 32'hFFFF);
    
      while (~req_ready_o) begin
        @(posedge clk);
      end
      req_i <= 1'b0;
      @(posedge clk);
    end
    for (int txn=0; txn<10; txn++) begin
     
      req_i       <= 1'b1;
      req_rnw_i   <= 1;
      req_addr_i  <= addr_list[txn];
      req_wdata_i <= $urandom_range(0, 32'hFFFF);
      
      while (~req_ready_o) begin
        @(posedge clk);
      end
      req_i <= 1'b0;
      @(posedge clk);
    end
    $finish();
  end
  
  
  initial begin
    $dumpfile("memory_tb.vcd");
    $dumpvars;
  end

endmodule
