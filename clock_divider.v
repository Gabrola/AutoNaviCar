`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:32:00 05/17/2015 
// Design Name: 
// Module Name:    clock_divider 
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
module clock_divider(
    input Clk_In,
	 input Reset,
    output reg Clk_Out
);

	parameter divide = 2;
	
	localparam modulo = divide / 2;
	
	reg [31:0] counter;
	
	always@ (posedge Clk_In) begin
		if (Reset == 1) begin
			counter <= 32'b0;
			Clk_Out <= 1'b0;
		end
		else if (counter >= modulo - 1) begin
			counter <= 32'b0;
			Clk_Out <= ~Clk_Out;
		end
		else begin
			counter <= counter + 1;
			Clk_Out <= Clk_Out;
		end
	end
endmodule
