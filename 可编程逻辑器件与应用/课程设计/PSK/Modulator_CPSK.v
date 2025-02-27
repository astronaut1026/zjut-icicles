//通信工程1803 凌智城201806061211
module Modulator_CPSK(clk,start,x,y);
	input clk;		//系统时钟信号
	input start;	//开始调制信号
	input x;		//基带信号
	output y;		//已调制信号
	
	reg y;
	reg[1:0] q;		//计数器
	reg f1,f2;		//载波信号
	always@(posedge clk)//分频和计数
		begin
			if(!start)
				begin q<=0;f1<=0;f2<=0;end
			else if(q<=1)
				begin	
					f1<=1;
					f2<=0;
					q<=q+1'b1;
				end
			else if(q==3)
				begin
					f1<=0;
					f2<=1;
					q<=0;
				end
			else
				begin
					f1<=0;
					f2<=1;
					q<=q+1'b1;
				end
		end
		
	always@(posedge clk)//对基带信号的调制
		if(q[0])
			begin
				if(x)
					y<=f1;
				else
					y<=f2;
			end
			
endmodule