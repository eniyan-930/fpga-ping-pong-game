`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.12.2024 02:40:11
// Design Name: 
// Module Name: continue
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


module continue(input [9:0] x,y,input up1,down1,clk,won,reset,video_on,p_tick,enter,output [11:0] rgb_continue,output yes,no);
parameter x1_cont = 243;
parameter x2_cont = 279;
parameter y1_cont = 192;
parameter y2_cont = 216;
parameter x1_player = 234;
parameter x2_player = 305;
parameter y1_player = 126;
parameter y2_player = 147;
parameter x1_won = 335;
parameter x2_won = 385;
parameter y1_won = 132;
parameter y2_won = 143;
parameter x1_mark = 393;
parameter x2_mark = 397;
parameter y1_mark = 124;
parameter y2_mark = 144;
parameter x1_yes = 225;
parameter x2_yes = 262;
parameter y1_yes = 258;
parameter y2_yes = 276;
parameter x1_no = 358;
parameter x2_no = 392;
parameter y1_no = 258;
parameter y2_no = 276;
parameter x1_nu = 315;
parameter x2_nu = 328;
parameter y1_nu = 127;
parameter y2_nu = 141;
parameter x1_arrow = 196;
parameter x2_arrow = 329;
parameter y1_arrow = 256;
parameter y2_arrow = 274;
wire player_on,cont_on,yes_on,no_on,mark_on,nu_on,arrow_on;
reg [8:0] arrow_next,arrow_reg;
wire [8:0] arrow_l,arrow_r;
always@(posedge clk)
begin
if(reset) arrow_reg<=x1_arrow;
else arrow_reg <=arrow_next;
end
always@(*)
begin
if(up1 || down1)
begin
if(arrow_reg==x1_arrow)
arrow_next = x2_arrow;
else
arrow_next = x1_arrow;
end
else 
arrow_next = arrow_reg;
end
assign player_on=(x>x1_player) & x<(x2_player) & (y>y1_player) & (y<y2_player);
assign nu_on=(x>x1_nu) & x<(x2_nu) & (y>y1_nu) & (y<y2_nu);
assign mark_on=(x>x1_mark) & x<(x2_mark) & (y>y1_mark) & (y<y2_mark);
assign cont_on=(x>x1_cont) & x<(x2_cont) & (y>y1_cont) & (y<y2_cont);
assign yes_on=(x>x1_yes) & x<(x2_yes) & (y>y1_yes) & (y<y2_yes);
assign no_on=(x>x1_no) & x<(x2_no) & (y>y1_no) & (y<y2_no);
assign won_on=(x>x1_won) & x<(x2_won) & (y>y1_won) & (y<y2_won);
assign arrow_l = arrow_reg;
assign arrow_r = arrow_reg+20;
assign arrow_on  = (x>arrow_l) & (x<arrow_r) & (y>y1_arrow) &(y<y2_arrow);
wire [4:0] player_row;
wire [6:0] player_col;
wire [3:0] won_row;
wire [5:0] won_col;
wire [4:0] mark_row;
wire [1:0] mark_col;
wire [4:0] cont_row;
wire [7:0] cont_col;
wire [4:0] yes_row,no_row;
wire [5:0] yes_col,no_col;
wire [3:0] nu_row,nu_col;
reg [3:0] row_nu,col_nu;
wire [11:0] player_rgb,won_rgb,mark_rgb,yes_rgb,no_rgb,continue_rgb,arrow_rgb;
reg [11:0] nu_rgb;
reg [11:0] rgb_reg,rgb_next;

always@(posedge clk) begin 
col_nu<=nu_col;
row_nu<=nu_row;
end
assign player_row = y-y1_player;
assign player_col = x-x1_player;
assign won_row = y-y1_won;
assign won_col = x-x1_won;
assign mark_row = y-y1_mark;
assign mark_col = x-x1_mark;
assign cont_row = y-y1_cont;
assign cont_col = x-x1_cont;
assign yes_row = y-y1_yes;
assign yes_col = x-x1_yes;
assign no_row = y-y1_no;
assign no_col = x-x1_no;
assign nu_row = y-y1_nu;
assign nu_col = x-x1_nu;
assign arrow_rgb = 12'b100101010110;
player_rom pl(.clk(clk),.row(player_row),.col(player_col),.color_data(player_rgb));
continue_rom p2(.clk(clk),.row(cont_row),.col(cont_col),.color_data(continue_rgb));
mark_rom p3(.clk(clk),.row(mark_row),.col(mark_col),.color_data(mark_rgb));
won_rom p4(.clk(clk),.row(won_row),.col(won_col),.color_data(won_rgb));
yes_rom p5(.clk(clk),.row(yes_row),.col(yes_col),.color_data(yes_rgb));
no_rom p6(.clk(clk),.row(no_row),.col(no_col),.color_data(no_rgb));
always@(*)
begin
case(won)
1'b0:begin
case ({row_nu, col_nu})
		
		8'b00000110: nu_rgb = 12'b111100010001;
		8'b00000111: nu_rgb = 12'b111100010001;
		
		8'b00010110: nu_rgb = 12'b111100010001;
		8'b00010111: nu_rgb = 12'b111100010001;
		
		8'b00100011: nu_rgb = 12'b111100010001;
		8'b00100100: nu_rgb = 12'b111100010001;
		8'b00100101: nu_rgb = 12'b111100010001;
		8'b00100110: nu_rgb = 12'b111100010001;
		8'b00100111: nu_rgb = 12'b111100010001;
		
		8'b00110011: nu_rgb = 12'b111100010001;
		8'b00110100: nu_rgb = 12'b111100010001;
		8'b00110101: nu_rgb = 12'b111100010001;
		8'b00110110: nu_rgb = 12'b111100010001;
		8'b00110111: nu_rgb = 12'b111100010001;
		
		8'b01100110: nu_rgb = 12'b111100010001;
		8'b01100111: nu_rgb = 12'b111100010001;
		
		8'b01110110: nu_rgb = 12'b111100010001;
		8'b01110111: nu_rgb = 12'b111100010001;
		
		8'b10000110: nu_rgb = 12'b111100010001;
		8'b10000111: nu_rgb = 12'b111100010001;
		
		8'b10010110: nu_rgb = 12'b111100010001;
		8'b10010111: nu_rgb = 12'b111100010001;
		
		8'b10100110: nu_rgb = 12'b111100010001;
		8'b10100111: nu_rgb = 12'b111100010001;
		
		8'b10110110: nu_rgb = 12'b111100010001;
		8'b10110111: nu_rgb = 12'b111100010001;
		
		8'b11000000: nu_rgb = 12'b111100010001;
		8'b11000001: nu_rgb = 12'b111100010001;
		8'b11000010: nu_rgb = 12'b111100010001;
		8'b11000011: nu_rgb = 12'b111100010001;
		8'b11000100: nu_rgb = 12'b111100010001;
		8'b11000101: nu_rgb = 12'b111100010001;
		8'b11000110: nu_rgb = 12'b111100010001;
		8'b11000111: nu_rgb = 12'b111100010001;
		8'b11001000: nu_rgb = 12'b111100010001;
		8'b11001001: nu_rgb = 12'b111100010001;
		8'b11001010: nu_rgb = 12'b111100010001;
		8'b11001011: nu_rgb = 12'b111100010001;
		8'b11001100: nu_rgb = 12'b111100010001;

		8'b11010000: nu_rgb = 12'b111100010001;
		8'b11010001: nu_rgb = 12'b111100010001;
		8'b11010010: nu_rgb = 12'b111100010001;
		8'b11010011: nu_rgb = 12'b111100010001;
		8'b11010100: nu_rgb = 12'b111100010001;
		8'b11010101: nu_rgb = 12'b111100010001;
		8'b11010110: nu_rgb = 12'b111100010001;
		8'b11010111: nu_rgb = 12'b111100010001;
		8'b11011000: nu_rgb = 12'b111100010001;
		8'b11011001: nu_rgb = 12'b111100010001;
		8'b11011010: nu_rgb = 12'b111100010001;
		8'b11011011: nu_rgb = 12'b111100010001;
		8'b11011100: nu_rgb = 12'b111100010001;

		default:nu_rgb = 12'd0;
	endcase
	
end
1'b1:begin
case ({row_nu, col_nu})
		
		8'b00000011: nu_rgb = 12'b111100010001;
		8'b00000100: nu_rgb = 12'b111100010001;
		8'b00000101: nu_rgb = 12'b111100010001;
		8'b00000110: nu_rgb = 12'b111100010001;
		8'b00000111: nu_rgb = 12'b111100010001;
		8'b00001000: nu_rgb = 12'b111100010001;
		
		8'b00010011: nu_rgb = 12'b111100010001;
		8'b00010100: nu_rgb = 12'b111100010001;
		8'b00010101: nu_rgb = 12'b111100010001;
		8'b00010110: nu_rgb = 12'b111100010001;
		8'b00010111: nu_rgb = 12'b111100010001;
		8'b00011000: nu_rgb = 12'b111100010001;
	
		8'b00100000: nu_rgb = 12'b111100010001;
		8'b00100001: nu_rgb = 12'b111100010001;
		8'b00100010: nu_rgb = 12'b111100010001;
		
		8'b00101001: nu_rgb = 12'b111100010001;
		8'b00101010: nu_rgb = 12'b111100010001;

		8'b00110000: nu_rgb = 12'b111100010001;
		8'b00110001: nu_rgb = 12'b111100010001;
		8'b00110010: nu_rgb = 12'b111100010001;
		
		8'b00111001: nu_rgb = 12'b111100010001;
		8'b00111010: nu_rgb = 12'b111100010001;

		
		8'b01001001: nu_rgb = 12'b111100010001;
		8'b01001010: nu_rgb = 12'b111100010001;

		
		8'b01011001: nu_rgb = 12'b111100010001;
		8'b01011010: nu_rgb = 12'b111100010001;

		8'b01100111: nu_rgb = 12'b111100010001;
		8'b01101000: nu_rgb = 12'b111100010001;
		
		8'b01110111: nu_rgb = 12'b111100010001;
		8'b01111000: nu_rgb = 12'b111100010001;
		
		8'b10000101: nu_rgb = 12'b111100010001;
		8'b10000110: nu_rgb = 12'b111100010001;
		
		8'b10010101: nu_rgb = 12'b111100010001;
		8'b10010110: nu_rgb = 12'b111100010001;
		
		8'b10100011: nu_rgb = 12'b111100010001;
		8'b10100100: nu_rgb = 12'b111100010001;
		
		8'b10110011: nu_rgb = 12'b111100010001;
		8'b10110100: nu_rgb = 12'b111100010001;
		

		8'b11000000: nu_rgb = 12'b111100010001;
		8'b11000001: nu_rgb = 12'b111100010001;
		8'b11000010: nu_rgb = 12'b111100010001;
		8'b11000011: nu_rgb = 12'b111100010001;
		8'b11000100: nu_rgb = 12'b111100010001;
		8'b11000101: nu_rgb = 12'b111100010001;
		8'b11000110: nu_rgb = 12'b111100010001;
		8'b11000111: nu_rgb = 12'b111100010001;
		8'b11001000: nu_rgb = 12'b111100010001;
		8'b11001001: nu_rgb = 12'b111100010001;
		8'b11001010: nu_rgb = 12'b111100010001;

		8'b11010000: nu_rgb = 12'b111100010001;
		8'b11010001: nu_rgb = 12'b111100010001;
		8'b11010010: nu_rgb = 12'b111100010001;
		8'b11010011: nu_rgb = 12'b111100010001;
		8'b11010100: nu_rgb = 12'b111100010001;
		8'b11010101: nu_rgb = 12'b111100010001;
		8'b11010110: nu_rgb = 12'b111100010001;
		8'b11010111: nu_rgb = 12'b111100010001;
		8'b11011000: nu_rgb = 12'b111100010001;
		8'b11011001: nu_rgb = 12'b111100010001;
		8'b11011010: nu_rgb = 12'b111100010001;

		default:nu_rgb = 12'd0;
	endcase
end
endcase
end
always@(*)
begin
if(!video_on) rgb_next=12'd0;
else
begin
if(arrow_on) rgb_next = arrow_rgb;
else if(player_on) rgb_next = player_rgb;
else if(mark_on) rgb_next = mark_rgb;
else if(cont_on) rgb_next=continue_rgb;
else if(won_on) rgb_next=won_rgb;
else if(nu_on) rgb_next=nu_rgb;
else if(yes_on) rgb_next=yes_rgb;
else if(no_on) rgb_next=no_rgb;
else rgb_next=12'd0;
end
end
always@(posedge clk)
begin
if(p_tick)
rgb_reg<=rgb_next;
end
assign rgb_continue = rgb_reg;
assign yes = (arrow_reg == x1_arrow) & enter;
assign no =  (arrow_reg == x2_arrow) & enter;
endmodule

