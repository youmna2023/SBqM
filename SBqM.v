//******FSM MODULE******
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
//******COUNTER MODULE******
module up_down_counter (count_up,count_down,clock,reset,p_count,full_flag,empty_flag);
input count_up,count_down,clock,reset;
output reg [2:0] p_count;
output reg full_flag,empty_flag;
parameter n=3;
always @(posedge(clock) or posedge(reset))
begin  
  if (reset== 1)
    p_count<=0;
  else
    begin
      if (p_count== 2**n-1)
        begin
          full_flag<=1; 
        end
      else
        begin
          full_flag<=0;
          if(count_up==1 &count_down==0)
            p_count<=p_count+1;
        end   
      if (p_count== 3'b 000)
        empty_flag<=1;
      else
        begin
          empty_flag<=0;
          if(count_down==1&count_up==0)
            p_count<=p_count-1;
        end      
  if ((count_down==1)&& (p_count==0 )&& (count_up==0))$display(" The queue is empty and somebody tries to leave");  
  if((count_up==1)&&(p_count==2**n-1 )&&(count_down==0))$display(" The queue is full and somebody tries to enter");
		
 end
end  
endmodule
//******ROM MODULE******
module ROM(Tcount,Pcount,data);
input [1:0] Tcount;
input [2:0] Pcount;
wire [4 : 0] adder;
output wire [7:0] data; 
reg [7:0] ram [31:0];
assign adder = {Tcount, Pcount};
assign data= ram [adder];
initial
begin
$readmemh("waiting_time.txt" ,ram );
end
endmodule
//******SYSTEM MODULE******
module SBqM(entering_cell,leaving_cell,reset,clock,T_COUNT,P_COUNT,WAITING_TIME,FULL_FLAG,EMPTY_FLAG);
  input entering_cell,leaving_cell,reset,clock;
  input [1:0] T_COUNT;
  output [2:0] P_COUNT;
  output FULL_FLAG,EMPTY_FLAG;
  output [7:0] WAITING_TIME;
  wire MODE1,MODE2;
  photocell count_up(MODE1,entering_cell,clock,reset);
  photocell count_down(MODE2,leaving_cell,clock,reset);
  up_down_counter stage2 (MODE1,MODE2,clock,reset,P_COUNT,FULL_FLAG,EMPTY_FLAG);
  ROM stage3 (T_COUNT,P_COUNT,WAITING_TIME);  
endmodule

module tb();
reg entering_cell,leaving_cell,reset,clock;
reg [1:0] T_COUNT;
wire [2:0] P_COUNT;
wire FULL_FLAG,EMPTY_FLAG;
wire [7:0] WAITING_TIME;
wire MODE1,MODE2;
integer i;
SBqM p1(entering_cell,leaving_cell,reset,clock,T_COUNT,P_COUNT,WAITING_TIME,FULL_FLAG,EMPTY_FLAG);

always
begin
#5
clock=~clock;
end

initial 
begin 
$monitor("%b %b %b %b %b %b %b %b %b",clock,reset,entering_cell,leaving_cell,T_COUNT,P_COUNT,WAITING_TIME,FULL_FLAG,EMPTY_FLAG);
clock=0;
entering_cell=1;
leaving_cell=1;
reset=1;
T_COUNT=2'b01;
#10
reset=0;
for (i=8;i>0;i=i-1)
begin
  #10
  entering_cell=~entering_cell;
end
entering_cell=1;
for (i=8;i>0;i=i-1)
begin
  #10
  leaving_cell=~leaving_cell;
end
#10
T_COUNT=2'b10;
for (i=8;i>0;i=i-1)
begin
  #10
  entering_cell=~entering_cell;
end
#10
T_COUNT=2'b11;
entering_cell=1;
leaving_cell=1;
for (i=8;i>0;i=i-1)
begin
  #10
  leaving_cell=~leaving_cell;
end
if ((MODE2==1)&& (P_COUNT==0 )&& (MODE1==0))$display(" The queue is empty and somebody tries to leave");  
if((MODE1==1)&&(P_COUNT==3'b111 )&&(MODE2==0))$display(" The queue is full and somebody tries to enter");
end
endmodule 