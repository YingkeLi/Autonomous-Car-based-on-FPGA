module webdu(clk,DIG,SEG,Data,reset);
input clk,reset;
inout Data;
output[7:0] SEG,DIG;
wire[39:0] data;
DVF dvf(clk,clkout);
temp Temp(clkout,reset,Data,data);
DHT_SEG8 T_Show(data,DIG,SEG,clkout,reset);




endmodule
