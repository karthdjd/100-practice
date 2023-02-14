module logic_sr_tb();
   reg [7:0] di;
   reg [1:0] sel;
   wire [7:0] so;

   logic_sr dut (
      .di(di),
      .sel(sel),
      .so(so)
   );

   initial begin
     $dumpfile("logic_sr.vcd");
     $dumpvars;
      di = 8'b00000000;
      for (integer i=0; i<8; i = i + 1) begin
         #5 sel = 2'b00;
         #5 di = di + 1'b1;
         #5 $display("di=%b sel=%b so=%b", di, sel, so);
      end
      di = 8'b00000000;
      for (integer i=0; i<8; i=i+1) begin
         #5 sel = 2'b01;
         #5 di = di + 1'b1;
         #5 $display("di=%b sel=%b so=%b", di, sel, so);
      end
      di = 8'b00000000;
      for (integer i=0; i<8; i=i+1) begin
         #5 sel = 2'b10;
         #5 di = di + 1'b1;
         #5 $display("di=%b sel=%b so=%b", di, sel, so);
      end
      di = 8'b00000000;
      for (integer i=0; i<8; i=i+1) begin
         #5 sel = 2'b11;
         #5 di = di + 1'b1;
         #5 $display("di=%b sel=%b so=%b", di, sel, so);
      end
   end
endmodule
