module decode(cnt0,cnt1,cnt2,clk,latch,dig,seg);
input[3:0]cnt0,cnt1,cnt2;
input clk,latch;
output reg[3:0]dig;
output reg[6:0]seg;
reg[3:0]data1,data2,data3;
reg[3:0]data;
reg[1:0] q;

initial
begin
dig<=0;seg<=1;
data1<=0;data2<=0;data3<=0;
data<=0;q<=0;
end

always@(posedge latch)
begin
data1<=cnt0;data2<=cnt1;data3<=cnt2;
end

always @(posedge clk)
begin
	q<=q+1;
	case(q)
	2'd0 : begin dig<=4'b1011; data<=data1; end
	2'd1 : begin dig<=4'b1101; data<=data2; end
	2'd2 : begin dig<=4'b1110; data<=data3; end
	2'd3 : begin dig<=4'b1111; data<=0; end
	endcase
end

always @(data)
begin 
	case(data)
   4'd0 : seg=7'b1111110;
   4'd1 : seg=7'b0110000;
   4'd2 : seg=7'b1101101;
   4'd3 : seg=7'b1111001;
   4'd4 : seg=7'b0110011;
   4'd5 : seg=7'b1011011;
   4'd6 : seg=7'b1011111;
   4'd7 : seg=7'b1110000;
   4'd8 : seg=7'b1111111;
   4'd9 : seg=7'b1111011;
   default : seg=7'b1111110;
   endcase
end

endmodule
