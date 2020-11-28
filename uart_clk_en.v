`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:29:25 11/24/2020 
// Design Name: 
// Module Name:    uart_clk_en 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module uart_clk_en(
    input clk,
    input reset,
    output reg en
    );
	 
	 
	 reg [12:0] counter;
	 
	 
	 always @(posedge clk or posedge reset) begin
		if(reset) begin
			counter <= 0;
			en <= 0;
		end 
		else begin
			en <= 0;
			counter <= counter + 1;
			if(counter == 5300) begin
				counter <= 0;
				en <= 1;
			end
		end
	 end


endmodule
