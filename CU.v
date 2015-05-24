`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:26:36 05/18/2015 
// Design Name: 
// Module Name:    CU 
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

module CU(
	input Clock,
	input Reset,
	input Mode,
	input [13:0] MemoryCount,
	input [13:0] InputCount,
	input [2:0] InputDirection,
	input [2:0] MemoryDirection,
	output MemWrite,
	output IncMemoryAddress,
	output ResetMemoryAddress,
	output IncInputCount,
	output ResetInputCount
);

parameter  RESET_STATE = 0,
			  MEM_WRITE = 1,
			  MEM_READ = 2;
			  
reg [1:0] CurrentState;
reg [1:0] NextState;

always@(CurrentState or Mode) begin
	case (CurrentState)
		RESET_STATE: begin
			if(Mode)
				NextState = MEM_READ;
			else
				NextState = MEM_WRITE;
		end
		
		MEM_WRITE: begin
			if(Mode)
				NextState = RESET_STATE;
			else
				NextState = MEM_WRITE;
		end
		
		MEM_READ: begin
			if(Mode)
				NextState = MEM_READ;
			else
				NextState = RESET_STATE;
		end
		
		default: NextState = RESET_STATE;
	endcase
end

always@(posedge Clock) begin
	if(Reset)
		CurrentState <= RESET_STATE;
	else
		CurrentState <= NextState;
end

assign MemWrite = (CurrentState == MEM_WRITE);
assign ResetMemoryAddress = (CurrentState == RESET_STATE);
assign IncInputCount = (CurrentState != RESET_STATE);
assign IncMemoryAddress = (CurrentState == MEM_WRITE && InputDirection != MemoryDirection) || (CurrentState == MEM_READ && (MemoryCount == InputCount || (MemoryDirection == `None && InputCount >= 100)));
assign ResetInputCount = (CurrentState == RESET_STATE) || IncMemoryAddress;

endmodule
