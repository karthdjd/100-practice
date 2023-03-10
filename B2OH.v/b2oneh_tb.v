module b2oneh_tb();

  localparam BIN_W = 4;
  localparam ONE_HOT_W = 16;

  logic [BIN_W-1:0] bin_i;
  logic [ONE_HOT_W-1:0] one_hot_o;

  b21H #(BIN_W, ONE_HOT_W) b2oneh (.*);

  initial begin
    for(int i=0; i<32; i=i+1) begin
      bin_i = $urandom_range(0, 4'hF);
      #5;
    end
    $finish();
  end

  initial begin
    $dumpfile("b2oh.vcd");
    $dumpvars;
  end

endmodule
