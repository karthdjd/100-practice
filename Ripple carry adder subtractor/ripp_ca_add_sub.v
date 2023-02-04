module full_ad(
  input a, b, cin,
  output sum, cout
);
  
  assign {sum, cout} = {a^b^cin, ((a & b) | (b & cin) | (a & cin))};
  //or
  //assign sum = a^b^cin;
  //assign cout = (a & b) | (b & cin) | (a & cin);
endmodule

module ripp_ca_add_sub #(parameter SIZE = 4) (
  input [SIZE-1:0] A, B, 
  input CTRL,
  output [SIZE-1:0] S, Cout);
  output [SIZE-1:0] Bc;
  genvar g;
  
  assign Bc[0] = B[0] ^ CTRL;
    
  full_ad  fa(A[0], Bc[0], CTRL, S[0], Cout[0]);
  generate  // This will instantial full_adder SIZE-1 times
    for(g = 1; g<SIZE; g=g+1) begin
      assign Bc[g] = B[g] ^ CTRL;
      full_ad fa(A[g], Bc[g], Cout[g-1], S[g], Cout[g]);
    end
  endgenerate
endmodule
