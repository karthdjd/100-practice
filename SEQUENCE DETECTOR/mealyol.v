module mealyol(input in,input clk,input rst,output reg out);
  reg [2:0] cst;
  reg [2:0] nst;
  parameter [1:0]s0=3'b000;
  parameter [1:0]s1=3'b001;
  parameter [1:0]s2=3'b010;
  parameter [1:0]s3=3'b011;
  parameter [1:0]s4=3'b100;
always@(posedge clk)
begin
  if(rst)begin
    out=1'b0;
    cst=s0;
    nst=s0;end
  else
    begin
    cst=nst;
    case(cst)
  s0: if(in) begin    
    out=1'b0;
    nst=s1;end
  else begin
    out=1'b0;
    nst=s0;end
  s1: if(in)begin
    out=1'b0;
    nst=s2;end
     else begin
    out=1'b0;
    nst=s0;end
  s2 : if(in)begin   
    out=1'b0;
    nst=s2;end
      else begin
    out=1'b0;
    nst=s3;end
  s3 : if(in)begin   
    out=1'b0;
    nst=s4;end
      else begin
    out=1'b0;
    nst=s0;end
  s4 : if(in)begin   
    out=1'b1;
    nst=s2;end
      else begin
    out=1'b0;
    nst=s0;end
   endcase
end
end
endmodule
