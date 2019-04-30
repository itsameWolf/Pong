module Ball #(
	parameter SIZE = 4,														//length of ball edge in pixels
	parameter MAX_H = 320,													//maximum horizontal position of the ball														
	parameter MAX_V = 240,													//maximum vertical position of the ball			
	parameter MIN_H = 0,														//minimum horizontal position of the ball
	parameter MIN_V = 0,														//minimum vertical position of the ball
	parameter START_H = (MAX_H - MIN_H) / 2,							//starting horizontal position
	parameter START_V = (MAX_V - MIN_V) / 2							//starting vertical position
	)(
	input wire			reset,									//reset input
	input wire			clock,									//clock input
	input wire	[8:0]	player_1_y,						//vertical position of player 1's paddle
	input	wire	[8:0]	player_2_y,						//vertical position of player 1's paddle
	output reg	[8:0]	ball_y,									//vertical position of the ball
	output reg	[8:0]	ball_x									//vertical position of the ball
	);
	 
	reg direction_h, direction_v;								//flag keeping track of which direction the ball is moving
	
	always @(posedge clock) begin								
	
		if (reset) begin
		
			ball_y = START_V;									//reset the ball to the starting vertical position
			ball_x = START_H;									//reset the ball to the starting horizontal position 
			direction_h = 1;									//move up
			direction_v = 1;									//move right
			
		end 
		
		if (ball_x == MIN_H) begin								//if the ball hits palyer 1's paddle reverse the horizontal movement
		
			if (ball_y == player_1_y) begin				
			
				direction_h = ~direction_h;
				
			end
			
		end else if (ball_x == MAX_H) begin					//if the ball hits palyer 2's paddle reverse the horizontal movement
		
			if (ball_y == player_2_y) begin
			
				direction_h = ~direction_h;
				
			end
			
		end else if (ball_y == MAX_V || ball_y == MIN_V) begin	// if the ball its either one  of the horizontal edges of the screen rverse the vertical movement
				
			direction_v = ~direction_v;
			
		end
		
		if (direction_h == 1) begin
			
			ball_x = ball_x + 1;
			
		end else begin
			
			ball_x = ball_x - 1;
		
		end
		
		if (direction_v == 1) begin
			
			ball_y = ball_y + 1;
			
		end else begin
			
			ball_y = ball_y - 1;
		
		end
			
	end

endmodule
	