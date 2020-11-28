`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:16:57 11/27/2020 
// Design Name: 
// Module Name:    uart_rx 
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
module uart_rx(
    input clk,
    input n_reset,
    input rx,
    output reg [7:0] data
    );
	
	wire reset;
	assign reset = !n_reset;
	
	parameter idle = 0, receive = 1, stop = 2;
	
	reg [7:0] data_buffer;
	
	reg [1:0] ps,ns;
	
	reg startb_sent;
	reg db_sent;
	reg done;
	
	reg st_tr_rec;
	reg half_full;
	reg count_en;
	reg [2:0] recb_counter;
	
	wire en;
	
	uart_rx_clock_en i1(clk,reset,count_en,half_full,en);
	
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
			idle : ns = startb_sent ? receive : idle;
			receive : ns = db_sent ? stop : receive;
			stop : ns = done ? idle : stop;
			default : ns = idle;
		endcase
	end
	
	always @(posedge clk or posedge reset) begin
		if(reset) begin
			startb_sent <= 0;
			done <= 0;
			st_tr_rec <= 0;
			count_en <= 0;
			db_sent <= 0;
			recb_counter <= 0;
			data_buffer[7:0] <= 8'b00000000;
		end
		else begin
			if(ps == idle & rx == 0 & st_tr_rec == 0) begin // start transition has been received flag is set
				st_tr_rec <= 1;
				count_en <= 1;
				half_full <= 0; // half count.
			end
			else begin
				done <= (ps == idle) ? 0 : done;
				if(en) begin
					case(ps)
						idle :begin
									//count_en <= 0;
									//done <= 0;
									if(st_tr_rec == 1 & rx == 0) begin startb_sent <= 1; half_full <= 1; end // if rx is still zero, start bit has been received.
									else begin st_tr_rec <= 0; count_en <= 0; end // if it is not still zero, start bit has not been received.
								end
						receive : begin
										data_buffer[recb_counter] <= rx;
										st_tr_rec <= 0;
										recb_counter <= recb_counter + 1;
										if(recb_counter == 7) begin db_sent <= 1; recb_counter <= 0; end
									 end
						stop : begin
									if(rx == 1) begin done <= 1; startb_sent <= 0; db_sent <= 0; count_en <= 0; end
									else begin data_buffer[7:0] <= 8'b00000000; done <= 1; count_en <= 0; end
								 end
					endcase
				end
			end
		end
	end
									
	
	always @(posedge clk or posedge reset) begin
		if(reset) begin
			data <= 0;
		end
		else begin
			data <= done ? data_buffer : data;
		end
	end

	 


endmodule
