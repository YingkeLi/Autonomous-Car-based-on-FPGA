module scan(clk,clk1,clk2);
input clk;
output clk1,clk2;
reg clk1,clk2;
reg[24:0] counter1,counter2;

initial
begin
clk1<=0;clk2<=0;
counter1<=0;counter2<=0;
end

always@(posedge clk)
begin
if(counter1==100000)
  begin 
  counter1=0;
  clk1=~clk1;
  end
else 
  begin
  counter1=counter1+1;
  end
end

always@(posedge clk)
begin
if(counter2==5000000)
  begin 
  counter2=0;
  clk2=~clk2;
  end
else
  begin
  counter2=counter2+1;
  end
end

endmodule
