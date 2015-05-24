`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:39:08 05/17/2015 
// Design Name: 
// Module Name:    DirectionDecoder 
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

`include "directions.vh"

module DirectionDecoder(
	input signed [1:0] xDir,
	input signed [1:0] yDir,
	output reg [2:0] MoveDir
);

always@(xDir or yDir) begin
	if(xDir == -1) begin
		if(yDir == -1)
			MoveDir = `LBackward;
		else if(yDir == 1)
			MoveDir = `LForward;
		else
			MoveDir = `None;
	end
	else if(xDir == 1) begin
		if(yDir == -1)
			MoveDir = `RBackward;
		else if(yDir == 1)
			MoveDir = `RForward;
		else
			MoveDir = `None;
	end else begin
		if(yDir == -1)
			MoveDir = `Backward;
		else if(yDir == 1)
			MoveDir = `Forward;
		else
			MoveDir = `None;
	end
end

endmodule
