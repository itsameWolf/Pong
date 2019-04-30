module Pong #(
	LCD_WIDTH  = 240;
	LCD_HEIGHT = 320;
	MAX_SCORE = 10
//	BALL_SPEED,
//	BALL_SIZE,
//	PADDLE_SPEED,
//	PADDLE_SIZE
	)(
	input wire	clock,
	input wire	reset,
	
	input wire		player_1_up,
	input wire		player_1_down,
	input wire		player_2_up,
	input wire		player_2_down
	
	input wire     globalReset,
   output reg     resetApp,
	
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
		.xAddr       (xAddr      ),
		.yAddr       (yAddr      ),
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

	
	ClockDivider #(
		CLOCK_IN		(50000000),
		CLOCK_OUT	(30)
		) GameClock (
		clk_in		(clock),
		rst			(reset),
		clk_out		(game_clock)
		);
	
	wire 			pixel_clock, game_clock;
	wire [8:0]	paddle_1_y, paddle_2_y;
	wire [8:0]	ball_x, ball_y;
	
	
	Ball Ball (
		.reset		(reset),									
		.clock		(game_clock),							
		.paddle_1_y	(paddle_1_y),						
		.player_2_y	(paddle_2_y),						
		.ball_y		(ball_y),			
		.ball_h		(ball_x)
		);
	
	Paddles Paddles (
		.clock			(game_clock),
		.reset			(reset),
		.key3				(player_2_up),
		.key2,			(player_2_down),
		.key1,			(player_1_up),
		.key0,    		(player_1_down),
		.paddleU_pos	(paddle_2_y),
		.paddleD_pos   (paddle_1_y)
		);
		
	Graphics GameGraphics (
		.ball_x		(ball_x),
		.ball_y		(ball_y),
		.paddle_1_y	(paddle_1_y),
		.paddle_2_y	(paddle_2_y),
		.pixel_x		(),
		.pixel_y		(),
		.pixel_rgb	(pixel_data),