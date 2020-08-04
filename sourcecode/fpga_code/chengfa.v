`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/08/03 23:24:07
// Design Name: 
// Module Name: chengfa
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


module chengfa(clk,A,B,S);
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
reg [47:0]temp;//乘法缓存区
always@(posedge clk)
    begin
	signA=A[31];
	signB=B[31];
	expA=A[30:23];
	expB=B[30:23];
	manA={1'b1,A[22:0]};
	manB={1'b1,B[22:0]};
	signS=signA^signB;
	expS=expA+expB-127;
	temp=manA*manB;
	if(temp[47])begin
		expS=expS+1;
		temp=temp>>1;end
	S={signS,expS[7:0],temp[45:23]};
end
endmodule
