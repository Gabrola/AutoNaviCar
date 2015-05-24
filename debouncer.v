`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    05:14:46 05/19/2015 
// Design Name: 
// Module Name:    debouncer 
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
module debouncer(
    input Clock,
    input Reset,
    input [2:0] In,
    output [2:0] Out
);

integer i;
reg [4:0] register [0:2];

always@(posedge Clock) begin
	if(Reset) begin
		for (i = 0; i < 3; i = i + 1) register[i] <= 5'd0;
	end
	else begin
		for (i = 0; i < 3; i = i + 1) register[i] <= { register[i][3:0], In[i] };
	end
end

assign Out[0] = register[0] && 5'b11111 == 5'b11111;
assign Out[1] = register[1] && 5'b11111 == 5'b11111;
assign Out[2] = register[2] && 5'b11111 == 5'b11111;

endmodule
