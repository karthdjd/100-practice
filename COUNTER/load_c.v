module load_c (
  input     wire          clk,
  input     wire          reset,
  input     wire          load_i,
  input     wire[3:0]     load_val_i,

  output    wire[3:0]     count_o
);

  logic[3:0] load_ff;

  
  always_ff @(posedge clk or posedge reset)
    if (reset)
      load_ff <= 4'h0;
    else if (load_i)
      load_ff <= load_val_i;

  
  logic[3:0] count_ff;
  logic[3:0] nxt_count;

  always_ff @(posedge clk or posedge reset)
    if (reset)
      count_ff <= 4'h0;
    else
      count_ff <= nxt_count;

  assign nxt_count = load_i ? load_val_i :
                              (count_ff == 4'hF) ? load_ff :
                              count_ff + 4'h1;

  assign count_o = count_ff;

endmodule
