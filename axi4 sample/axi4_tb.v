module ax4_tb;

// port declaration
 reg addressid0;
     reg addressready0;
     reg addressvalid0;
     reg addressid1;
     reg addressready1;
     reg addressvalid1;

     reg  w_clk;
     reg wr_en;
      reg [7:0]   axi_datain;

      reg                    axiw_advalid;
     reg                   axiw_adready;
 
//read data
      reg                   r_clk;
      reg                    rd_en;
     
    reg port_en_0;
 reg port_en_1;
     reg                    axir_valid;
      reg                   axir_ready;
      wire  [7:0]data_out_0;
      wire [7:0]data_out_1;
  
axidpram_wr dut (.addressid0(addressid0),.addressready0(addressready0),.addressid1(addressid1),.w_clk(w_clk),.wr_en(wr_en),.axi_datain(axi_datain),.axiw_advalid(axiw_advalid),.axiw_adready(axiw_adready),.r_clk(r_clk),.port_en_0(port_en_),.port_en_1(port_en_1),.axir_valid(axir_valid),.axir_ready(axir_ready)

,.data_out_0(data_out_0),.data_out_1(data_out_1),.rd_en(rd_en));
reg reset;
//creating method(task) for writing data
initial begin
	$dumpfile("dpram.vcd");
	$dumpvars;
end
task write();

begin

@(posedge w_clk);

port_en_0=1;
wr_en = 1;
addressid0=1;
addressready0=1;
addressvalid0=1;
axiw_advalid=1;
axiw_adready=1;
axi_datain =$random;

#5;

@(posedge w_clk);

port_en_0=0;
wr_en = 0;
addressid0=0;
addressready0=0;
addressvalid0=0;
axiw_advalid=0;
axiw_adready=0;




	@(posedge w_clk);
port_en_1=1;
wr_en = 1;
addressid1=1;
addressready1=1;
addressvalid1=1;
axiw_advalid=1;
axiw_adready=1;
axi_datain =$random;

#5;

@(posedge w_clk);

port_en_1=0;
wr_en = 0;
addressid1=0;
addressready1=0;
addressvalid1=0;
axiw_advalid=0;
axiw_adready=0;

end


endtask

// creating method(task) for reading data

task read();

begin

@(posedge r_clk);

rd_en=1;

port_en_0=1;
addressid0=1;
addressready0=1;
addressvalid0=1;
axir_valid=1;
axir_ready=1;


#5;

@(posedge w_clk);


rd_en = 0;
addressid0=0;
addressready0=0;
addressvalid0=0;
axir_valid=0;
axir_ready=0;


@(posedge r_clk);

rd_en=1;

port_en_1=1;
addressid1=1;
addressready1=1;
addressvalid1=1;
axir_valid=1;
axir_ready=1;


#5;

@(posedge w_clk);


rd_en = 0;
addressid1=0;
addressready1=0;
addressvalid1=0;
axir_valid=0;
axir_ready=0;

end



endtask
initial begin

w_clk = 0;
r_clk=0;



forever begin

#5 w_clk = ~w_clk;
#5 r_clk=~r_clk; //giving frequency to the clock

end

end

initial begin

reset = 0;

#10 reset = 1;

// after reset four write

repeat(4) begin

write();

end

 //indicating last data is sent

#40;

repeat(4) begin

read();

end

#100 $finish; //finishing simualtion at 100ns

end

endmodule
