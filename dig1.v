`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.01.2025 21:27:08
// Design Name: 
// Module Name: dig1
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


module dig1(input clk,input[3:0] score,input [9:0] x,y,output[11:0] rgb,output dig1_on);
parameter digit1_x1 = 325;
parameter digit1_x2= 338;
parameter digit1_y1 = 30;
parameter digit1_y2 = 43;
wire [3:0] col_digit1,row_digit1;
assign dig1_on  = (x>digit1_x1) & (x<digit1_x2) & (y>digit1_y1) & (y<digit1_y2);
assign col_digit1 = x - digit1_x1;
assign row_digit1 = y - digit1_y1;
number_rom n1(.clk(clk),.row(row_digit1),.col(col_digit1),.score(score),.color_data(rgb));
endmodule
