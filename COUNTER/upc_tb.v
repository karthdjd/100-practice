module upc_tb();
reg clk, rst;
wire [3:0] count;

upc coun(.clk(clk),.rst(rst),.count(count));
initial begin 
clk=0;
forever #5 clk=~clk;
end
initial begin
rst=1;
#20;
rst=0;
end
initial
    begin
      $dumpfile("upc.vcd"); 
      $dumpvars(1);
      #10000$finish;
    end
endmodule 
