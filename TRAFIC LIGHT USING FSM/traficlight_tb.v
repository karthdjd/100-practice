
`timescale 10 ns/ 1 ps
`define DELAY 1
module tb_traffic;
parameter ENDTIME  = 400000;
reg clk;
reg rst;
reg sensor;
wire [2:0] l_f;
wire [2:0] l_high;

t_light dut(l_high, l_f, sensor, clk, rst);

initial
 begin
 clk = 1'b0;
 rst = 1'b0;
 sensor = 1'b0;
 end
initial
 begin
 main;
 end
task main;
 fork
 clock_gen;
 reset_gen;
 operation_flow;
 join
endtask
task clock_gen;
 begin
 forever #`DELAY clk = !clk;
 end
endtask

task reset_gen;
 begin
 rst = 0;
 # 20
 rst = 1;
 end
endtask
initial begin
	$dumpfile("tl.vcd");
	$dumpvars;
end
task operation_flow;
 begin
 sensor = 0;
 # 600
 sensor = 1;
 # 1200
 sensor = 0;
 # 1200
 sensor = 1;
 end
endtask
initial $monitor("TIME = %d, reset = %b, sensor = %b, light of highway = %h, light of farm road = %h",$time,rst ,sensor,l_high,l_f );
initial#100 $finish;
    
endmodule
