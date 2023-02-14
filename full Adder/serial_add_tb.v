`timescale 1ns / 1ps
module serial_add_tb();
    reg clk;
    reg reset;
    reg a;
    reg b;
    reg cin;
    wire s;
    wire cout;
    serial_add adder(
        .clk(clk), 
        .reset(reset), 
        .a(a), 
        .b(b), 
        .cin(cin), 
        .s(s), 
        .cout(cout)
    );
    always
        #5 clk = ~clk;
    initial begin
      $dumpfile("serial_add.vcd");
	   $dumpvars;
        clk = 1;
        reset = 0;
        a = 0;
        b = 0;
        cin = 0;
        reset = 1;  
        #20;
        reset = 0;
        a = 1; b = 1; cin = 1;    #10;
        a = 1; b = 0; cin = 0;  #10;
        a = 1; b = 1; cin = 0;  #10;
        a = 1; b = 1; cin = 0;  #10;
        reset = 1;
        #10;
        reset = 0;
        a = 1; b = 1; cin = 1;    #10;
        a = 1; b = 0; cin = 0;  #10;
        a = 0; b = 0; cin = 0;  #10;
        a = 1; b = 0; cin = 0;  #10;
        a = 1; b = 1; cin = 0;  #10;
        reset = 1;
        #10;
    end
	 initial $monitor(" A=%b | B=%b | Cin=%b | Sum=%b | Cout=%b | Clock =%b",a,b,cin,s,cout,clk);
endmodule 
