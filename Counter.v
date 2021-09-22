module counter (mode1,mode2,clk,reset,p_count,full_flag,empty_flag);
  input mode1,mode2,clk,reset;
  output reg [2:0] p_count;
  output reg full_flag,empty_flag;
  parameter n=3;
  always @(posedge(clk) or posedge(reset))
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
            if(mode1==1 &mode2==0)
               p_count<=p_count+1;
          end   
        if (p_count== 3'b 000)
          empty_flag<=1;
        else
          begin
            empty_flag<=0;
            if(mode1==1&mode2==0)
               p_count<=p_count-1;
          end        
		 
     if ((mode2==1)&& (p_count==0 )&& (mode1==0))    $display(" The queue is empty and somebody tries to leave");  
     if((mode1==1)&&(p_count==2**n-1 )&&(mode2==0))  $display(" The queue is full and somebody tries to enter");	
	end     
 end  
endmodule
