module distance(CLK,EN,TRIG,ECHO,ULTRASOUND,DRIVER);
input CLK;               //时钟10us
input EN;                //使能信号
output reg TRIG;         //触发信号
input ECHO;              //回响信号
output reg ULTRASOUND;   //超声波信号
output reg [1:0] DRIVER; //驱动信号

reg [24:0] count1;
reg [24:0] count2;

initial 
begin 
    count1<=0;
	 count2<=0;
	 ULTRASOUND<=0;
	 DRIVER<=1;
end

always @(posedge CLK)
begin
    if(EN==1)
	 begin 
	     TRIG<=0;
	 end
	 else if(EN==0)
	 begin
	     if(count1==0|count1==1)  
		  begin
		        TRIG<=1;
				  count1<=count1+1;
		  end
		  else if(count1==10000)        //周期100ms
		  begin 
		        TRIG<=0;
		        count1<=0;
		  end
		  else 
		  begin 
		        TRIG<=0;
				  count1<=count1+1;
		  end
	  end
end

always @(posedge CLK)
begin
    if(ECHO==1)
	 begin 
	     count2<=count2+1;
	 end
	 else
	 begin
	     if(count2!=0)
		  begin
		      if(count2<70) begin ULTRASOUND<=1; DRIVER<=3; end 
				else begin ULTRASOUND<=0; DRIVER<=1; end
				count2<=0;
		  end
	  end
end

endmodule

				
	  
				  
	     

