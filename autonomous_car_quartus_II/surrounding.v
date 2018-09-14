module surrounding(CLK,EN,TRIG1,TRIG2,TRIG3,TRIG4,TRIG5,ECHO1,ECHO2,ECHO3,ECHO4,ECHO5,min,distance);
input CLK;               //时钟10us
input EN;                //使能信号
output reg [3:0] distance;
output reg TRIG1,TRIG2,TRIG3,TRIG4,TRIG5;         //触发信号
input ECHO1,ECHO2,ECHO3,ECHO4,ECHO5;              //回响信号
output reg [3:0] min;   //电机

reg [24:0] count;
reg [24:0] count0,count1,count2,count3,count4,count5;
reg [24:0] countsg;

initial 
begin 
    count<=0;
	 count0<=0;
	 count1<=0;
	 count2<=0;
	 count3<=0;
	 count4<=0;
	 count5<=0;
	 min<=0;
end

always @(posedge CLK)
begin
    if(EN==1)
	 begin 
	     TRIG1<=0;
		  TRIG2<=0;
		  TRIG3<=0;
		  TRIG4<=0;
		  TRIG5<=0;
	 end
	 else if(EN==0)
	 begin
	     if(count==0|count==1)  
		  begin
		        TRIG1<=1;
		        TRIG2<=1;
		        TRIG3<=1;
		        TRIG4<=1;
		        TRIG5<=1;
				  count<=count+1;
		  end
		  else if(count==5000)        //周期100ms
		  begin 
		        TRIG1<=0;
		        TRIG2<=0;
		        TRIG3<=0;
		        TRIG4<=0;
		        TRIG5<=0;
		        count<=0;
		  end
		  else 
		  begin 
		        TRIG1<=0;
		        TRIG2<=0;
		        TRIG3<=0;
		        TRIG4<=0;
		        TRIG5<=0;
				  count<=count+1;
		  end
	  end
end

always @(posedge CLK)
begin
    if(count0==5000)
	 begin
	     count0<=0;
	     count1<=0;
		  count2<=0;
		  count3<=0;
		  count4<=0;
		  count5<=0;
		  min<=0;
    end	  
	 else
	 begin
		   count0<=count0+1;
	      if(ECHO1==1)
			begin 
				count1<=count1+1;
			end
			if(ECHO2==1)
			begin 
			count2<=count2+1;
			end
			if(ECHO3==1)
			begin 
			count3<=count3+1;
			end
			if(ECHO4==1)
			begin 
			count4<=count4+1;
			end
			if(ECHO5==1)
			begin 
				count5<=count5+1;
			end
	 end
	 if(ECHO1+ECHO2+ECHO3+ECHO4+ECHO5==4)
	 begin
	     if(count1>58&&count2>58&&count3>58&&count4>58&&count5>58) //超过最远发现距离
		  begin
		      min<=0;
				distance<=0;
        end
        else if(ECHO1==0)
        begin
            min<=1;
				distance<=count1*10/58;
        end
        else if(ECHO2==0)
        begin
            min<=2;
				distance<=count2*10/58;
        end
        else if(ECHO3==0)
        begin
            min<=3;
            distance<=count3*10/58;
		  end 
        else if(ECHO4==0)
        begin
            min<=4;
				distance<=count4*10/58;
        end
        else if(ECHO5==0)
        begin
            min<=5;
				distance<=count5*10/58;
        end			  
	 end
end

endmodule

				
	  
				  
	     

