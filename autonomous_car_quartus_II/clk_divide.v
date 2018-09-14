module clk_divide(CLK,CLK1,CLK2);
input CLK;              //系统时钟0.02us
output reg CLK1;        //时钟10us
output reg CLK2;        //时钟20ms

reg [24:0] count1;
reg [24:0] count2;

initial 
begin
    count1<=0;
	 count2<=0;
end

always@(posedge CLK)
begin
    if(count1==500)
    begin 
        count1=0;
        CLK1=~CLK1;
    end
    else 
    begin
        count1=count1+1;
    end
end

always@(posedge CLK1)
begin
    if(count2==2000)
    begin 
        count2=0;
        CLK2=~CLK2;
    end
    else 
    begin
        count2=count2+1;
    end
end

endmodule
