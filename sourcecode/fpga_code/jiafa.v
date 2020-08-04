`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/08/03 23:23:45
// Design Name: 
// Module Name: jiafa
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


module jiafa(clk,a,b,c);
input   clk;
input   [31:0]a,b;
output  reg [31:0]  c;
reg [25:0]  aw,bw,cw;
reg [7:0]   az,bz,cz;
reg [2:0]   state;
parameter   start=3'b000,zero=3'b001,duiqi=3'b010,xiangjia=3'b011,guigehua=3'b100,over=3'b101;
always@(posedge clk)
begin
case(state)
start:
    begin
        aw<={a[31],1'b0,1'b1,a[22:0]};
        az<=a[30:23];
        bw<={b[31],1'b0,1'b1,b[22:0]};
        bz<=b[30:23];
        state<=zero;
     end
zero:
    begin
        if(aw==0)
            begin
               cw<=bw;
               cz<=bz;
               state<=over;
            end
        else if(bw==0)
            begin
               cw<=aw;
               cz<=az;
               state<=over;
            end
        else
            state<=duiqi;
    end        
duiqi:
    begin
        if(az==bz)
            state<=xiangjia;
        else if(az>bz)
            begin
                bz<=bz+1;  
                bw[24:0]<={1'b0,bw[24:1]};
                if(bw==0)
                    begin
                      cw<=aw;
                      cz<=az;
                      state<=over;
                     end
                else
                     state<=duiqi;
             end
             else
            begin
                az<=az+1;  
                aw[24:0]<={1'b0,aw[24:1]};
                if(aw==0)
                    begin
                      cw<=bw;
                      cz<=bz;
                      state<=over;
                     end
                else
                     state<=duiqi;
             end
      end
xiangjia:
    begin
        if(aw[25]==bw[25])
            begin
                cw[25]<=aw[25];
                cw[24:0]<=aw[24:0]+bw[24:0];
            end
        else
            if(aw[24:0]>bw[24:0])
                begin
                    cw[25]<=aw[25];
                    cw[24:0]<=aw[24:0]-bw[24:0];
                end
             else
                begin
                    cw[25]<=bw[25];
                    cw[24:0]<=bw[24:0]-aw[24:0];
                end
         cz<=az;
         state<=guigehua;
     end
guigehua:
    begin
        if(cw[24]==1)
            begin
                cw[24:0]<={1'b0,cw[24:1]};
                cz<=cz+1;
                state<=over;
            end
        else
        begin
             if(cw[23]==0)
                begin
                    cw[24:0]<={cw[23:0],1'b0};
                    cz<=cz-1;
                    state<=guigehua;
                end
             else
                 state<=over;   
         end      
     end
over:
    begin
        c<={cw[25],cz[7:0],cw[22:0]};  
        state<=start;
    end
default:
    begin
         state<=start;
    end
 endcase                                             
end
    
endmodule
