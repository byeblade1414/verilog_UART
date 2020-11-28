`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:32:10 11/28/2020
// Design Name:   uart_rx
// Module Name:   C:/Users/onur/Desktop/mojo/projects/uart_rx/uart_rx_tb.v
// Project Name:  uart_rx
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: uart_rx
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module uart_rx_tb;

	// Inputs
	reg clk;
	reg reset;
	reg rx;

	// Outputs
	wire [7:0] data;

	// Instantiate the Unit Under Test (UUT)
	uart_rx uut (
		.clk(clk), 
		.reset(reset), 
		.rx(rx), 
		.data(data)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;
		rx = 1;
		#1 reset = 1;
		#5 reset = 0;
		

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
	
	always #5 clk = !clk;
	
	integer time_delay = 70;
	initial begin
	#12 rx = 0; //start
	#time_delay rx = 1; //1
	#time_delay rx = 0; //2
	#time_delay rx = 1; //3
	#time_delay rx = 0; //4
	#time_delay rx = 1; //5
	#time_delay rx = 0; //6
	#time_delay rx = 1; //7
	#time_delay rx = 0; //8
	#time_delay rx = 1; //stop
	end
	
	initial begin
	#800 rx = 0;
	#time_delay rx = 1; //1
	#time_delay rx = 0; //2
	#time_delay rx = 1; //3
	#time_delay rx = 0; //4
	#time_delay rx = 1; //5
	#time_delay rx = 0; //6
	#time_delay rx = 1; //7
	#time_delay rx = 0; //8
	#time_delay rx = 1; //stop
	end
	
	
      
endmodule

