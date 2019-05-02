module Ball #(
	parameter SIZE = 10,														//length of ball edge in pixels
	parameter MAX_Y = 310,													//maximum horizontal position of the ball														
	parameter MAX_X = 239,													//maximum vertical position of the ball			
	parameter MIN_Y = 10,													//minimum horizontal position of the ball
	parameter MIN_X = 0,														//minimum vertical position of the ball
	parameter START_Y = (MAX_Y - MIN_Y) / 2,							//starting horizontal position
	parameter START_X = (MAX_X - MIN_X) / 2							//starting vertical position
	)(
	input wire			reset,												//reset input
	input wire			clock,												//clock input
	input wire	[8:0]	player_1_x,											//vertical position of player 1's paddle
	input	wire	[8:0]	player_2_x,											//vertical position of player 1's paddle
	output reg	[8:0]	ball_y,												//vertical position of the ball
	output reg	[7:0]	ball_x												//vertical position of the ball
	);
	 
	reg direction_y, direction_x;								//flag keeping track of which direction the ball is moving
	
	always @(posedge clock) begin								
	
		if (reset) begin
		
			ball_y = START_Y;									//reset the ball to the starting vertical position
			ball_x = START_X;									//reset the ball to the starting horizontal position 
			direction_y = 1;									//move up
			direction_x = 1;									//move right
			
		end 
		
		if (ball_y == MIN_Y) begin								//if the ball hits palyer 1's paddle reverse the horizontal movement
		
			if (ball_x == player_1_x) begin				
			
				direction_y = ~direction_y;
				
			end
			
		end else if ((ball_y + SIZE) == MAX_Y) begin					//if the ball hits palyer 2's paddle reverse the horizontal movement
		
			if (ball_x == player_2_x) begin
			
				direction_y = ~direction_y;
				
			end
			
		end else if ((ball_x	+ SIZE) == MAX_X || ball_x == MIN_X) begin	// if the ball its either one  of the horizontal edges of the screen rverse the vertical movement
				
			direction_x = ~direction_x;
			
		end
		
		if (direction_x == 1) begin
			
			ball_x = ball_x + 1;
			
		end else begin
			
			ball_x = ball_x - 1;
		
		end
		
		if (direction_y == 1) begin
			
			ball_y = ball_y + 1;
			
		end else begin
			
			ball_y = ball_y - 1;
		
		end
			
	end

endmodule
	