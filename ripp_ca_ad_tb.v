module ripp_ca_ad_tb;
  wire [3:0] S, Cout;
  reg [3:0] A, B;
  reg Cin;
  wire[4:0] add;
  
  ripp_ca_ad rca(A, B, Cin, S, Cout);
  assign add = {Cout[3], S};
  
  initial begin
    $monitor("A = %b: B = %b, Cin = %b --> S = %b, Cout[3] = %b, Addition = %0d", A, B, Cin, S, Cout[3], add);
    A = 1; B = 0; Cin = 0; #3;
    A = 2; B = 4; Cin = 1; #3;
    A = 4'hb; B = 4'h6; Cin = 0; #3;
    A = 5; B = 3; Cin = 1; #3;
    $finish;
  end
  
  initial begin
    $dumpfile("ca_ad.vcd");
    $dumpvars;
  end
endmodule
