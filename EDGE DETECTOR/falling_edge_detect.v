module falling_edge_detect (clk,
                      rst,
                      din,
                      falling_edge
                     );
  
  input clk, rst, din;
  output  falling_edge; 
  
  reg dout;
  
  always @ (posedge clk or posedge rst)
    begin
      if (rst)
        begin
          dout <= 'h0;
        end
      else
        begin
          dout <= din;
        end
    end
  assign falling_edge = ( dout & (!(din)) );
endmodule
