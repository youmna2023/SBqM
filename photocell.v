module photocell(out,in,clk,rst);
output reg out;
input in,clk,rst;
reg state;
always@(posedge clk,posedge rst)
begin
if(rst) begin
state<=1'b1;
out<=0;
end
else begin
case(state)
1'b0 : begin
if(in) begin
state<=1'b1;
out<=1;
end
else begin
state<=1'b0;
out<=0; 
end
end
1'b1 : begin
if(in) begin
state<=1'b1;
out<=0;
end 
else begin
state<=1'b0;
out<=1; 
end
end
default: begin
state<= 1'b1;
out<=0;
end
endcase
end
end
endmodule 
