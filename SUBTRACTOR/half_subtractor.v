module half_subtractor(a, b, diff, borrow);
input a;
input b;
output diff;
output borrow;
assign borrow=(~a)&b;                           
assign diff=a^b;                             
endmodule
