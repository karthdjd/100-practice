module subtractor_tb;
reg [7:0] a, b; 
wire [7:0] result; 

subtractor dut(a,b,result);
initial
begin
#0 a = 8'b0000_0011; b = 8'b0000_0001; 
#10 a = 8'b0000_0100; b = 8'b0000_0011; 
#10 a = 8'b0000_0110; b = 8'b0000_0011; 
#10 a = 8'b0000_1110; b = 8'b0000_0111; 
#10 a = 8'b0000_1100; b = 8'b0000_0101; 
#10 a = 8'b0100_1100; b = 8'b0001_0101; 
#10 a = 8'b0011_0001; b = 8'b0001_1000; 
#10 a = 8'b0111_0001; b = 8'b0011_1001;
#10 a = 8'b1000_0001; b = 8'b1000_0001; 
#10 a = 8'b0110_0001; b = 8'b0010_0001; 
#10 a = 8'b1100_0110; b = 8'b1000_0101; 
#10 a = 8'b0101_0101; b = 8'b0000_1111; 
#10 a = 8'b1111_1000; b = 8'b0000_0010; 
end
initial 
begin
$monitor ("a = %b, b = %b, rslt = %b", a, b, result);
#200 $finish;
end
  initial
    begin
      $dumpfile("subtractor.vcd"); 
      $dumpvars();
      #10000$finish;
    end
endmodule
