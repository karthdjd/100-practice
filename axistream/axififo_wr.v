module axis_fifo #(
    parameter DATA_WIDTH = 32,
    parameter ADDR_DEPTH = 4
) (
    input  wire                    s_aclk,
    input  wire                    s_areset_n,
    input  wire [DATA_WIDTH-1:0]   s_tdata,
    
    input  wire                    s_tvalid,
    input wire                   s_tready,
    input  wire                    s_tlast,

    input  wire                    m_aclk,
    input  wire                    m_areset_n,
    output wire [DATA_WIDTH-1:0]   m_tdata,
    
    input wire                    m_tvalid,
    input  wire                    m_tready,
    output wire                    m_tlast
);

wire [DATA_WIDTH+DATA_WIDTH/32+1-1:0] m_tdata_int;
wire s_full;
wire m_empty;

fifo #(
    .DSIZE  ( DATA_WIDTH ) ,
    .ASIZE  ( ADDR_DEPTH )
) fifo (
    .wfull  ( s_full ) ,
    .wdata  ( {s_tlast, s_tdata} ) ,
    .winc   ( s_tvalid & s_tready ) , 
    .wclk   ( s_aclk ) , 
    .wrst_n ( s_areset_n ) ,
    .rempty ( m_empty ) ,
    .rdata  ( m_tdata ) ,
    .rinc   ( m_tvalid & m_tready ) , 
    .rclk   ( m_aclk ) , 
    .rrst_n ( m_areset_n )
);

assign s_tvalid = ~s_full; 
assign m_tvalid = ~m_empty;
//assign m_tdata  = m_tdata_int[DATA_WIDTH-1:0];
//initial begin 

	
	
assign m_tdata=s_tdata;
//end

assign m_tlast  = m_tdata_int[DATA_WIDTH+DATA_WIDTH/32];

endmodule
