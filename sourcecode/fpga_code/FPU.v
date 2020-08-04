`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/08/03 22:12:50
// Design Name: 
// Module Name: FPU
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


module	FPU(a,b,c,clk,ctl);
input   clk;
input	[31:0]	a;
input	[31:0]	b;
input	[1:0]	ctl;
output	reg  [31:0]	c;
reg [31:0]  a_jia=0;
reg [31:0]  b_jia=0;
wire   [31:0]   c_jia;
reg [31:0]  a_jian=0;
reg [31:0]  b_jian=0;
wire    [31:0]  c_jian;
reg [31:0]  a_cheng=0;
reg [31:0]  b_cheng=0;
wire    [31:0]  c_cheng;
reg [31:0]  a_chu=0;
reg [31:0]  b_chu=0;
wire    [31:0]  c_chu;
always@(posedge	clk)
begin
	case(ctl)
		2'h0:
		  begin
			a_jia<=a;
			b_jia<=b;
			c<=c_jia;
		  end
		2'h1:
		  begin
			a_jian<=a;
			b_jian<=b;
			c<=c_jian;
		  end	
		 2'h2:
		  begin
			a_cheng<=a;
			b_cheng<=b;
			c<=c_cheng;
		  end
		2'h3:
		  begin
			a_chu<=a;
			b_chu<=b;
			c<=c_chu;
		  end	
		default:
		  begin
			a_jia<=a;
			b_jia<=b;
			c<=c_jia;
		  end
	endcase
end
	jiafa  i_jiafa(
	   .clk(clk),
	   .a(a_jia),
	   .b(b_jia),
	   .c(c_jia));
	jianfa  i_jianfa(
	   .clk(clk),
	   .A(a_jian),
	   .B(b_jian),
	   .S(c_jian));
	 chengfa  i_chengfa(
	   .clk(clk),
	   .A(a_cheng),
	   .B(b_cheng),
	   .S(c_cheng));
	chufa  i_chufa(
	   .clk(clk),
	   .A(a_chu),
	   .B(b_chu),
	   .S(c_chu));
endmodule
