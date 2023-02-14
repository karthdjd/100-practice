module clock_buff(mclk,bclk);

input mclk;
output bclk;

buff b1(mclk,bclk);

endmodule

module buff(input inp, output out);
    assign out = inp;
endmodule
