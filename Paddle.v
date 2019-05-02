module Paddle#(
	parameter WIDTH = 5,														//width of paddle in pixels
	parameter HEIGTH = 40,													//heigth of paddle in pixels
	parameter MAX_Y = 320,													//maximum horizontal position of the ball														
	parameter MAX_X = 240,													//maximum vertical position of the ball			
	parameter MIN_Y = 0,														//minimum horizontal position of the ball
	parameter MIN_X = 0,														//minimum vertical position of the ball
	parameter START_X = (MAX_X - MIN_X) / 2,							//starting vertical position
	parameter POSITION_Y = 30
	)(
	input wire 			reset,
	input wire 			clock,
	input wire 			up,
	input wire 			down,
	output reg [7:0]	paddle_x
	);
	
	always @(posedge clock or posedge reset) begin
		
		if (reset) begin
			
			paddle_x <= START_X;
		
		end else begin
		
			if (up) begin
			
				if ((paddle_x + HEIGTH) < MAX_X) begin
			
					paddle_x <= paddle_x + 1;
				
				end else begin 
				
					paddle_x <= MAX_X - HEIGTH;
					
				end
				
			end else if (down) begin
			
				if (paddle_x > MIN_X) begin
			
					paddle_x <= paddle_x - 1;
				
				end else begin 
				
					paddle_x <= MIN_X;
					
				end
				
			end else begin 
			
				paddle_x <= paddle_x;
				
			end
			
		end
		
	end
	
endmodule
