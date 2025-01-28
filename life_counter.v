`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.01.2025 15:13:30
// Design Name: 
// Module Name: life_counter
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


module life_counter (
    input wire clk,       
    input wire reset,      
    input wire miss,       
    output reg [1:0] dig0
);
    reg miss_prev;
    always @(posedge clk) begin
        if (reset) begin
            dig0 <= 2'd3;
            miss_prev <= 1'b0;
        end else begin
           
            if (miss && !miss_prev) begin
                if (dig0 == 2'd0) begin
                    dig0 <= 2'd3; 
                end else begin
                    dig0 <= dig0 - 1;  
                end
            end
            miss_prev <= miss; 
        end
    end

endmodule

