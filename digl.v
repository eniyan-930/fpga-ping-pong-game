`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.01.2025 21:27:08
// Design Name: 
// Module Name: digl
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

module digl(input clk,input[1:0] life,input [9:0] x,y,output[11:0] rgb,output digl_on);
parameter digitl_x1 = 308;
parameter digitl_x2= 321;
parameter digitl_y1 = 60;
parameter digitl_y2 = 74;
wire [3:0] col_digitl,row_digitl;
assign digl_on  = (x>digitl_x1) & (x<digitl_x2) & (y>digitl_y1) & (y<digitl_y2);
assign col_digitl = x - digitl_x1;
assign row_digitl = y - digitl_y1;
number_rom n1(.clk(clk),.row(row_digitl),.col(col_digitl),.score({2'b0,life}),.color_data(rgb));
endmodule
