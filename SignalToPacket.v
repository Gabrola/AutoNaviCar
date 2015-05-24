`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:26:56 05/17/2015 
// Design Name: 
// Module Name:    SignalToPacket 
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
module SignalToPacket(
	input Clock,
	input Reset,
	input received,
	input [7:0] rx_byte,
	output reg transmit,
	output reg [7:0] tx_byte,
	output reg [23:0] received_bytes
);

always@(posedge Clock) begin
	if(Reset) begin
		received_bytes <= 0;
		transmit <= 0;
	end
	else if(received) begin
		received_bytes <= { received_bytes[15:0], rx_byte };
		transmit <= 1;
		tx_byte <= rx_byte;
	end
	else begin
		transmit <= 0;
	end
end

endmodule
