`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:54:20 05/17/2015 
// Design Name: 
// Module Name:    AutoNaviCar 
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
module AutoNaviCar(
	input Clock,
	input Reset,
	input RXD,
	input Mode,
	output TXD,
	output [5:0] LED,
	output [3:0] AN,
	output [6:0] SEG,
	output Servo1PWM,
	output Servo2PWM
);

//DataPath Outputs
wire [2:0] InputDirection, MemoryDirection;
wire [13:0] InputCount, MemoryCount;

//Control signals
wire MemWrite, IncMemoryAddress, IncInputCount, ResetMemoryAddress, ResetInputCount;

wire clk_100hz;
clock_divider #(500000) clk100(
	.Clk_In(Clock),
	.Reset(0),
	.Clk_Out(clk_100hz)
);

CU controlUnit(
	.Clock(clk_100hz),
	.Reset(Reset),
	.Mode(Mode),
	.MemoryCount(MemoryCount),
	.InputCount(InputCount),
	.InputDirection(InputDirection),
	.MemoryDirection(MemoryDirection),
	.MemWrite(MemWrite),
	.IncMemoryAddress(IncMemoryAddress),
	.ResetMemoryAddress(ResetMemoryAddress),
	.IncInputCount(IncInputCount),
	.ResetInputCount(ResetInputCount)
);

DataPath dataPath(
	.Clock(Clock),
	.Clock_100(clk_100hz),
	.Reset(Reset),
	.RXD(RXD),
	.TXD(TXD),
	.LED(LED),
	.AN(AN),
	.SEG(SEG),
	.Servo1PWM(Servo1PWM),
	.Servo2PWM(Servo2PWM),
	.MemWrite(MemWrite),
	.IncMemoryAddress(IncMemoryAddress),
	.IncInputCount(IncInputCount),
	.InputDirection(InputDirection),
	.MemoryDirection(MemoryDirection),
	.InputCount(InputCount),
	.MemoryCount(MemoryCount),
	.ResetMemoryAddress(ResetMemoryAddress),
	.ResetInputCount(ResetInputCount)
);

endmodule
