module full_ad(
  input a, b, cin,
  output sum, cout
);
  
  assign {sum, cout} = {a^b^cin, ((a & b) | (b & cin) | (a & cin))};
 
endmodule

module ripp_ca_ad#(parameter SIZE = 4) (
  input [SIZE-1:0] A, B, 
  input Cin,
  output [SIZE-1:0] S, Cout);
  
  genvar g;
  
  full_ad fa0(A[0], B[0], Cin, S[0], Cout[0]);
  generate 
    for(g=1; g<SIZE; g=g+1) begin
      full_ad fa(A[g], B[g], Cout[g-1], S[g], Cout[g]);
    end
  endgenerate
  endmodule
