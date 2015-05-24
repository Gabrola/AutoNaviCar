`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   02:25:53 05/18/2015
// Design Name:   AutoNaviCar
// Module Name:   C:/Users/Youssef/Desktop/AutoNaviCar/AutoNaviCar/Test_Car.v
// Project Name:  AutoNaviCar
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: AutoNaviCar
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Test_Car;

	// Inputs
	reg Clock;
	reg Reset;
	reg RXD;
	reg Mode;

	// Outputs
	wire TXD;
	wire [5:0] LED;
	wire [3:0] AN;
	wire [6:0] SEG;
	wire Servo1PWM;
	wire Servo2PWM;
	
	always #10 Clock = !Clock;

	// Instantiate the Unit Under Test (UUT)
	AutoNaviCar uut (
		.Clock(Clock), 
		.Reset(Reset), 
		.RXD(RXD), 
		.Mode(Mode), 
		.TXD(TXD), 
		.LED(LED), 
		.AN(AN), 
		.SEG(SEG), 
		.Servo1PWM(Servo1PWM), 
		.Servo2PWM(Servo2PWM)
	);

	initial begin
		// Initialize Inputs
		Clock = 0;
		Reset = 0;
		RXD = 1;
		Mode = 0;

		// Wait 100 ns for global reset to finish
		#1000;
        
		Mode = 1;
		
		#1000
		
		$finish;

	end
      
endmodule

