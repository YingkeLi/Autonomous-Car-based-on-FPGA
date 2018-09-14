module driver(CLK1,CLK2,MODE,DRIVER1,DRIVER2,DRIVER3,MOTOR,STEER);
input CLK1;                  //时钟20ms
input CLK2;                  //时钟10us
input [1:0]MODE;             //模式
input [1:0]DRIVER1;          //超声波驱动信号
input [1:0]DRIVER2;          //红外线驱动信号
input [1:0]DRIVER3;          //蓝牙驱动信号
output reg MOTOR;            //电机驱动输出
output reg STEER;            //舵机驱动输出

reg [24:0] pwm1,pwm2;
reg [24:0] count1,count2;

initial 
begin 
    count1<=0;
	 count2<=0;
end

always @(posedge CLK1)
begin
    if(MODE==2'b00)      
	 begin 
	     case(DRIVER1)
		  2'b00:begin pwm1<=0; pwm2<=91; end
		  2'b01:begin pwm1<=300; pwm2<=91; end
		  2'b10:begin pwm1<=300; pwm2<=116; end
		  2'b11:begin pwm1<=300; pwm2<=70; end
		  endcase
	 end
	 else if(MODE==2'b01)
	 begin
	      case(DRIVER2)
		  2'b00:begin pwm1<=0; pwm2<=91; end
		  2'b01:begin pwm1<=270; pwm2<=91; end
		  2'b10:begin pwm1<=270; pwm2<=110; end
		  2'b11:begin pwm1<=270; pwm2<=75; end
		  endcase
	 end
	 else if(MODE==2'b10)
	 begin
	      case(DRIVER3)
		  2'b00:begin pwm1<=0; pwm2<=91; end
		  2'b01:begin pwm1<=350; pwm2<=91; end
		  2'b10:begin pwm1<=350; pwm2<=116; end
		  2'b11:begin pwm1<=350; pwm2<=70; end
		  endcase
	 end
	 else
	 begin
	 pwm1<=0; pwm2<=91;
	 end
end

always @(posedge CLK2)
begin
     if(count1==1000) count1<=0;
	  else if(count1<pwm1) 
	       begin 
			     MOTOR<=1;
				  count1<=count1+1;
			 end
	  else
	       begin
			     MOTOR<=0;
				  count1<=count1+1;
			 end
	  if(count2==1000) count2<=0;
	  else if(count2<pwm2) 
	       begin 
			     STEER<=1;
				  count2<=count2+1;
			 end
	  else
	       begin
			     STEER<=0;
				  count2<=count2+1;
			 end
end

endmodule

    