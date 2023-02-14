module logic_sr (di, sel, so);
        input  [7:0] di;
	input  [1:0] sel;
	output [7:0] so;
	reg    [7:0] so;
	always @(di or sel)
	begin
	   case (sel)
	      2'b00   : so = di;
	      2'b01   : so = di << 1;
	      2'b10   : so = di << 2;
	      default : so = di << 3;
	   endcase
	end
        endmodule
