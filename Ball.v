module Ball #(
	parameter SIZE = 10,														//length of ball edge in pixels
	parameter MAX_Y = 290,													//maximum horizontal position of the ball														
	parameter MAX_X = 239,													//maximum vertical position of the ball			
	parameter MIN_Y = 30,													//minimum horizontal position of the ball
	parameter MIN_X = 0,														//minimum vertical position of the ball
	parameter START_Y = 160,							//starting horizontal position
	parameter START_X = 120,							//starting vertical position
	parameter PADDLE_WIDTH = 5;
	parameter PADDLE_HEIGHT = 40
	)(
	input wire			reset,												//reset input
	input wire			clock,												//clock input
	input wire	[7:0]	player_1_x,											//vertical position of player 1's paddle
	input	wire	[7:0]	player_2_x,											//vertical position of player 1's paddle
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
			
		end else begin
		
			if ((ball_y == MIN_Y + PADDLE_WIDTH) && ((ball_x - SIZE >= player_1_x) && (ball_x <= (player_1_x + PADDLE_HEIGHT)))) begin				
				
				direction_y = ~direction_y;
				
			end else if (((ball_y + SIZE) == MAX_Y) && ((ball_x >= player_2_x) && ((ball_x + SIZE) <= (player_2_x + PADDLE_HEIGHT)))) begin
				
				direction_y = ~direction_y;
				
			end else if ((ball_x	+ SIZE) == MAX_X || ball_x == MIN_X) begin	// if the ball its either one  of the horizontal edges of the screen rverse the vertical movement
					
				direction_x= ~direction_x;
				
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
				
			end else begin
			
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
			
		end
		
	end

endmodule
	