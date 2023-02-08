module pipo(clk,rst,a,q);
  input clk,rst;
  input[3:0] a;
  output reg[3:0] q;
  
  always @(posedge clk,posedge rst) begin
    if(rst == 1)
            q = 4'b0000;
    else
      q <=a;
  end
endmodule
