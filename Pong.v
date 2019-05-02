module Pong #(
	LCD_WIDTH  = 240;
	LCD_HEIGHT = 320;
	MAX_SCORE = 10
	)(
	input wire	clock,
	
	input wire		player_1_up,
	input wire		player_1_down,
	input wire		player_2_up,
	input wire		player_2_down,
	
	input wire     globalReset,
   output 		   resetApp,
	
   // LT24 Interface
   output        LT24Wr_n,
   output        LT24Rd_n,
   output        LT24CS_n,
   output        LT24RS,
   output        LT24Reset_n,
   output [15:0] LT24Data,
   output        LT24LCDOn
	);
	
	LT24Display #(
		.WIDTH       (LCD_WIDTH  ),
		.HEIGHT      (LCD_HEIGHT ),
		.CLOCK_FREQ  (50000000   )
		) Display (
		.clock       (clock      ),
		.globalReset (globalReset),
		.resetApp    (resetApp   ),
		.xAddr       (x_addr      ),
		.yAddr       (y_addr      ),
		.pixelData   (pixelData  ),
		.pixelWrite  (pixelWrite ),
		.pixelReady  (pixelReady ),
		.pixelRawMode(1'b0       ),
		.cmdData     (8'b0       ),
		.cmdWrite    (1'b0       ),
		.cmdDone     (1'b0       ),
		.cmdReady    (           ),
		.LT24Wr_n    (LT24Wr_n   ),
		.LT24Rd_n    (LT24Rd_n   ),
		.LT24CS_n    (LT24CS_n   ),
		.LT24RS      (LT24RS     ),
		.LT24Reset_n (LT24Reset_n),
		.LT24Data    (LT24Data   ),
		.LT24LCDOn   (LT24LCDOn  )
		);

	Xaddr GameXaddr ( 
		.clock	(clock),
		.reset	(resetApp),
		.enable	(pixelReady),
		.x_addr	(x_addr)
		);
	
	wire YaddrEN = pixelReady && (x_addr == (LCD_WIDTH-1));
	
	Yaddr GameYaddr (
		.clock	(clock),
		.reset	(resetApp),
		.enable	(YaddrEN),
		.y_addr	(y_addr)
		);
	
	ClockDivider #(
		.CLOCK_IN	(50000000),
		.CLOCK_OUT	(30)
		) GameClock (
		.clk_in		(clock),
		.rst			(resetApp),
		.clk_out		(game_clock)
		);
	
	wire 			game_clock;
	wire [7:0]	paddle_1_x, paddle_2_x;
	wire [7:0]	ball_x;
	wire [8:0]	ball_y;
	
	wire			pixelReady;
	reg 			pixelWrite;
	wire [15:0]	graphicOut;
	reg  [15:0]	pixelData;
	
	wire [8:0]	y_addr;
	wire [7:0] 	x_addr;
	
	Ball GameBall (
		.reset		(resetApp),									
		.clock		(game_clock),							
		.player_1_x	(paddle_1_y),						
		.player_2_x	(paddle_2_y),						
		.ball_y		(ball_y),			
		.ball_x		(ball_x)
		);
	
	Paddles GamePaddles (
		.clock			(game_clock),
		.reset 			(resetApp),
		.key3				(player_2_up),
		.key2				(player_2_down),
		.key1				(player_1_up),
		.key0				(player_1_down),
		.paddleU_pos	(paddle_2_x),
		.paddleD_pos	(paddle_1_x)
		);
		
	Graphics GameGraphics (
		.clock		(clock),
		.reset		(resetApp),
		.ball_x		(ball_x),
		.ball_y		(ball_y),
		.paddle_1_x	(paddle_1_x),
		.paddle_2_x	(paddle_2_x),
		.pixel_x		(x_addr),
		.pixel_y		(y_addr),
		.pixel_rgb	(graphicOut)
		);

	always @ (posedge clock or posedge resetApp) begin
	
		if (resetApp) begin
		
        pixelWrite <= 1'b0;
		  
		end else begin
		  
        pixelWrite <= 1'b1;
			
		end
		
	end
	
	always @ (posedge clock or posedge resetApp) begin
		if (resetApp) begin
		
			pixelData <= 16'b0;
			
		end else if (pixelReady) begin
			
			pixelData <= graphicOut;
			
		end
	end
	
endmodule
