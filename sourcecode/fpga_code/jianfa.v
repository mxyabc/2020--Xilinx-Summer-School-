`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/08/03 23:23:56
// Design Name: 
// Module Name: jianfa
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module jianfa(clk,A,B,S);//输入时钟，数
input clk;
input [31:0]A;
input [31:0]B;
output [31:0]S;

reg [31:0]S;
reg signA;//符号位
reg signB;
reg signS;
reg [7:0]expA;//指数位
reg [7:0]expB;
reg [7:0]expS;
reg [23:0]manA;//尾数位
reg [23:0]manB;
reg [24:0]manS;
reg [7:0]count=0;
always@(posedge clk)
begin
	signA=A[31];
	signB=B[31];
	expA=A[30:23];
	expB=B[30:23];
	manA={1'b1,A[22:0]};
	manB={1'b1,B[22:0]};
		
	if(expA==expB)begin//对阶
		count=8'b0;
		expS=expA;end
	else if(expA>expB)
		begin
			count=expA-expB;
			manB[23:0]=manB[23:0]>>count;
			expS=expA;
		end
	else
		begin
			count=expB-expA;
			manA=manA>>count;
			expS=expB;
		end
	
	if(signA^signB)//尾数相减
	begin
			manS=manA+manB;
			signS=signA;
	end
	else begin
		if(manA>=manB)begin
			manS=manA-manB;
			signS=signA;end
		else begin
			manS=manB-manA;
			signS=~signA;end
		end
		
		
		if(manS[24])begin//判断溢出
			expS=expS+1;
			S={signS,expS[7:0],manS[23:1]};end		
		else begin
	if(manS[23])begin//尾数规格化
			S={signS,expS[7:0],manS[22:0]};end
	else if(manS[22])begin
			expS=expS-1;
			manS=manS<<1;
			S={signS,expS[7:0],manS[22:0]};end
	else if(manS[21])begin
			expS=expS-2;
			manS=manS<<2;
			S={signS,expS[7:0],manS[22:0]};end
	else if(manS[20])begin
			expS=expS-3;
			manS=manS<<3;
			S={signS,expS[7:0],manS[22:0]};end
	else if(manS[19])begin
			expS=expS-4;
			manS=manS<<4;
			S={signS,expS[7:0],manS[22:0]};end
	else if(manS[18])begin
			expS=expS-5;
			manS=manS<<5;
			S={signS,expS[7:0],manS[22:0]};end
	else if(manS[17])begin
			expS=expS-6;
			manS=manS<<6;
			S={signS,expS[7:0],manS[22:0]};end
	else if(manS[16])begin
			expS=expS-7;
			manS=manS<<7;
			S={signS,expS[7:0],manS[22:0]};end
	else if(manS[15])begin
			expS=expS-8;
			manS=manS<<8;
			S={signS,expS[7:0],manS[22:0]};end
	else if(manS[14])begin
			expS=expS-9;
			manS=manS<<9;
			S={signS,expS[7:0],manS[22:0]};end
	else if(manS[13])begin
			expS=expS-10;
			manS=manS<<10;
			S={signS,expS[7:0],manS[22:0]};end
	else if(manS[12])begin
			expS=expS-11;
			manS=manS<<11;
			S={signS,expS[7:0],manS[22:0]};end
	else if(manS[11])begin
			expS=expS-12;
			manS=manS<<12;
			S={signS,expS[7:0],manS[22:0]};end
	else if(manS[10])begin
			expS=expS-13;
			manS=manS<<13;
			S={signS,expS[7:0],manS[22:0]};end
	else if(manS[9])begin
			expS=expS-14;
			manS=manS<<14;
			S={signS,expS[7:0],manS[22:0]};end
	else if(manS[8])begin
			expS=expS-15;
			manS=manS<<15;
			S={signS,expS[7:0],manS[22:0]};end
	else if(manS[7])begin
			expS=expS-16;
			manS=manS<<16;
			S={signS,expS[7:0],manS[22:0]};end
	else if(manS[6])begin
			expS=expS-17;
			manS=manS<<17;
			S={signS,expS[7:0],manS[22:0]};end
	else if(manS[5])begin
			expS=expS-18;
			manS=manS<<18;
			S={signS,expS[7:0],manS[22:0]};end
	else if(manS[4])begin
			expS=expS-19;
			manS=manS<<19;
			S={signS,expS[7:0],manS[22:0]};end
	else if(manS[3])begin
			expS=expS-20;
			manS=manS<<20;
			S={signS,expS[7:0],manS[22:0]};end
	else if(manS[2])begin
			expS=expS-21;
			manS=manS<<21;
			S={signS,expS[7:0],manS[22:0]};end
	else if(manS[1])begin
			expS=expS-22;
			manS=manS<<22;
			S={signS,expS[7:0],manS[22:0]};end
	else begin
			expS=expS-23;
			manS=manS<<23;
			S={signS,expS[7:0],manS[22:0]};end
	end		
end
endmodule



