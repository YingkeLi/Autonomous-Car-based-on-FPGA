module surrounding_driver(CLK1,CLK2,EN,minsg,SG90);
input EN;                //使能信号
input [3:0] minsg;
output reg SG90;   //电机PWM
input CLK1;                  //时钟20ms
input CLK2;                  //时钟10us

reg [24:0] pwm;
reg [24:0] count;

initial 
begin 
    count<=0;
	 pwm<=0;
end

always @(posedge CLK1)
begin
	  case(minsg)
		  0:begin pwm<=0; end
		  1:begin pwm<=40;  end
		  2:begin pwm<=60; end
		  3:begin pwm<=80; end
		  4:begin pwm<=100;end
		  5:begin pwm<=120; end
		  default: pwm<=0; 
	  endcase
end

always @(posedge CLK2)
begin
     if(count==1000)
	  begin
	       count<=0;
	  end
	  else if(count<pwm) 
	       begin 
			     SG90<=1;
				  count<=count+1;
			 end
	  else
	       begin
			     SG90<=0;
				  count<=count+1;
			 end
end

endmodule

				
	  
				  
	     

