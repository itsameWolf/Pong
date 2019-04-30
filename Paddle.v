module Paddle#(
	parameter WIDTH = 3,														//width of paddle in pixels
	parameter HEIGTH = 20													//heigth of paddle in pixels
	parameter MAX_H = 320,													//maximum horizontal position of the ball														
	parameter MAX_V = 240,													//maximum vertical position of the ball			
	parameter MIN_H = 0,														//minimum horizontal position of the ball
	parameter MIN_V = 0,														//minimum vertical position of the ball
	parameter START_V = (MAX_V - MIN_V) / 2							//starting vertical position
	)(
	input wire 			reset,
	input wire 			clock,
	input wire 			up,
	input wire 			down,
	output reg [9:0]	paddle_h,
	output reg [8:0]	paddle_v
	);
	
	always @(posedge clock) begin
		
		if (reset) begin
			
			paddle_v <= START_V;
		
		end 
		
		if (up) begin
		
			if ((paddle_v + HEIGTH) < MAX_V) begin
		
				paddle_v <= paddle_v + 1;
			
			end else begin 
			
				paddle_v <= MAX_H - HEIGTH;
				
			end
			
		end else if (down) begin
		
			if ((paddle_v > MIN_V) begin
		
				paddle_v <= paddle_v - 1;
			
			end else begin 
			
				paddle_v <= MIN_H;
				
			end
			
		end
		
	end
	
endmodule
		