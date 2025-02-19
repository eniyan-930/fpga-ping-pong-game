`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.02.2025 19:52:17
// Design Name: 
// Module Name: life_heart
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


`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.02.2025 23:43:51
// Design Name: 
// Module Name: life_heart
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


module life_heart(
input clk, rst,
input [1:0]lives,input [9:0] x,y,
output reg [11:0] rgb,
output heart_on
    );
    localparam heart1_x1=512;
    localparam heart1_x2=536;
    localparam heart2_x1=551;   
    localparam heart2_x2=574;
    localparam heart3_x1=586;
    localparam heart3_x2=608;
    localparam heart_y1=30;
    localparam heart_y2=53;
    
    wire heart1_on, heart2_on,heart3_on;
    wire cond1,cond2,cond3;
    assign cond1=(lives>0);
    assign cond2=(lives>1);
    assign cond3=(lives>2);
    
    assign heart1_on = (x>heart1_x1) && (x<heart1_x2)&& (y>heart_y1) && (y<heart_y2) && cond1;
    assign heart2_on = (x>heart2_x1) && (x<heart2_x2)&& (y>heart_y1) && (y<heart_y2)&& cond2;
    assign heart3_on = (x>heart3_x1) && (x<heart3_x2)&& (y>heart_y1) && (y<heart_y2)&& cond3;
    
    wire [4:0] col1,col2,col3;
    wire [4:0] row1;
    assign col1= x-heart1_x1;
    assign col2= x-heart2_x1;
    assign col3= x-heart3_x1;
    assign row1= y-heart_y1;
    
    wire[11:0] rgb_h1,rgb_h2,rgb_h3;
   heart_rom h1(.clk(clk),.row(row1),.col(col1),.color_data(rgb_h1));
    heart_rom h2(.clk(clk),.row(row1),.col(col2),.color_data(rgb_h2));
    heart_rom h3(.clk(clk),.row(row1),.col(col3),.color_data(rgb_h3));
    
    always@(*)begin
       if(heart1_on ) rgb=rgb_h1;
       else if(heart2_on) rgb=rgb_h2;
       else if(heart3_on) rgb=rgb_h3;
       else rgb=0;
    end
    assign heart_on= heart1_on || heart2_on || heart3_on;
endmodule