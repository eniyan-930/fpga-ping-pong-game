`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.12.2024 02:15:54
// Design Name: 
// Module Name: gameover
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


module gameover(input [9:0] x,y,input enter,clk,up1,down1,video_on,p_tick,output [11:0] rgb_over,output restart);
parameter x1_game = 204;
parameter x2_game = 431;
parameter y1_game = 66;
parameter y2_game = 99;
parameter x1_save = 248;
parameter x2_save = 398;
parameter y1_save = 139;
parameter y2_save = 163;
parameter x1_cat = 224;
parameter x2_cat = 419;
parameter y1_cat = 234;
parameter y2_cat = 382;
wire game_on,save_on,cat_on;
wire [11:0] cat_rgb,save_rgb,game_rgb;
reg [11:0] rgb_next,rgb_reg;
assign game_on = (x>x1_game) & (x<x2_game) & (y>y1_game) & (y<y2_game);
assign save_on = (x>x1_save) & (x<x2_save) & (y>y1_save) & (y<y2_save);
assign cat_on = (x>x1_cat) & (x<x2_cat) & (y>y1_cat) & (y<y2_cat);
wire [7:0] cat_col,cat_row,save_col,game_col;
wire [4:0] save_row,game_row;
assign cat_col = x-x1_cat;
assign cat_row = y-y1_cat;
assign save_col = x-x1_save;
assign save_row = y-y1_save;
assign game_col = x-x1_game;
assign game_row = y-y1_game;
game_over_rom g1(.clk(clk),.row(game_row),.col(game_col),.color_data(game_rgb));
save_rom s1(.clk(clk),.row(save_row),.col(save_col),.color_data(save_rgb));
cat_rom c1(.clk(clk),.row(cat_row),.col(cat_col),.color_data(cat_rgb));
always@(*)
begin
if(!video_on) rgb_next = 12'b0;
else if(game_on) rgb_next = game_rgb;
else if(save_on) rgb_next = save_rgb;
else if(cat_on) rgb_next  = cat_rgb;
else rgb_next = 12'b0; 
end
always@(posedge clk)
begin
if(p_tick)
rgb_reg<=rgb_next;
end
assign rgb_over = rgb_reg;
assign restart = (enter || up1 || down1 );
endmodule
