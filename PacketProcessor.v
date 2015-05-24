`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:31:45 05/17/2015 
// Design Name: 
// Module Name:    PacketProcessor 
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
module PacketProcessor(
	input Clock,
	input Reset,
	input [23:0] received_bytes,
	output reg [1:0] xDir,
	output reg [1:0] yDir,
	output reg [3:0] additionalData
);

always@(posedge Clock) begin
	if(Reset) begin
		xDir <= 0;
		yDir <= 0;
	end
	else if(received_bytes[23:16] == 8'hFF && received_bytes[7:0] == 8'hFF) begin
		xDir <= received_bytes[9:8];
		yDir <= received_bytes[11:10];
		additionalData <= received_bytes[15:12];
	end
end

endmodule
