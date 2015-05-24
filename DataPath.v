`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:16:23 05/17/2015 
// Design Name: 
// Module Name:    DataPath 
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
module DataPath(
	input Clock,
	input Clock_100,
	input Reset,
	input RXD,
	input MemWrite,
	input IncMemoryAddress,
	input IncInputCount,
	input ResetMemoryAddress,
	input ResetInputCount,
	output TXD,
	output [5:0] LED,
	output [3:0] AN,
	output [6:0] SEG,
	output Servo1PWM,
	output Servo2PWM,
	output [2:0] InputDirection,
	output [2:0] MemoryDirection,
	output [13:0] InputCount,
	output [13:0] MemoryCount
);

//SSD Input
wire [9:0] ssdBinary;

//UART Inputs and Outputs
wire received;
wire [7:0] rx_byte;
wire transmit;
wire [7:0] tx_byte;

//SignalToPacket Output
wire [23:0] packet;

//PacketProcessor Outputs
wire [1:0] xDir, yDir;

//Memory address
wire [9:0] MemoryAddress;

//Wire assignments
assign ssdBinary = MemoryAddress;

//////////////// MODULES \\\\\\\\\\\\\\\\

SsdCtrl DispCtrl(
		.CLK(Clock),
		.RST(0),
		.DIN(ssdBinary),
		.AN(AN),
		.SEG(SEG)
);

UART wireless(
	.clk(Clock),
	.rst(Reset),
	.rx(RXD),
	.tx(TXD),
	.transmit(transmit),
	.tx_byte(tx_byte),
	.received(received),
	.rx_byte(rx_byte),
	.is_receiving(LED[0]),
	.recv_error(LED[1])
);

SignalToPacket sigPacket(
	.Clock(Clock),
	.Reset(Reset),
	.received(received),
	.rx_byte(rx_byte),
	.transmit(transmit),
	.tx_byte(tx_byte),
	.received_bytes(packet)
);

PacketProcessor procPacket(
	.Clock(Clock_100),
	.Reset(Reset),
	.received_bytes(packet),
	.xDir(xDir),
	.yDir(yDir),
	.additionalData(LED[5:2])
);

DirectionDecoder dirDecode(
	.xDir(xDir),
	.yDir(yDir),
	.MoveDir(InputDirection)
);

ServoDriver driver(
	.Clock(Clock),
	.Reset(Reset),
	.MoveDir(MemoryDirection),
	.Servo1PWM(Servo1PWM),
	.Servo2PWM(Servo2PWM)
);

Counter #(14) controlCounter(
	.Clock(Clock_100),
	.Reset(ResetInputCount),
	.Enable(IncInputCount),
	.Count(InputCount)
);

Counter #(10) memoryCounter(
	.Clock(Clock_100),
	.Reset(ResetMemoryAddress),
	.Enable(IncMemoryAddress),
	.Count(MemoryAddress)
);

reg [2:0] WriteDirection;

always@(posedge Clock_100) begin
	WriteDirection <= InputDirection;
end

RAM memory (
  .clka(Clock),
  .rsta(Reset),
  .wea(MemWrite),
  .addra(MemoryAddress),
  .dina({ WriteDirection, InputCount }),
  .douta({ MemoryDirection, MemoryCount })
);

endmodule
