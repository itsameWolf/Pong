module Graphics #(
	parameter BACKGROUND_RGB	= 16'b0000000000000000,	//RGB color of the background (black)
	parameter BALL_RGB 			= 16'b0000011111000000,	//RGB color of the ball			(green)
	parameter PADDLE_1_RGB		= 16'b1111100000000000,	//RGB color of the paddle		(red)
	parameter PADDLE_2_RGB		= 16'b0000000000111111,	//RGB color of the paddle		(blue)
	parameter BALL_SIZE			= 10,					//length of ball edge in pixel
	parameter PADDLE_WIDTH 		= 5,					//width of paddle in pixels
	parameter PADDLE_HEIGTH 	= 40,					//heigth of paddle in pixels
	parameter PADDLE_1_Y		= 9'd30,				//horizontal position of paddle 1 on the screen
	parameter PADDLE_2_Y		= 9'd290				//horizontal position of paddle 2 on the screen
	)(
	input wire			clock,		//Input clock
	input wire			reset,		//module reset
	input wire [7:0]	ball_x,		//x coordinate of the ball
	input wire [8:0]	ball_y,		//y coordinate of the ball
	input wire [7:0]	paddle_1_x,	//x coordinate of the paddle 1
	input wire [7:0]	paddle_2_x,	//x coordinate of the paddle 2
	input wire [7:0]	pixel_x,	//x coordinate of the current pixel
	input wire [8:0]	pixel_y,	//y coordinate of the current pixel
	output reg [15:0]	pixel_rgb	//output RGB color to be fed to the display
	);
	
	always @(posedge clock or posedge reset) begin 
		
		if (reset) begin
        
		  pixel_rgb <= BACKGROUND_RGB;
    
		end else begin
			//check if the current pixel address is inside of player's 2 paddle boundaries
			if (((pixel_x >= paddle_2_x) && (pixel_x <= (paddle_2_x + PADDLE_HEIGTH))) && ((pixel_y >= PADDLE_2_Y) && ((pixel_y <= (PADDLE_2_Y + PADDLE_WIDTH))))) begin
				
				pixel_rgb <= PADDLE_2_RGB;
			//check if the current pixel address is inside of player's 1 paddle boundaries
			end else if (((pixel_x >= paddle_1_x) && (pixel_x <= (paddle_1_x + PADDLE_HEIGTH))) && (pixel_y >= PADDLE_1_Y && pixel_y <= (PADDLE_1_Y + PADDLE_WIDTH))) begin
				
				pixel_rgb <= PADDLE_1_RGB;
			//check if the current pixel address is inside o the ball's boundaries		
			end else if ((((pixel_y >= ball_y) && (pixel_y <= (ball_y + BALL_SIZE))) && ((pixel_x >= ball_x) && (pixel_x <= (ball_x + BALL_SIZE))))) begin
				
				pixel_rgb <= BALL_RGB;
			//if none of the conditions above are satisfied set the outptu color to background	
			end else begin
				
				pixel_rgb <= BACKGROUND_RGB;
				
			end
			
		end
		
	end

endmodule	