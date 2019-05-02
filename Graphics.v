module Graphics #(
	parameter BACKGROUND_RGB	= 16'b0000000000111111;								//RGB color of the background (blue)
	parameter BALL_RGB 			= 16'b0000011111000000;								//RGB color of the ball			(green)
	parameter PADDLE_RGB			= 16'b1111100000000000,								//RGB color of the paddle		(red)
	parameter BALL_SIZE			= 10,														//length of ball edge in pixel
	parameter PADDLE_WIDTH 		= 3,														//width of paddle in pixels
	parameter PADDLE_HEIGTH 	= 20,														//heigth of paddle in pixels
	parameter PADDLE_1_X			= 9'd10,														//heig
	parameter PADDLE_2_X			= 9'd310,
	parameter MAX_H 				= 320,													//maximum horizontal position of the ball														
	parameter MAX_V 				= 240,													//maximum vertical position of the ball			
	parameter MIN_H 				= 0,														//minimum horizontal position of the ball
	parameter MIN_V 				= 0														//minimum vertical position of the ball
	)(
	input wire			clock,
	input wire			reset,
	input wire [7:0]	ball_x,
	input wire [8:0]	ball_y,
	input wire [7:0]	paddle_1_y,
	input wire [7:0]	paddle_2_y,
	input wire [7:0]	pixel_x,
	input wire [8:0]	pixel_y,
	output reg [15:0]	pixel_rgb
	);
	
	always @(posedge clock or posedge reset) begin 
		
		if (reset) begin
        
		  pixel_rgb <= BACKGROUND_RGB;
    
		end else begin
		
			if ((pixel_y >= paddle_2_y) && (pixel_y <= (paddle_2_y + PADDLE_HEIGTH))) begin
						
				if ((pixel_x >= PADDLE_2_X) && ((pixel_x <= (PADDLE_2_X + PADDLE_WIDTH)))) begin
					
					pixel_rgb <= PADDLE_RGB;
					
				end else begin
				
					pixel_rgb <= BACKGROUND_RGB;
					
				end
				
			end
		
			if ((pixel_y >= paddle_1_y) && (pixel_y <= (paddle_1_y + PADDLE_HEIGTH))) begin
					
				if (pixel_x >= PADDLE_1_X && pixel_x <= (PADDLE_1_X + PADDLE_WIDTH)) begin
				
					pixel_rgb <= PADDLE_RGB;
					
				end else begin
				
					pixel_rgb <= BACKGROUND_RGB;
					
				end	
				
			end
		
			if ((pixel_y >= ball_y) && (pixel_y <= (ball_y + BALL_SIZE))) begin
				
				if ((pixel_x >= ball_x) && (pixel_x <= (ball_x + BALL_SIZE))) begin
					
					pixel_rgb <= BALL_RGB;
					
				end else begin
				
					pixel_rgb <= BACKGROUND_RGB;
					
				end
				
			end
			
		end
		
	end

endmodule	