`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.01.2025 14:53:36
// Design Name: 
// Module Name: mark_rom
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

module mark_rom
	(
		input wire clk,
		input wire [4:0] row,
		input wire [1:0] col,
		output reg [11:0] color_data
	);

	(* rom_style = "block" *)

	//signal declaration
	reg [4:0] row_reg;
	reg [1:0] col_reg;

	always @(posedge clk)
		begin
		row_reg <= row;
		col_reg <= col;
		end

	always @*
	case ({row_reg, col_reg})
		7'b0000000: color_data = 12'b111100010001;
		7'b0000001: color_data = 12'b111100010001;
		7'b0000010: color_data = 12'b111100010001;
		7'b0000011: color_data = 12'b111100010001;
		7'b0000100: color_data = 12'b111100010001;
		7'b0000101: color_data = 12'b111100010001;
		7'b0000110: color_data = 12'b111100010001;
		7'b0000111: color_data = 12'b111100010001;
		7'b0001000: color_data = 12'b111100010001;
		7'b0001001: color_data = 12'b111100010001;
		7'b0001010: color_data = 12'b111100010001;
		7'b0001011: color_data = 12'b111100010001;
		7'b0001100: color_data = 12'b111100010001;
		7'b0001101: color_data = 12'b111100010001;
		7'b0001110: color_data = 12'b111100010001;
		7'b0001111: color_data = 12'b111100010001;
		7'b0010000: color_data = 12'b111100010001;
		7'b0010001: color_data = 12'b111100010001;
		7'b0010010: color_data = 12'b111100010001;
		7'b0010011: color_data = 12'b111100010001;
		7'b0010100: color_data = 12'b111100010001;
		7'b0010101: color_data = 12'b111100010001;
		7'b0010110: color_data = 12'b111100010001;
		7'b0010111: color_data = 12'b111100010001;
		7'b0011000: color_data = 12'b111100010001;
		7'b0011001: color_data = 12'b111100010001;
		7'b0011010: color_data = 12'b111100010001;
		7'b0011011: color_data = 12'b111100010001;
		7'b0011100: color_data = 12'b111100010001;
		7'b0011101: color_data = 12'b111100010001;
		7'b0011110: color_data = 12'b111100010001;
		7'b0011111: color_data = 12'b111100010001;
		7'b0100000: color_data = 12'b111100010001;
		7'b0100001: color_data = 12'b111100010001;
		7'b0100010: color_data = 12'b111100010001;
		7'b0100011: color_data = 12'b111100010001;
		7'b0100100: color_data = 12'b111100010001;
		7'b0100101: color_data = 12'b111100010001;
		7'b0100110: color_data = 12'b111100010001;
		7'b0100111: color_data = 12'b111100010001;
		7'b0101000: color_data = 12'b111100010001;
		7'b0101001: color_data = 12'b111100010001;
		7'b0101010: color_data = 12'b111100010001;
		7'b0101011: color_data = 12'b111100010001;
		7'b0101100: color_data = 12'b111100010001;
		7'b0101101: color_data = 12'b111100010001;
		7'b0101110: color_data = 12'b111100010001;
		7'b0101111: color_data = 12'b111100010001;
		7'b1000000: color_data = 12'b111100010001;
		7'b1000001: color_data = 12'b111100010001;
		7'b1000010: color_data = 12'b111100010001;
		7'b1000011: color_data = 12'b111100010001;
		7'b1000100: color_data = 12'b111100010001;
		7'b1000101: color_data = 12'b111100010001;
		7'b1000110: color_data = 12'b111100010001;
		7'b1000111: color_data = 12'b111100010001;
		7'b1001000: color_data = 12'b111100010001;
		7'b1001001: color_data = 12'b111100010001;
		7'b1001010: color_data = 12'b111100010001;
		7'b1001011: color_data = 12'b111100010001;
		7'b1001100: color_data = 12'b111100010001;
		7'b1001101: color_data = 12'b111100010001;
		7'b1001110: color_data = 12'b111100010001;
		7'b1001111: color_data = 12'b111100010001;

		default: color_data = 12'b000000000000;
	endcase
endmodule
