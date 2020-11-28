`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:26:30 11/24/2020 
// Design Name: 
// Module Name:    uart_tx 
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
module uart_tx(
    input clk,
    input n_reset,
	 input start_transmission,
	 input [7:0] data,
    output reg tx
    );
	 
	 wire reset;
	 assign reset = !n_reset;
	 
	 parameter idle = 0, start_bit = 1, data_bits = 2, stop_bit = 3;
	 
	 reg [1:0] ps,ns; // 2 state bits. binary encoding.
	 
	
	 reg [2:0] d_bc;
	 reg startb_sent, stopb_sent, data_bits_sent;
	 
	 
	 wire en;
	 uart_clk_en i1(clk,reset,en);
	 
	 
	 always @(posedge clk or posedge reset) begin
		if(reset) begin
			ps <= idle;
		end
		else begin
			ps <= ns;
		end
	 end
	
	 always @(*) begin
		case(ps)
			idle : ns = start_transmission ? start_bit : idle;
			start_bit : ns = startb_sent ? data_bits : start_bit;
			data_bits : ns = data_bits_sent ? stop_bit : data_bits;
			stop_bit : ns = stopb_sent ? idle : stop_bit;
			default : ns = idle;
		endcase
	 end
	 
	 always @(posedge clk or posedge reset) begin
		if(reset) begin
			tx <= 1;
			d_bc <= 0;
			startb_sent <= 0;
			stopb_sent <= 0;
			data_bits_sent <= 0;
		end
		else begin
			if(en) begin
				case(ps)
					idle : begin tx <= 1; data_bits_sent <= 0; stopb_sent <= 0; startb_sent <= 0; end
					start_bit : begin tx <= 0; startb_sent <= 1; end
					data_bits :
						begin 
							tx <= data[d_bc];
							if(d_bc == 7) begin d_bc <= 0; data_bits_sent <= 1; end
							else begin  d_bc <= d_bc + 1; end
 							
						end
					stop_bit : begin tx <= 1; stopb_sent <= 1; end 
				endcase
			end
		end
	end
	 
	 
	



endmodule
