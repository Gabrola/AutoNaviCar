`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:17:12 05/18/2015 
// Design Name: 
// Module Name:    Counter 
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
module Counter(
	Clock,
	Reset,
	Enable,
	Count 
);

parameter bits = 14;

input Clock;
input Reset;
input Enable;
output reg [bits - 1:0] Count ;

always @(posedge Clock) begin
	if(Reset) begin
		Count <= 0;
	end
	else if(Enable) begin
		Count <= Count + 1;
	end
end

endmodule
