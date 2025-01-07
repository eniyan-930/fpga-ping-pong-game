module graphic_multi(
    input clk,
    input reset,
    input video,
    input btnup1,
    input btndown1,
    input btnup2,
    input btndown2,
    input still,
    input [9:0] pix_x,
    input [9:0] pix_y,
    output reg miss1,
    output reg miss2,
    output reg [11:0] rgb,
    output graphics
    );
    parameter max_x = 640;
    parameter max_y = 480;
    parameter topb_u = 33;
    parameter topb_d = 36;
    parameter pad1_l = 37;
    parameter pad1_r = 40;
    parameter pad2_l = 600;
    parameter pad2_r = 603;
    parameter ballside = 8;
    parameter pad_vel = 3;
    parameter vel_p = 2;
    parameter vel_n = -2;
    parameter pad_len = 70;
    wire [9:0] pad1_t , pad1_b;
    reg [9:0] pad1_reg , pad1_next;
    wire [9:0] pad2_t , pad2_b;
    reg [9:0] pad2_reg , pad2_next;
    wire [9:0] ball_l , ball_r , ball_t , ball_b;
    reg [9:0] x_vel_reg , x_vel_next , y_vel_reg , y_vel_next;
    reg [9:0] ball_x_reg , ball_y_reg , ball_x_next , ball_y_next;
    wire wall_on , pad1_on , pad2_on , sq_on , ball_on , top_on;
    wire [2:0] rom_row , rom_col;
    wire rom_bit;
    reg [7:0] rom_data;
    wire refresh;
    assign rom_row = pix_y[2:0] - ball_y_reg[2:0];
    assign rom_col = pix_x[2:0] - ball_x_reg[2:0];
    always @ (*) begin
        case(rom_row)
           3'd0 : rom_data = 8'b00111100;
           3'd1 : rom_data = 8'b01111110;
           3'd2 : rom_data = 8'b11111111;
           3'd3 : rom_data = 8'b11111111;
           3'd4 : rom_data = 8'b11111111;
           3'd5 : rom_data = 8'b11111111;
           3'd6 : rom_data = 8'b01111110;
           3'd7 : rom_data = 8'b00111100;
        endcase
    end
    assign rom_bit = rom_data[rom_col];
    assign top_on = pix_y < 37 & pix_y > 32;
    assign pad1_on = pix_x < 41 & pix_x > 36 & pix_y > pad1_t & pad2_b;
    assign pad2_on = pix_x < 604 & pix_x > 599 & pix_y > pad2_t & pix_y < pad2_b;
    assign sq_on = pix_x < ball_r & pix_x > ball_l & pix_y < ball_b & pix_y > ball_t;
    assign ball_on = sq_on & rom_bit;
    always @ (posedge clk or posedge reset) begin
        if(reset) begin
           pad1_reg <= (max_x/2 - pad_len/2) - 1;
           pad2_reg <= (max_x/2 - pad_len/2) - 1;
           x_vel_reg <= vel_p;
           y_vel_reg <= vel_p;
           ball_x_reg <= 0;
           ball_y_reg <= 0;
        end
        else begin
           pad1_reg <= pad1_next;
           pad2_reg <= pad2_next;
           x_vel_reg <= x_vel_next;
           y_vel_reg <= y_vel_next;
           ball_x_reg <= ball_x_next;
           ball_y_reg <= ball_y_next;
        end   
    end
    assign refresh = pix_y == 480 & pix_x == 0;
    assign pad1_t = pad1_reg;
    assign pad1_b = pad1_t + pad_len - 1;
    assign pad2_t = pad2_reg;
    assign pad2_b = pad2_t + pad_len - 1;
    always @ (*) begin
        if(refresh & ~still) begin
            case({btnup1,btnup2})
                2'b00 : begin
                           pad1_next = pad1_reg;
                           pad2_next = pad2_reg;
                        end
                2'b01 : begin
                           pad1_next = pad1_reg;
                           if(pad2_t > topb_d) pad2_next = pad2_reg + pad_vel;
                           else pad2_next = pad2_reg;
                        end 
                2'b10 : begin
                           pad2_next = pad2_reg;
                           if(pad1_t > topb_d) pad1_next = pad1_reg + pad_vel;
                           else pad1_next = pad1_reg;
                        end
                2'b11 : begin
                           if(pad2_t > topb_d) pad2_next = pad2_reg + pad_vel;
                           else pad2_next = pad2_reg;
                           if(pad1_t > topb_d) pad1_next = pad1_reg + pad_vel;
                           else pad1_next = pad1_reg;
                        end                       
            endcase
        end
        else begin
           pad1_next = pad1_reg;
           pad2_next = pad2_reg;
        end
    end
    always @ (*) begin
        if(refresh & ~still) begin
            case({btndown1,btndown2})
                2'b00 : begin
                           pad1_next = pad1_reg;
                           pad2_next = pad2_reg;
                        end
                2'b01 : begin
                           pad1_next = pad1_reg;
                           if(pad2_b < max_y) pad2_next = pad2_reg - pad_vel;
                           else pad2_next = pad2_reg;
                        end 
                2'b10 : begin
                           pad2_next = pad2_reg;
                           if(pad1_b < max_y) pad1_next = pad1_reg - pad_vel;
                           else pad1_next = pad1_reg;
                        end
                2'b11 : begin
                           if(pad2_b < max_y) pad2_next = pad2_reg - pad_vel;
                           else pad2_next = pad2_reg;
                           if(pad1_b < max_y) pad1_next = pad1_reg - pad_vel;
                           else pad1_next = pad1_reg;
                        end                       
            endcase
        end
        else begin
           pad1_next = pad1_reg;
           pad2_next = pad2_reg;
        end
    end
    assign ball_l = ball_x_reg;
    assign ball_r = ball_l + ballside;
    assign ball_t = ball_y_reg;
    assign ball_b = ball_t + ballside;
    always @ (*) begin
       if(still) begin
          x_vel_next = x_vel_reg;
          y_vel_next = y_vel_reg;
       end 
       else if(ball_b > 479) begin 
          y_vel_next = vel_n;
          x_vel_next = x_vel_reg;
       end
       else if(ball_t <= topb_d) begin
          y_vel_next = vel_p;
          x_vel_next = x_vel_reg;
       end
       else if(ball_l <= pad1_r  & ball_t > pad1_t & ball_b < pad1_b) begin
          x_vel_next = vel_p;
          y_vel_next = y_vel_reg;
       end
       else if(ball_r >= pad2_l & ball_t > pad2_t & ball_b < pad2_b) begin
          x_vel_next = vel_n;
          y_vel_next = y_vel_reg;
       end
       else begin
           x_vel_next = vel_p;
           y_vel_next = vel_p;
       end 
    end
    always @ (*) begin
        if(still) begin
           ball_x_next = max_x/2;
           ball_y_next = max_y/2;
        end
        else begin
           if(refresh) begin
              ball_x_next = ball_x_reg + x_vel_reg;
              ball_y_next = ball_y_reg + y_vel_reg;
           end
           else begin
              ball_x_next = ball_x_reg;
              ball_y_next = ball_y_reg;
           end
        end
    end
    always @ (*) begin
       if(ball_l < pad1_r & ball_b < pad1_t & ball_t > pad1_b) begin
          miss1 = 1'b1;
          miss2 = 1'b0;
       end
       else if(ball_r > pad2_l & ball_b < pad2_t & ball_t > pad2_b) begin
          miss1 = 1'b0;
          miss2 = 1'b1;
       end
       else begin
          miss1 = 1'b0;
          miss2 = 1'b0;
       end
    end
     always @ (*) begin
       if(~video) rgb = 12'b0;
       else if(pad2_on) rgb = 12'b1;
       else if(pad1_on) rgb = 12'b1;
       else if(top_on) rgb = 12'b1;
       else if(ball_on) rgb = 12'b1;
       else rgb = 12'b0;
    end
    assign graphics = pad2_on|pad1_on|top_on|ball_on;
endmodule

