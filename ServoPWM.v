`timescale 1ns / 1ps
module ServoPWM (
    input Clock,
    input Reset,
    input [7:0] speed1,
    input [7:0] speed2,
    output reg servo1,
    output reg servo2
  );
   
parameter ClkDiv = 195;    // 50000000/1000/256 = 97.56
parameter PulseRange = 4103;	//4103 * 3.9 microseconds = 16 milliseconds

reg [12:0] PulseCount;
reg [7:0] ClkCount;
reg ClkTick;

always @(posedge Clock) begin
	if(Reset)
		PulseCount <= 0;
	else if(ClkTick) begin
		if(PulseCount == PulseRange)
			PulseCount <= 0;
		else
			PulseCount <= PulseCount + 1;
	end
end

always @(posedge Clock) begin
	if(Reset)
		ClkCount <= 0;
	else if(ClkTick)
		ClkCount <= 0;
	else
		ClkCount <= ClkCount + 1;
end

always @(posedge Clock) begin
	if(Reset)
		ClkTick <= 0;
	else
		ClkTick <= (ClkCount == ClkDiv-2);
end

always @(posedge Clock) begin
	servo1 = (PulseCount < {5'b00001, speed1});
	servo2 = (PulseCount < {5'b00001, speed2});
end
   
endmodule
