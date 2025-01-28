`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.01.2025 15:38:28
// Design Name: 
// Module Name: score_life_handler
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


module score_life_handler(input [9:0] x,y,input clk,video_on,input [3:0] score,output [11:0] rgb,output sl_on);
parameter score_x1 = 246;
parameter score_x2= 302;
parameter score_y1 = 30;
parameter score_y2 = 51;
parameter life_x1 = 246;
parameter life_x2= 302;
parameter life_y1 = 60;
parameter life_y2 = 73;
parameter digit2_x1 = 308;
parameter digit2_x2= 321;
parameter digit2_y1 = 30;
parameter digit2_y2 = 43;
//parameter digit1_x1 = 325;
//parameter digit1_x2= 338;
//parameter digit1_y1 = 30;
//parameter digit1_y2 = 43;
//parameter digitl_x1 = 289;
//parameter digitl_x2= 302;
//parameter digitl_y1 = 60;
//parameter digitl_y2 = 74;
wire [4:0] row_score;
wire [3:0] row_life,row_digit2,col_digit2;
wire [5:0] col_score,col_life;
wire [11:0] rgb_score,rgb_life,rgb_digit1,rgb_digit2,rgb_digitl;
reg [11:0] next_rgb;
assign score_on = (x>score_x1) & (x<score_x2) & (y>score_y1) & (y<score_y2);
assign life_on = (x>life_x1) & (x<life_x2) & (y>life_y1) & (y<life_y2);
assign digit2_on  = (x>digit2_x1) & (x<digit2_x2) & (y>digit2_y1) & (y<digit2_y2);
//assign digit1_on  = (x>digit1_x1) & (x<digit1_x2) & (y>digit1_y1) & (y<digit1_y2);
//assign digitl_on  = (x>digitl_x1) & (x<digitl_x2) & (y>digitl_y1) & (y<digitl_y2);
assign col_score = x - score_x1;
assign row_score = y- score_y1;
assign col_life = x - life_x1;
assign row_life = y- life_y1;
assign col_digit2 = x - digit2_x1;
assign row_digit2 = y - digit2_y1;
//assign col_digit1 = x - digit1_x1;
//assign row_digit1 = y - digit1_y1;
//assign col_digitl = x - digitl_x1;
//assign row_digitl = y - digitl_y1;
assign sl_on  = score_on || life_on || digit2_on;

lives_rom l2(.clk(clk),.row(row_life),.col(col_life),.color_data(rgb_life));
score_rom s2(.clk(clk),.row(row_score),.col(col_score),.color_data(rgb_score));
number_rom n1(.clk(clk),.row(row_digit2),.col(col_digit2),.score(score),.color_data(rgb_digit2));
//number_rom n2(.clk(clk),.row(row_digit1),.col(col_digit1),.score(score[3:0]),.color_data(rgb_digit1));
//number_rom n3(.clk(clk),.row(row_digitl),.col(col_digitl),.score({2'd0,life}),.color_data(rgb_digitl));
always@(*)
begin
if(!video_on) next_rgb = 12'b0;
else if (life_on) next_rgb = rgb_life;
else if (score_on) next_rgb = rgb_score;
//else if (digit1_on) next_rgb = rgb_digit1;
else if (digit2_on) next_rgb = rgb_digit2;
//else if (digitl_on) next_rgb = rgb_digitl;
else next_rgb = 12'b0;
end
assign rgb = next_rgb;
endmodule
