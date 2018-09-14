module bluetooth(
input clk,
input rxd,                        //信号输入端
output reg [1:0] driver          
);

reg [1:0] state;                  //接收状态，0未接收，1接收，2接收完
reg [12:0] count;
reg clk9600;
reg flag;                         //用来标志是否接收了一次完整的数据
reg [7:0]data;                    //负责接收串口数据
reg [3:0] datacount;
parameter bot=2603;

initial 
begin
datacount<=0;
driver<=2'b00;
count<=0;
clk9600<=0;
state<=2'b00;
flag<=0;
end
	
always @(posedge clk)            //分频器，保证波特率为9600
begin
	count<= count+1;
	if (count==bot) 
	begin
		clk9600<=~clk9600;
		count<=0;
	end
end

always @(posedge clk9600)
begin
	case(state)
	2'b00:
	begin
	if(rxd==0)
		begin
		datacount<=0;
		state<=2'b01;
		end
	end
	2'b01:
	begin
	datacount<=datacount+1;					
	if(datacount<8)					//发送8位数据位(count小于等于8)
		begin
		data[datacount]<=rxd;		//一位一位串行传输
		end
	else	
		begin
		flag<=1;
		state<=2'b10;					//变为为发送完成状态(state=2)
		end
	end
	2'b10:
	begin
	state<=2'b00;
	flag<=0;
	end
	default:
	begin
	state<=2'b00;
	flag<=0;
	datacount<=0;
	end
	endcase
	
end

always @(posedge clk)            //扫描速度快，这样可以使得数据转换比较方便
begin
if(flag==1)
	begin
	case(data)
	8'b00000000:                  //停车
	begin
	driver<=2'b00;
	end
	8'b00000001:                  //前进
	begin
	driver<=2'b01;
	end
	8'b00000010:                  //左转
	begin
	driver<=2'b10;
	end
	8'b00000011:                  //右转
	begin
	driver<=2'b11;
	end
	default:
	begin
	driver<=2'b00;
	end
	endcase
end

end


endmodule	