module dff_as (
  input clk, rst,
  input d,
  output reg q
  );
  
  always@(posedge clk or negedge rst) begin
    if(!rst) q <= 0;
    else       q <= d;
  end
  
endmodule
