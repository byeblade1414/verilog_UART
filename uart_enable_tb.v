`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:59:27 11/28/2020
// Design Name:   uart_rx_clock_en
// Module Name:   C:/Users/onur/Desktop/mojo/projects/uart_rx/uart_enable_tb.v
// Project Name:  uart_rx
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: uart_rx_clock_en
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module uart_enable_tb;

	// Inputs
	reg clk;
	reg reset;
	reg count_en;
	reg half_full;

	// Outputs
	wire en;

	// Instantiate the Unit Under Test (UUT)
	uart_rx_clock_en uut (
		.clk(clk), 
		.reset(reset), 
		.count_en(count_en), 
		.half_full(half_full), 
		.en(en)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;
		count_en = 0;
		half_full = 0;
		#2 reset = 1;
		#6 reset = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
	
	always #5 clk = !clk;
	
	initial begin
		#20 count_en = 1;
		#10 half_full = 1;
	end

endmodule

