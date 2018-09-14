module light(CLK1,CLK2,EN,LIGHT,LED);
input CLK1;            //时钟20ms
input CLK2;            //时钟10us
input EN;              //使能信号
input [7:0] LIGHT;     //光照信号
output reg LED;        //LED信号

reg [24:0] pwm;
reg [24:0] count;

always @(posedge CLK1)
begin 
    if(LIGHT<=120) pwm<=1600;
	 else if(LIGHT<170&LIGHT>120) pwm<=800;
	 else pwm<=200;
end

always @(posedge CLK2)
begin
     if(count==2000) count<=0;
	  else if(count<pwm) 
	       begin 
			     LED<=1;
				  count<=count+1;
			 end
	  else
	       begin
			     LED<=0;
				  count<=count+1;
			 end
end

endmodule

