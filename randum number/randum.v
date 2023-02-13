module randum(input clk,clr,output o);
  reg [6:0]temp;
  always@(posedge clk)
    begin
      if(clr) temp=7'b0000000;
      else begin
        temp<=temp>>1;
        temp[6]<=temp[1]^temp[0];
      end
      
      end
  assign o=temp[0];
endmodule
