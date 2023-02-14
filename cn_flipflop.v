module mux(a,b,s,y);
input a,b,s;
output reg y;

always @(a or b or s)
begin
case(s)
0: y=a;
1:y=b;
default: y=1'b0;
endcase
end
endmodule



module dff(d,clk,reset,q);
input d,clk,reset;
output reg q;

always @(posedge clk)
begin
if(reset)
q=0;
else 
q=d;
end

endmodule


module cn_flipflop(c,n,clk,q,qbar);
input c,n,clk;
output q,qbar;
wire cn,n_bar,d_wire;

mux mux1(1'b0,c,n,cn);
mux mux2(1'b1,1'b0,n,n_bar);
mux mux3(cn,n_bar,q,d_wire);
dff dff1( .d(d_wire),.clk(clk),.reset(),.q(q));
assign qbar=~q;

endmodule  
