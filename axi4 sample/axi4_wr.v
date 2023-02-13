module axidpram_wr (
	
    //write data
    input wire addressid0,
    input wire addressready0,
    input wire addressvalid0,
    input wire addressid1,
    input wire addressready1,
    input wire addressvalid1,

    input wire  w_clk,
    input wire wr_en,
    input  wire [7:0]   axi_datain,

    input  wire                    axiw_advalid,
    input wire                   axiw_adready,
 
//read data
    input  wire                   r_clk,
    input  wire                    rd_en,
   input wire port_en_0,
input wire port_en_1,
    input wire                    axir_valid,
    input  wire                   axir_ready,
    output wire data_out_0,
    output wire data_out_1
    
);


dp_ram dut(
    .w_clk  ( w_clk ) ,
    .r_clk  ( c_clk ) ,
    .wr_en(wr_en) ,
    .rd_en(rd_en),
    .data_in( (axi_datain & axiw_advalid & axiw_adready)) ,
    .addr_in_0((addressid0 & addressready0 & addressvalid0)) ,
    .addr_in_1((addressid1 & addressready1 & addressvalid0)) ,
    .port_en_0(port_en_0),.port_en_1(port_en_1),
    .data_out_0(data_out_0),.data_out_1(data_out_1)
);

endmodule
