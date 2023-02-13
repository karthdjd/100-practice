module axififotb;
  reg s_aclk;reg s_areset_n;reg [31:0]s_tdata;reg s_tvalid=0;reg s_tready;reg s_tlast; reg m_aclk;
 reg m_areset_n;wire [31:0]m_tdata;reg m_tvalid;reg m_tready;wire m_tlast; reg wen,ren;
  
  axis_fifo fifo(.s_aclk(s_aclk),.s_areset_n(s_areset_n),.s_tdata(s_tdata),.s_tvalid(s_tvalid),.s_tready(s_tready),.s_tlast(s_tlast),.m_aclk(m_aclk),.m_areset_n(m_areset_n),.m_tdata(m_tdata),.m_tvalid(m_tvalid),.m_tready(m_tready),.m_tlast(m_tlast));
  
    
  
  initial begin 
    $dumpfile("axi.vcd"); $dumpvars;
  end

  initial
  begin
    s_aclk = 0; s_tdata = 32'd0;
   s_areset_n = 1; s_aclk = 1; #5 ; s_aclk = 0; #5;
    s_areset_n = 0;
    m_aclk=0; m_areset_n=0; m_aclk=1;#5;m_aclk=0;#5;
    m_areset_n=1;
    end
    
 task write();

begin

@(posedge s_aclk);

wen = 1;

s_tvalid = 1;

s_tready = 1;

s_tdata =$random;

#5;

@(posedge s_aclk);

s_tvalid = 0;

wen =0;

end

endtask

// creating method(task) for reading data

task read();

begin

@(posedge m_aclk);

ren =1;

m_tready = 1;

m_tvalid =1;


#5;

@(posedge m_aclk);

m_tready = 0;

end

endtask
initial begin

s_aclk = 0;
m_aclk=0;

s_tvalid = 0;

m_tready = 0;

forever begin

#5 s_aclk = ~s_aclk; //giving frequency to the clock
#5 m_aclk= ~m_aclk;
end

end

initial begin

s_areset_n = 0;

#10 s_areset_n = 1;
m_areset_n=0;
m_areset_n=1;

// after reset four write

repeat(4) begin

write();

end

s_tlast = 1; //indicating last data is sent

#40;

repeat(4) begin

read();

end

#100 $finish; //finishing simualtion at 100ns

end

endmodule
