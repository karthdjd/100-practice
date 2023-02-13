module lifo(dataout, full, empty, clk, rst, wn, rn, datain);
  output reg [7:0] dataout;
  output full, empty;
  input [7:0] datain;
  input clk, rst, wn, rn; 
  
  reg [3:0] sp; 
  reg [7:0] memory [7:0]; 
  
  assign full = (sp == 4'b1000) ? 1 : 0;
  assign empty = (sp == 4'b0000) ? 1 : 0;
  
  always @(posedge clk)
  begin
    if (rst)
      begin
        memory[0] <= 0; memory[1] <= 0; memory[2] <= 0; memory[3] <= 0;
        memory[4] <= 0; memory[5] <= 0; memory[6] <= 0; memory[7] <= 0;
        dataout <= 0; sp <= 1;
      end
    else if (wn & !full)
      begin
        memory[sp] <= datain;
        sp <= sp + 1;
      end
    else if (rn & !empty)
      begin
        sp <= sp - 1;
        dataout <= memory[sp];
      end
  end
endmodule
