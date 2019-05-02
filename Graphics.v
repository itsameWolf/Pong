module Graphics #(
	parameter BACKGROUND_RGB	= 16'b0000000000000000,								//RGB color of the background (black)
	parameter BALL_RGB 			= 16'b0000011111000000,								//RGB color of the ball			(green)
	parameter PADDLE_1_RGB		= 16'b1111100000000000,								//RGB color of the paddle		(red)
	parameter PADDLE_2_RGB		= 16'b0000000000111111,								//RGB color of the paddle		(blue)
	parameter BALL_SIZE			= 10,														//length of ball edge in pixel
	parameter PADDLE_WIDTH 		= 5,														//width of paddle in pixels
	parameter PADDLE_HEIGTH 	= 40,														//heigth of paddle in pixels
	parameter PADDLE_1_Y			= 9'd30,													//heig
	parameter PADDLE_2_Y			= 9'd290
	)(
	input wire			clock,
	input wire			reset,
	input wire [7:0]	ball_x,
	input wire [8:0]	ball_y,
	input wire [7:0]	paddle_1_x,
	input wire [7:0]	paddle_2_x,
	input wire [7:0]	pixel_x,
	input wire [8:0]	pixel_y,
	output reg [15:0]	pixel_rgb
	);
	
	always @(posedge clock or posedge reset) begin 
		
		if (reset) begin
        
		  pixel_rgb <= BACKGROUND_RGB;
    
		end else begin
		
			if (((pixel_x >= paddle_2_x) && (pixel_x <= (paddle_2_x + PADDLE_HEIGTH))) && ((pixel_y >= PADDLE_2_Y) && ((pixel_y <= (PADDLE_2_Y + PADDLE_WIDTH))))) begin
				
				pixel_rgb <= PADDLE_2_RGB;
			
			end else if (((pixel_x >= paddle_1_x) && (pixel_x <= (paddle_1_x + PADDLE_HEIGTH))) && (pixel_y >= PADDLE_1_Y && pixel_y <= (PADDLE_1_Y + PADDLE_WIDTH))) begin
				
				pixel_rgb <= PADDLE_1_RGB;
					
			end else if ((((pixel_y >= ball_y) && (pixel_y <= (ball_y + BALL_SIZE))) && ((pixel_x >= ball_x) && (pixel_x <= (ball_x + BALL_SIZE))))) begin
				
				pixel_rgb <= BALL_RGB;
				
			end else begin
				
				pixel_rgb <= BACKGROUND_RGB;
				
			end
			
		end
		
	end

endmodule	