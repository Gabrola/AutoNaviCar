`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:44:39 05/17/2015 
// Design Name: 
// Module Name:    ServoDriver 
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

module ServoDriver(
	input Clock,
	input Reset,
	input [2:0] MoveDir,
	output Servo1PWM,
	output Servo2PWM
);

reg [7:0] Servo1Speed, Servo2Speed;
wire [2:0] DMoveDir;

debouncer deb(Clock, Reset, MoveDir, DMoveDir);

always@(DMoveDir) begin
	case (DMoveDir)
		`Forward:
			begin
				Servo1Speed = 8'b00000000;
				Servo2Speed = 8'b11111111;
			end
			
		`Backward:
			begin
				Servo1Speed = 8'b11111111;
				Servo2Speed = 8'b00000000;
			end
			
		`LForward:
			begin
				Servo1Speed = 8'b00000000;
				Servo2Speed = 8'b00000000;
			end
			
		`RForward:
			begin
				Servo1Speed = 8'b11111111;
				Servo2Speed = 8'b11111111;
			end
			
		`LBackward:
			begin
				Servo1Speed = 8'b11111111;
				Servo2Speed = 8'b11111111;
			end
			
		`RBackward:
			begin
				Servo1Speed = 8'b00000000;
				Servo2Speed = 8'b00000000;
			end
			
		default:
			begin
				Servo1Speed = 8'b10000000;
				Servo2Speed = 8'b10000000;
			end
	endcase
end

ServoPWM servopwm(
	.Clock(Clock),
	.Reset(Reset),
	.speed1(Servo1Speed),
	.speed2(Servo2Speed),
	.servo1(Servo1PWM),
	.servo2(Servo2PWM)
);

endmodule
