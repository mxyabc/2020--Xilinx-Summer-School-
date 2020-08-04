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
reg [31:0] a;//���������
reg [31:0] b;
reg [1:0] ctl;//�������
wire [31:0] c;


assign rcount = count[9:2];
//count: ʱ�����ڼ�����, count[1:0] == 2'b00ʱ, ��ַ�ı䣻count[1:0] == 2'b11ʱ���������ݴ洢
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
//addr: RAM��ַ��
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
//mem:  8λ���ݼĴ����飬����0x00 ~ 0x0F ������ͬʱ����FPU����
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
               ctl<=mem[8];//ѡ����㹦��
               a<={mem[0],mem[1],mem[2],mem[3]};//��������
               b<={mem[4],mem[5],mem[6],mem[7]};
               end
          end
        else if ((rcount==18)&&(count[1:0] == 2'b11))
        begin mem[10]<=c[31:24];//������
              mem[11]<=c[23:16];
              mem[12]<=c[15:8];
              mem[13]<=c[7:0];
        end             
end
//data_out: ��mem�н����������
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
//wen: RAMдʹ��
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
//����fpu����
FPU fpu1(
   .a(a),
   .b(b),
   .c(c),
   .clk(clk),
   .ctl(ctl)
   );
endmodule
