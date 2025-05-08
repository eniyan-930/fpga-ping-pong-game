`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.01.2025 17:24:01
// Design Name: 
// Module Name: multi
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
// Create Date: 24.12.2024 12:43:33
// Design Name: 
// Module Name: graphic_multi
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


module multi(
    input clk,
    input p_tick,
    input reset,
    input [1:0] up,
    input [1:0] down,
    input [9:0] pix_x,
    input [9:0] pix_y,
    input video,
    output miss1,
    output miss2,
    output [11:0] rgb,
    output graphics,
    output hi
    );
    parameter max_x = 640;
    parameter max_y = 480;
    parameter pad1_l = 17;
    parameter pad1_r = 25;
    parameter pad2_l = 615;
    parameter pad2_r = 623;
    parameter ballside = 15;
    parameter pad_vel = 8;
    parameter vel_p = 4;
    parameter vel_n = -4;
    parameter pad_len = 70;
    reg [9:0] pad1_reg , pad1_next , pad2_reg , pad2_next;
    wire [9:0] pad1_t , pad1_b , pad2_t , pad2_b;
    wire pad1_on , pad2_on;
    wire [3:0] control;
    reg [9:0] pad1_dis , pad2_dis;
    reg m1 , m2;
    reg m1_reg , m2_reg;
    reg [1:0] hit_reg;
    reg [1:0] hit;
    reg [11:0] rgb_reg , rgb_next;
//    wire miss;
//    wire [2:0] dir;
//    RaNuGe (clk,reset,miss,dir);
//    assign miss = m1_reg | m2_reg;
    assign pad1_on = (pix_x < pad1_r) & (pix_x > pad1_l) & (pix_y > pad1_t) & (pix_y < pad1_b);
    assign pad2_on = (pix_x < pad2_r) & (pix_x > pad2_l) & (pix_y >pad2_t) & (pix_y < pad2_b);
    assign pad1_t = pad1_reg;
    assign pad1_b = pad1_reg + pad_len - 1;
    assign pad2_t = pad2_reg;
    assign pad2_b = pad2_reg + pad_len - 1;
    assign control = {up,down};
    always @ (posedge clk) begin
       if(reset) begin
          m1_reg <= 1'b0;
          m2_reg <= 1'b0;
          hit_reg <= 2'b00;
       end
       else begin
          m1_reg <= m1;
          m2_reg <= m2;
          hit_reg <= hit;
       end
    end
    always @ (posedge clk) begin
    if(p_tick) begin
       if(reset) begin
          pad1_reg <= (max_y/2 - 1) - pad_len/2;
          pad2_reg <= (max_y/2 - 1) - pad_len/2;
       end
       else begin
          pad1_reg <= pad1_next;
          pad2_reg <= pad2_next;
       end
       end
    end
    always @ (*) begin
       pad1_dis = max_y - pad1_b - 1;
       pad2_dis = max_y - pad2_b - 1;
       pad1_next = pad1_reg;
       pad2_next = pad2_reg;
       //case(control)hy  
           //4'b1000 : begin
           if(pix_y == 500 && pix_x == 0) begin
                        if(pad1_reg > 20 && up[1]==1'b1) begin
                           pad1_next = pad1_reg - pad_vel;
                        end                 
       
                     //end
           //4'b0100 : begin
                        if(pad2_reg > 20 && up[0]==1'b1) begin
                           pad2_next = pad2_reg - pad_vel;
                        end
                        
                    // end
         
                        if(pad1_dis > pad_vel && down[1]==1'b1) begin
                           pad1_next = pad1_reg + pad_vel;
                        end
   
                     
                        if(pad2_dis > pad_vel && down[0]==1'b1) begin
                           pad2_next = pad2_reg + pad_vel;
                        end
                        end
                        
          
    end
//    wire [2:0] rom_row , rom_col;
//    reg [7:0] rom_data;
//    wire rom_bit;
    reg [9:0] x_vel_reg , x_vel_next , y_vel_reg , y_vel_next;
    reg [9:0] ball_x_reg , ball_y_reg;
    wire [9:0] ball_x_next , ball_y_next;
    wire [9:0] ball_l , ball_r , ball_t , ball_b;
//    wire sq_on;
    wire ball_on;
//    assign rom_row = pix_y[2:0] - ball_y_reg[2:0];
//    assign rom_col = pix_x[2:0] - ball_x_reg[2:0];
//    always @ (*) begin
//        case(rom_row)
//           3'd0 : rom_data = 8'b00111100;
//           3'd1 : rom_data = 8'b01111110;
//           3'd2 : rom_data = 8'b11111111;
//           3'd3 : rom_data = 8'b11111111;
//           3'd4 : rom_data = 8'b11111111;
//           3'd5 : rom_data = 8'b11111111;
//           3'd6 : rom_data = 8'b01111110;
//           3'd7 : rom_data = 8'b00111100;
//        endcase
//    end
//    assign rom_bit = rom_data[rom_col];
//    assign sq_on = (pix_x >= ball_l) & (pix_x < ball_r) & (pix_y >= ball_t) & (pix_y < ball_b);
//    assign ball_on = sq_on & rom_bit;
    assign ball_on = (pix_x >= ball_l) & (pix_x < ball_r) & (pix_y >= ball_t) & (pix_y < ball_b);
    assign ball_t = ball_y_reg;
    assign ball_b = ball_y_reg + ballside - 1;
    assign ball_l = ball_x_reg;
    assign ball_r = ball_x_reg + ballside - 1;
    always @ (posedge clk) begin
       if(p_tick) begin
       if(reset) begin
          x_vel_reg <= vel_p;
          y_vel_reg <= vel_p;
       end
       else begin
          x_vel_reg <= x_vel_next;
          y_vel_reg <= y_vel_next;
       end
       end
    end
    always @ (*) begin
       if(pix_y == 500 && pix_x == 0) begin
       if(ball_t < 25) begin
          x_vel_next = x_vel_reg;
          y_vel_next = vel_p;
          hit = hit_reg;
       end
       else if(ball_b > max_y - 1) begin
          x_vel_next = x_vel_reg;
          y_vel_next = vel_n;
          hit = hit_reg;
       end
       else if((ball_l < pad1_l + 10) & (ball_b > pad1_t) & (ball_t < pad1_b)) begin
          x_vel_next = vel_p;
          y_vel_next = y_vel_reg;
          hit = 2'b00;
       end
       else if((ball_r > pad2_r - 10) & (ball_b > pad2_t) & (ball_t < pad2_b)) begin
          x_vel_next = vel_n;
          y_vel_next = y_vel_reg;
          hit = 2'b01;
       end 
       else if(ball_x_reg < 1 ) begin
          x_vel_next = vel_p;
          y_vel_next = y_vel_reg;
          hit = 2'b10;
       end
       else if(ball_r > max_x ) begin
          x_vel_next = vel_n;
          y_vel_next = y_vel_reg;
          hit = 2'b11;
       end
//       else if(miss) begin
//          if(dir == 3'd0 | dir == 3'd6) begin
//             x_vel_next = vel_n;
//             y_vel_next = vel_n;
//             hit = 2'b00;
//          end
//          else if(dir == 3'd1 | dir == 3'd5) begin
//             x_vel_next = vel_p;
//             y_vel_next = vel_n;
//             hit = 2'b00;
//          end
//          else if(dir == 3'd2 | dir == 3'd7) begin
//             x_vel_next = vel_p;
//             y_vel_next = vel_p;
//             hit = 2'b00;
//          end
//          else if(dir == 3'd3| dir == 3'd4) begin
//             x_vel_next = vel_n;
//             y_vel_next = vel_p;
//             hit = 2'b00;
//          end
//          else begin
//             x_vel_next = vel_p;
//             y_vel_next = vel_p;
//             hit = 2'b00;
//          end
//       end
       else begin
          x_vel_next = x_vel_reg;
          y_vel_next = y_vel_reg;
          hit = hit_reg;
       end
       end
       else begin
          x_vel_next = x_vel_reg;
          y_vel_next = y_vel_reg;
          hit = hit_reg;
       end
    end
    
    always @ (posedge clk) begin
       if(p_tick) begin
       if(reset) begin
          ball_x_reg <= (max_x - ballside)/2;
          ball_y_reg <= (max_y - ballside)/2;
       end
//       else if(m1_reg) begin
//          ball_x_reg <= (max_x - ballside)/2;
//          ball_y_reg <= (max_y - ballside)/2;
//       end
       else begin
          ball_x_reg <= ball_x_next;
          ball_y_reg <= ball_y_next;
       end
       end
    end 
    assign  ball_x_next = (pix_y == 500 && pix_x == 0) ? ball_x_reg + x_vel_reg : ball_x_reg;
    assign  ball_y_next = (pix_y == 500 && pix_x == 0) ? ball_y_reg + y_vel_reg : ball_y_reg;
    assign miss1 = m1_reg;
    assign miss2 = m2_reg;
    always @ (posedge clk) begin
    if(p_tick) begin
       if(reset) begin
          rgb_reg <= 12'd0;
       end
       else begin
          rgb_reg <= rgb_next;
       end
    end
    end
    always @ (*) begin
       if(~video) begin
          rgb_next = 12'h00f;
          m1 = m1_reg;
          m2 = m2_reg;
       end
       else if(pad1_on) begin
          rgb_next = 12'hfff;
          m1 = m1_reg;
          m2 = m2_reg;
       end
       else if(pad2_on) begin
          rgb_next = 12'hfff;
          m1 = m1_reg;
          m2 = m2_reg;
       end
       else if(ball_on) begin
          if(hit_reg == 2'b00) begin
             rgb_next = 12'hf00;
             m1 = 1'b0;
             m2 = 1'b0;
          end
          else if(hit_reg == 2'b01) begin
             rgb_next = 12'habc;
             m1 = 1'b0;
             m2 = 1'b0;
          end
          else if(hit_reg == 2'b10) begin
             rgb_next = 12'h0f0;
             m1 = 1'b1;
             m2 = 1'b0;
          end
          else begin
             rgb_next = 12'hf0f;
             m1 = 1'b0;
             m2 = 1'b1;
          end
       end
       else begin
          rgb_next = 12'd0;
          m1 = m1_reg;
          m2 = m2_reg;
       end 
    end
    assign graphics = pad1_on|pad2_on|ball_on;
    assign rgb = rgb_reg;
    assign hi = hit_reg;
endmodule

