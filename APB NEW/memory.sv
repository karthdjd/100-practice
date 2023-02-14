module memory (
  input       wire        clk,
  input       wire        reset,

  input       wire        req_i,
  input       wire        req_rnw_i,    // 1 - read, 0 - write
  input       wire[3:0]   req_addr_i,
  input       wire[31:0]  req_wdata_i,
  output      wire        req_ready_o,
  output      wire[31:0]  req_rdata_o
);

 
`ifdef FORMAL
  logic [31:0] mem[15:0];
`else
  logic [15:0][31:0] mem;
`endif

  logic mem_rd;
  logic mem_wr;

  logic req_rising_edge;

  logic [3:0] lfsr_val;
  logic [3:0] count;

  assign mem_rd = req_i &  req_rnw_i;
  assign mem_wr = req_i & ~req_rnw_i;


edg_det detector (
    .clk            (clk),
    .reset          (reset),
    .a_i            (req_i),
    .rising_edge_o  (req_rising_edge),
    .falling_edge_o (/* Not needed */)
  );


  logic[3:0] count_ff;
  logic[3:0] nxt_count;

  always_ff @(posedge clk or posedge reset)
    if (reset)
      count_ff <= 4'h0;
    else
      count_ff <= nxt_count;

  assign nxt_count = req_rising_edge ? lfsr_val:
                                       count_ff + 4'h1;

  assign count = count_ff;

  
lfsr (
    .clk            (clk),
    .reset          (reset),
    .lfsr_o         (lfsr_val)
  );

 
  always_ff @(posedge clk)
    if (mem_wr & ~|count)
      mem[req_addr_i] <= req_wdata_i;

  
  assign req_rdata_o = mem[req_addr_i] & {32{mem_rd}};

  
 
  assign req_ready_o = ~|count;

endmodule
