`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/08/03 23:24:19
// Design Name: 
// Module Name: chufa
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


module chufa(clk,A,B,S);
input clk;
input [31:0]A;
input [31:0]B;
output [31:0]S;

reg [31:0]S;
reg signA;//定义符号位
reg signB;
reg signS;
reg [7:0]expA;//定义指数位
reg [7:0]expB;
reg [7:0]expS;
reg [23:0]manA;//定义尾数位
reg [23:0]manB;
reg [24:0]manS;
reg [7:0]count=0;//阶数差
reg [24:0]DmanA;//将尾数增加1位，是为了方便类似0.5/2.5（小数/大数）运算
reg [24:0]DmanB;//同上
reg [23:0]yshang=0;//除法得出的商
reg [24:0]yyushu;//除法得出的余数
integer i;
always@(posedge clk)
begin
	if(A==0)
		S=32'b0;
	else begin
	signA=A[31];
	signB=B[31];
	expA=A[30:23];
	expB=B[30:23];
	DmanA={2'b01,A[22:0]};
	DmanB={2'b01,B[22:0]};
	yshang=0;	
	expS=expA-expB+8'b01111111;
	signS=signA^signB;
	yyushu=DmanA;
	for(i = 0;i < 24;i = i + 1)
        begin
          if(yyushu>=DmanB)begin
				yshang[23:0]=yshang[23:0]<<1;
				yshang[23:0]=yshang[23:0]+24'h000001;
				yyushu=yyushu-DmanB;end
			else begin
				yshang[23:0]=yshang[23:0]<<1;
				end
			yyushu=yyushu<<1;
        end
	if(yshang[23])begin
		S={signS,expS[7:0],yshang[22:0]};
		end
	else if(yshang[22]) begin
		yshang=yshang<<1;
		expS=expS-1;
		S={signS,expS[7:0],yshang[22:0]};end
	else if(yshang[21]) begin
		yshang=yshang<<2;
		expS=expS-2;
		S={signS,expS[7:0],yshang[22:0]};end	
	else if(yshang[20]) begin
		yshang=yshang<<3;
		expS=expS-3;
		S={signS,expS[7:0],yshang[22:0]};end
	else if(yshang[19]) begin
		yshang=yshang<<4;
		expS=expS-4;
		S={signS,expS[7:0],yshang[22:0]};end	
	else if(yshang[18]) begin
		yshang=yshang<<5;
		expS=expS-5;
		S={signS,expS[7:0],yshang[22:0]};end
	else if(yshang[17]) begin
		yshang=yshang<<6;
		expS=expS-6;
		S={signS,expS[7:0],yshang[22:0]};end	
	else if(yshang[16]) begin
		yshang=yshang<<7;
		expS=expS-7;
		S={signS,expS[7:0],yshang[22:0]};end
	else if(yshang[15]) begin
		yshang=yshang<<8;
		expS=expS-8;
		S={signS,expS[7:0],yshang[22:0]};end	
	else if(yshang[14]) begin
		yshang=yshang<<9;
		expS=expS-9;
		S={signS,expS[7:0],yshang[22:0]};end
	else if(yshang[13]) begin
		yshang=yshang<<10;
		expS=expS-10;
		S={signS,expS[7:0],yshang[22:0]};end	
	else if(yshang[12]) begin
		yshang=yshang<<11;
		expS=expS-11;
		S={signS,expS[7:0],yshang[22:0]};end
	else if(yshang[11]) begin
		yshang=yshang<<12;
		expS=expS-12;
		S={signS,expS[7:0],yshang[22:0]};end	
	else if(yshang[10]) begin
		yshang=yshang<<13;
		expS=expS-13;
		S={signS,expS[7:0],yshang[22:0]};end
	else if(yshang[9]) begin
		yshang=yshang<<14;
		expS=expS-14;
		S={signS,expS[7:0],yshang[22:0]};end	
	else if(yshang[8]) begin
		yshang=yshang<<15;
		expS=expS-15;
		S={signS,expS[7:0],yshang[22:0]};end
	else if(yshang[7]) begin
		yshang=yshang<<16;
		expS=expS-16;
		S={signS,expS[7:0],yshang[22:0]};end	
	else if(yshang[6]) begin
		yshang=yshang<<17;
		expS=expS-17;
		S={signS,expS[7:0],yshang[22:0]};end
	else if(yshang[5]) begin
		yshang=yshang<<18;
		expS=expS-18;
		S={signS,expS[7:0],yshang[22:0]};end	
	else if(yshang[4]) begin
		yshang=yshang<<19;
		expS=expS-19;
		S={signS,expS[7:0],yshang[22:0]};end
	else if(yshang[3]) begin
		yshang=yshang<<20;
		expS=expS-20;
		S={signS,expS[7:0],yshang[22:0]};end	
	else if(yshang[2]) begin
		yshang=yshang<<21;
		expS=expS-21;
		S={signS,expS[7:0],yshang[22:0]};end
	else if(yshang[1]) begin
		yshang=yshang<<22;
		expS=expS-21;
		S={signS,expS[7:0],yshang[22:0]};end	
	else begin
		yshang=yshang<<23;
		expS=expS-23;
		S={signS,expS[7:0],yshang[22:0]};end	
  	end
end
endmodule

