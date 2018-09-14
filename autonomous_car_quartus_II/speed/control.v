module control(clk,gate,clr_count,latch);
input clk;
output gate,clr_count,latch;
reg gate,counter;

initial
counter<=0;

always@(posedge clk)
begin
  if(counter==1)
    begin gate<=1;counter<=0;end
  else if(counter==0)
    begin gate<=0;counter<=1;end
end

assign latch=~gate;
assign clr_count=(~clk)&(~gate);

endmodule

