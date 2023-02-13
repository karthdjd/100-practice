module dp_ram 
     # (parameter data_width=8,
	      parameter addr_width=4,
			parameter depth=16
			)
    (   input w_clk,
	   input r_clk, 
        input wr_en,
        input rd_en,	
        input [data_width-1:0] data_in,
        input addr_in_0,
        input addr_in_1,    
       input port_en_0,    
        input port_en_1 ,   
      output reg [data_width-1:0] data_out_0,
       output reg[data_width-1:0] data_out_1    
    );


reg [data_width-1:0] ram[0:depth-1];
       

always@(posedge w_clk)
begin
	if(port_en_0 == 1 && wr_en == 1)  begin 
        ram[addr_in_0] <= data_in;
end
	else if(port_en_1==1 && wr_en ==1)begin
	ram[addr_in_1] <= data_in;
end
end
always@(posedge r_clk)

begin 
if(port_en_0==1 && rd_en==1)
	data_out_0 = port_en_0 ? ram[addr_in_0]:0;
else 
	if(port_en_0==1 && rd_en==1)
		data_out_1 = port_en_1 ? ram[addr_in_1]:0; 
end


endmodule 
