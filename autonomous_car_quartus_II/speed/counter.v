module counter(reset,gate,clr_count,clk_test,cnt0,cnt1,cnt2);
input reset,gate,clr_count,clk_test;
output reg[3:0]cnt0,cnt1,cnt2;
reg [10:0] result;

initial 
begin
cnt0<=0;cnt1<=0;cnt2<=0;
result<=0;
end

always@(posedge clk_test)
begin
  if(!reset) result<=0;
  else 
  begin
    if(clr_count) result<=0;
	 else 
	 begin
	   if(gate==1) result<=result+1;
	 end
  end
end

always@(result)
begin
cnt2<=result/100;
cnt1<=(result-100*cnt2)/10;
cnt0<=result%10;
end

endmodule
