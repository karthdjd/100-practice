
module t_light(l_high, l_f, C, clk, rst);
parameter HGRE_FRED=2'b00,
   HYEL_FRED = 2'b01,
   HRED_FGRE=2'b10,
   HRED_FYEL=2'b11;
input C, 
   clk, 
   rst; 
output reg[2:0] l_high, l_f; 

reg[27:0] count=0,count_del=0;
reg del10s=0, del3s1=0,del3s2=0,RED_count_en=0,YELLOW_count_en1=0,YELLOW_count_en2=0;
wire clk_en; 
reg[1:0] state, next_state;

always @(posedge clk or negedge rst)
begin
if(~rst)
 state <= 2'b00;
else 
 state <= next_state; 
end

always @(*)
begin
case(state)
HGRE_FRED: begin
 RED_count_en=0;
 YELLOW_count_en1=0;
 YELLOW_count_en2=0;
 l_high = 3'b001;
 l_f = 3'b100;
 if(C) next_state = HYEL_FRED; 
 
 else next_state =HGRE_FRED;
end
HYEL_FRED: begin
  l_high = 3'b010;
  l_f = 3'b100;
  RED_count_en=0;
 YELLOW_count_en1=1;
 YELLOW_count_en2=0;
  if(del3s1) next_state = HRED_FGRE;
  
  else next_state = HYEL_FRED;
end
HRED_FGRE: begin
 l_high = 3'b100;
 l_f = 3'b001;
 RED_count_en=1;
 YELLOW_count_en1=0;
 YELLOW_count_en2=0;
 if(del10s) next_state = HRED_FYEL;
 
 else next_state =HRED_FGRE;
end
HRED_FYEL:begin
 l_high = 3'b100;
 l_f = 3'b010;
 RED_count_en=0;
 YELLOW_count_en1=0;
 YELLOW_count_en2=1;
 if(del3s2) next_state = HGRE_FRED;
 
 else next_state =HRED_FYEL;
end
default: next_state = HGRE_FRED;
endcase
end

always @(posedge clk)
begin
if(clk_en==1) begin
 if(RED_count_en||YELLOW_count_en1||YELLOW_count_en2)
  count_del <=count_del + 1;
  if((count_del == 9)&&RED_count_en) 
  begin
   del10s=1;
   del3s1=0;
   del3s2=0;
   count_del<=0;
  end
  else if((count_del == 2)&&YELLOW_count_en1) 
  begin
   del10s=0;
   del3s1=1;
   del3s2=0;
   count_del<=0;
  end
  else if((count_del == 2)&&YELLOW_count_en2) 
  begin
   del10s=0;
   del3s1=0;
   del3s2=1;
   count_del<=0;
  end
  else
  begin
   del10s=0;
   del3s1=0;
   del3s2=0;
  end 
 end
end

always @(posedge clk)
begin
 count <=count + 1;
 
 if(count == 3) 
  count <= 0;
end
 assign clk_en = count==3 ? 1: 0; 
endmodule 
