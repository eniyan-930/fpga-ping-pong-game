`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.12.2024 01:48:51
// Design Name: 
// Module Name: start
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


module start(input up1,down1,enter,reset,clk,video_on,input [9:0]x,y,output [11:0] rgb_start,output start_on,multi,single);
parameter player1_y1 = 201;
parameter player1_y2 = 239;
parameter player_x1 = 241;
parameter player_x2 = 451;
parameter player2_y1 = 256;
parameter player2_y2 = 295;
parameter arrow_x1 = 188;
parameter arrow_x2 = 218;
parameter arrow_y1 = 201;
parameter arrow_size = 26;
parameter pong_x1 = 150;
parameter pong_x2 = 530;
parameter pong_y1 = 27;
parameter pong_y2 = 129;
wire video_on,p_tick;
wire[9:0] x,y;
wire [11:0] player1_rgb,player2_rgb,arrow_rgb,pong_rgb;
wire player1_on,player2_on,arrow_on,pong_on;
wire [5:0] row_player1,row_player2;
wire [7:0] col_player1,col_player2;
wire [6:0] row_pong;
wire [8:0] col_pong;
reg [8:0] arrow_next,arrow_reg;
wire [8:0] arrow_t,arrow_b;
reg[11:0] rgb_reg,rgb_next;
assign p_tick = ((y==480) && (x==0));  
always@(posedge clk)
begin
if(reset) arrow_reg<=arrow_y1;
else arrow_reg <=arrow_next;
end
always@(*)
begin
if(up1 || down1)
begin
if(arrow_reg==arrow_y1)
arrow_next = player2_y1;
else
arrow_next = arrow_y1;
end
else 
arrow_next = arrow_reg;
end
assign player1_on = (x>player_x1) & (x<player_x2) & (y>player1_y1) & (y<player1_y2);
assign player2_on = (x>player_x1) & (x<player_x2) & (y>player2_y1) & (y<player2_y2);
assign pong_on = (x>pong_x1) & (x<pong_x2) & (y>pong_y1) & (y<pong_y2);
assign arrow_on = (x>arrow_x1) & (x<arrow_x2) & (y>arrow_t) & (y<arrow_b);
assign col_player1 = x - player_x1;
assign row_player1 = y - player1_y1;
assign col_player2 = x - player_x1;
assign row_player2 = y - player2_y1; 
assign row_pong = y - pong_y1;
assign col_pong = x - pong_x1;
assign arrow_t = arrow_reg;
assign arrow_b = arrow_reg+arrow_size;
assign single= (enter)&&(arrow_t==arrow_y1);
assign multi = (enter)&&(arrow_t==player2_y1);
assign arrow_rgb = 12'b110011110111;
single_text_rom rom1(.clk(clk),.row(row_player1),.col(col_player1),.color_data(player1_rgb));
multi_rom rom2(.clk(clk),.row(row_player2),.col(col_player2),.color_data(player2_rgb));
pong_rom rom3(.clk(clk),.row(row_pong),.col(col_pong),.color_data(pong_rgb));
assign start_on = arrow_on | player1_on | player2_on|pong_on;
always@(*)
begin
if(!video_on) rgb_next=12'd0;
else
begin
if(arrow_on) rgb_next = arrow_rgb;
else if(player1_on) rgb_next = player1_rgb;
else if(player2_on) rgb_next = player2_rgb;
else if(pong_on) rgb_next=pong_rgb;
else rgb_next=12'd0;
end
end
always@(posedge clk)
begin
if(p_tick)
rgb_reg<=rgb_next;
end
assign rgb_start = rgb_reg;
endmodule

