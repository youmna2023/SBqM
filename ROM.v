module ROM(Tcount,Pcount,WAITING_TIME);
input [1:0] Tcount;
input [2:0] Pcount;
wire [4 : 0] adder;
output wire [7:0] WAITING_TIME; 
reg [7:0] ram [31:0];
assign adder = {Tcount, Pcount};
assign WAITING_TIME= ram [adder];
initial
begin
$readmemh("waiting_time.txt" ,ram );
end
endmodule

module RoM_Tb;
reg [1:0] Tcount;
reg [2:0] Pcount;
reg [4:0] adder;
reg [7:0] ram [31:0];
wire [7:0] WAITING_TIME;

ROM s(.Tcount(Tcount), .Pcount(Pcount),.WAITING_TIME(WAITING_TIME));
initial 
begin 
$readmemh("waiting_time.txt" ,ram );
$monitor("waiting time is %h , Pcount is %b",data , Pcount);
#1
Tcount=2'b00; //if user out Teller=00
Pcount=3'b000;
#1
Tcount=2'b00;
Pcount=3'b001;
#1
Tcount=2'b00;
Pcount=3'b010;
#1
Tcount=2'b00;
Pcount=3'b011;
#1
Tcount=2'b00;
Pcount=3'b100;
#1
Tcount=2'b00;
Pcount=3'b101;
#1
Tcount=2'b00;
Pcount=3'b110;
#1
Tcount=2'b00;
Pcount=3'b111;

#1
Tcount=2'b01;
Pcount=3'b000;
#1
Tcount=2'b01;
Pcount=3'b001;
#1
Tcount=2'b01;
Pcount=3'b010;
#1
Tcount=2'b01;
Pcount=3'b011;
#1
Tcount=2'b01;
Pcount=3'b100;
#1
Tcount=2'b01;
Pcount=3'b101;
#1
Tcount=2'b01;
Pcount=3'b110;
#1
Tcount=2'b01;
Pcount=3'b111;
#1
Tcount=2'b10;
Pcount=3'b000;
#1
Tcount=2'b10;
Pcount=3'b001;
#1
Tcount=2'b10;
Pcount=3'b010;
#1
Tcount=2'b10;
Pcount=3'b011;
#1
Tcount=2'b10;
Pcount=3'b100;
#1
Tcount=2'b10;
Pcount=3'b101;
#1
Tcount=2'b10;
Pcount=3'b110;
#1
Tcount=2'b10;
Pcount=3'b111;
#1
Tcount=2'b11;
Pcount=3'b000;
#1
Tcount=2'b11;
Pcount=3'b001;
#1
Tcount=2'b11;
Pcount=3'b010;
#1
Tcount=2'b11;
Pcount=3'b011;
#1
Tcount=2'b11;
Pcount=3'b100;
#1
Tcount=2'b11;
Pcount=3'b101;
#1
Tcount=2'b11;
Pcount=3'b110;
#1
Tcount=2'b11;
Pcount=3'b111;
end
endmodule 