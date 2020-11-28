`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:32:53 11/24/2020
// Design Name:   uart_clk_en
// Module Name:   C:/Users/onur/Desktop/mojo/projects/uart_tx/uart_clk_en_tb.v
// Project Name:  uart_tx
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: uart_clk_en
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module uart_clk_en_tb;

	// Inputs
	reg clk;
	reg reset;

	// Outputs
	wire en;

	// Instantiate the Unit Under Test (UUT)
	uart_clk_en uut (
		.clk(clk), 
		.reset(reset), 
		.en(en)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;
		#2 reset = 1;
		#6 reset = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
	
	always #5 clk = !clk;

      
endmodule

