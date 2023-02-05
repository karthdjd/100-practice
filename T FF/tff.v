module tff (
  input clk, rst_n,
  input t,
  output reg q,
  output q_bar
  );
  
  
  always@(posedge clk) begin
    if(!rst_n) q <= 0;
    else begin
      q <= (t?~q:q);
    end
  end
  assign q_bar = ~q;
endmodule
