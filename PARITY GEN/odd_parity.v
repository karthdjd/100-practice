module odd_parity(input a,b,c,P, output out);
  assign out=~((~(a^b))^(~(c^P)));
endmodule
