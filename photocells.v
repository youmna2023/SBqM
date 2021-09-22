module photocells(in1,in2,mode1,mode2,clk,rst);
output reg mode1,mode2;
input in1,in2,clk,rst;
 photocell count_up(mode1,in1,clk,rst);
 photocell count_down(mode2,in2,clk,rst);
endmodule