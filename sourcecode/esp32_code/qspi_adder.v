`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/08/03 22:11:08
// Design Name: 
// Module Name: qspi_adder
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


module qspi_adder#(
parameter addr_width = 8
)(
input clk,
input rst_n,
//RAM 
output reg [addr_width-1:0] addr,
input [7:0]data_in,
output reg [7:0] data_out,
output reg wen
);


//registers & wire
reg [9:0] count; 
wire [7:0] rcount;//0x00 ~ 0x0f : get the data ; 0x10 ~ 0x1f : output the data to RAM

//FPU
reg [31:0] a;//输入计算数
reg [31:0] b;
reg [1:0] ctl;//运算符号
wire [31:0] c;


assign rcount = count[9:2];
//count: 时钟周期计数器, count[1:0] == 2'b00时, 地址改变；count[1:0] == 2'b11时，进行数据存储
always @(posedge clk,negedge rst_n)
begin
    if (!rst_n)
        count <= 0;
    else
        if (rcount < 32)
            count <= count + 1;
        else
            count <= 0;
end
//addr: RAM地址端
always @(posedge clk,negedge rst_n)
begin
    if (!rst_n)
        addr <= 0;
    else
        if (rcount < 32)
            addr <= rcount;
        else
            addr <= 0;
end
//mem:  8位数据寄存器组，储存0x00 ~ 0x0F 的数据同时进行FPU操作
reg [7:0] mem [0:15];
integer i;
always @(posedge clk,negedge rst_n)
begin
    if (!rst_n)
    begin
        for (i=0;i<15;i=i+1)
            mem[i] <= 0;
    end
    else
        if ((rcount < 16)&&(count[1:0] == 2'b11))
          begin 
               mem[rcount]<=data_in;
               if(rcount==11)
               begin
               ctl<=mem[8];//选择计算功能
               a<={mem[0],mem[1],mem[2],mem[3]};//输入数据
               b<={mem[4],mem[5],mem[6],mem[7]};
               end
          end
        else if ((rcount==18)&&(count[1:0] == 2'b11))
        begin mem[10]<=c[31:24];//输出结果
              mem[11]<=c[23:16];
              mem[12]<=c[15:8];
              mem[13]<=c[7:0];
        end             
end
//data_out: 从mem中进行数据输出
always @(posedge clk,negedge rst_n)
begin
    if (!rst_n)
        data_out <= 0;
    else
        if (rcount < 32)
            data_out <= mem[rcount-16];
        else
            data_out <= 0;
end
//wen: RAM写使能
always @(posedge clk,negedge rst_n)
begin
    if (!rst_n)
    begin
        wen <= 0;
    end
    else
        if ((rcount >= 16)&&(rcount < 32))
            wen <= 1;
        else
            wen <= 0;
end
//调用fpu计算
FPU fpu1(
   .a(a),
   .b(b),
   .c(c),
   .clk(clk),
   .ctl(ctl)
   );
endmodule
