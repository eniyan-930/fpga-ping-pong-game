`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.01.2025 22:01:39
// Design Name: 
// Module Name: single_fsm_new
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


module single_fsm(
    input clk, rst,
    input video_on,input p_tick,
    input up1,
    input down1,input [9:0] pixel_x,pixel_y,
    output reg[11:0] rgb,
    output miss,
    output  hit
    );
    localparam bar_XL = 620, // left bar player
               bar_XR = 625, // right bar player
               wall_XL=2,
               wall_XR=22,
               bar_LENGTH = 80, // bar length
               bar_V = 8, // bar velocity
               ball_DIAM = 15, // ball diameter minus one
               ball_V = 1; // ball velocity
 
               
    wire bar_on,wall_on,ball_on;
    wire [15:0] rng;
    assign rng=16'b1100100100110011;
    
    reg[9:0] bar_top_q = 10'd200, bar_top_d; // stores upper Y value of bar_1
    reg[9:0] ball_x_q = 320, ball_x_d; // stores left X value of the bouncing ball
    reg[9:0] ball_y_q = 200, ball_y_d; // stores upper Y value of the bouncing ball
    reg ball_xdelta_q = 0, ball_xdelta_d;
    reg ball_ydelta_q = 0, ball_ydelta_d;
    reg[2:0] state_reg;
    reg[2:0] state_next;
    wire [7:0] first_8_bits;
    wire [7:0] last_8_bits;
    
//transition logic
 always @(*) begin
        //Default values to avoid latches
        bar_top_d = bar_top_q;
        ball_x_d = ball_x_q;
        ball_y_d = ball_y_q;
        ball_xdelta_d = ball_xdelta_q;
        ball_ydelta_d = ball_ydelta_q;
        state_reg = state_next;
        
        if (pixel_y == 500 && pixel_x == 0) begin
            // Bar movement logic
            if (up1 && bar_top_q > bar_V) begin
                bar_top_d = bar_top_q - bar_V;
            end else if (down1 && bar_top_q < (480 - bar_LENGTH)) begin
                bar_top_d = bar_top_q + bar_V;
            end

            // Bouncing ball logic
            if ((bar_XL <= (ball_x_q + ball_DIAM) && (ball_x_q + ball_DIAM) <= bar_XR && 
                 bar_top_q <= (ball_y_q + ball_DIAM) && ball_y_q <= (bar_top_q + bar_LENGTH))) begin
                ball_xdelta_d = 0; // Bounce from bar
            end
            if (ball_y_q <= 5)  ball_ydelta_d = 1; // Bounce from top
            if (480 <= (ball_y_q + ball_DIAM)) ball_ydelta_d = 0; // Bounce from bottom
            if (ball_x_q <= 5) ball_xdelta_d = 1; // Bounce from left
           
            // If player misses
            if ((ball_x_q + ball_DIAM) ==635  ) begin

			    bar_top_d=200; //bar @ center
                ball_xdelta_d = ^first_8_bits;
                ball_ydelta_d = ^last_8_bits;
            end
            ball_x_d =((ball_x_q + ball_DIAM) ==635  )?320: ball_xdelta_d ? (ball_x_q + ball_V) : (ball_x_q - ball_V);
            ball_y_d = ((ball_x_q + ball_DIAM) ==635  )?240:ball_ydelta_d ? (ball_y_q + ball_V) : (ball_y_q - ball_V);
        end
 end 
 always @(posedge clk) begin
        if (rst) begin
            bar_top_q <= 200;
            ball_x_q <= 320;
            ball_y_q <= 200;
            ball_xdelta_q <= 0;
            ball_ydelta_q <= 0;
        end else begin
        if(p_tick) begin
            bar_top_q <= bar_top_d;
            ball_x_q <= ball_x_d;
            ball_y_q <= ball_y_d;
            ball_xdelta_q <= ball_xdelta_d;
            ball_ydelta_q <= ball_ydelta_d;
            end
        end
    end    
    assign hit=((bar_XL <= (ball_x_q + ball_DIAM) && (ball_x_q + ball_DIAM) <= bar_XR && 
                 bar_top_q <= (ball_y_q + ball_DIAM) && ball_y_q <= (bar_top_q + bar_LENGTH)));
    assign miss=((ball_x_q + ball_DIAM) ==635);
    assign graph_on = {bar_on, ball_on};
    assign first_8_bits = rng[7:0];
    assign last_8_bits = rng[15:8];
     // Display conditions
    assign wall_on=(wall_XL<=pixel_x && pixel_x<=wall_XR);
    assign bar_on = (bar_XL <= pixel_x && pixel_x <= bar_XR && 
                     bar_top_q <= pixel_y && pixel_y <= (bar_top_q + bar_LENGTH));
    assign ball_on = (ball_x_q <= pixel_x && pixel_x <= (ball_x_q + ball_DIAM) && 
                       ball_y_q <= pixel_y && pixel_y <= (ball_y_q + ball_DIAM));       
    always @(*) begin
        rgb = 0;
        if (video_on) begin
            if (bar_on) rgb = 12'b0000_1001_0000;
            else if(wall_on) rgb= 12'b0000_1111_1111;
            else if (ball_on) rgb = 12'b0000_0000_1111;
            else rgb = 12'b0000_0000_0000; // Background color
        end     
    end 
endmodule
