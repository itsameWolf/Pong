/module Pong #(
	Y_SCREEN = 320,
	X_SCREEN = 240,
	MAX_SCORE = 10,
//	BALL_SPEED,
//	BALL_SIZE,
//	PADDLE_SPEED,
//	PADDLE_SIZE
	)(
	input clock,
	input reset,
	input start,
	input player_1_up,
	input player_1_down,
	input player_2_up,
	input player_2_down,
	);
	
	ClockDivider #(
		CLOCK_IN		(50000000),
		CLOCK_OUT	(4608000)
		) PixelClock (
		clk_in		(clock),
		rst			(reset),
		clk_out		(pixel_clock)
		);
	
	ClockDivider #(
		CLOCK_IN		(50000000),
		CLOCK_OUT	(30)
		) GameClock (
		clk_in		(clock),
		rst			(reset),
		clk_out		(game_clock)
		);
	
	wire pixel_clock, game_clock;
	wire paddle_1_y, paddle_2_y;
	wire ball_x, ball_y;
	
	Paddle Paddle_1 (
		.reset		(reset),
		.clock		(game_clock),
		.up			(player_1_up),
		.down			(player_1_down),
		.paddle_x	(paddle_1_x),
		.paddle_y	(paddle_1_y)
		);
	
	Paddle Paddle_2 (
		.reset		(reset),
		.clock		(game_clock),
		.up			(player_2_up),
		.down			(player_2_down),
		.paddle_x	(paddle_2_x),
		.paddle_y	(paddle_2_y)
		);
	
	Ball Ball (
		.reset		(reset),									
		.clock		(gmae_clock),							
		.paddle_1_y	(paddle1,						
	input	wire	[8:0]	player2_paddle,						
	output reg	[8:0]	ball_y,									
	output reg	[8:0]	ball_h								