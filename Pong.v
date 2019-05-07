module Pong #(
	LCD_WIDTH  = 240,
	LCD_HEIGHT = 320
	)(
	input wire	clock,
	
	input wire		player_1_up,
	input wire		player_1_down,
	input wire		player_2_up,
	input wire		player_2_down,    //Paddles moving controlled by 4 buttons.
	
	input wire 		pause,    //Game pausing controlled by slide switch1.
	
	input wire     globalReset,    //Resetting the whole project controlled by slide switch0.
        output 		   resetApp,    
	output [13:0] 	display_score1,    //Show one players' scores.
	output [13:0]	display_score2,
	output [8:0]	leds,
	
   // LT24 Interface
   output        LT24Wr_n,
   output        LT24Rd_n,
   output        LT24CS_n,
   output        LT24RS,
   output        LT24Reset_n,
   output [15:0] LT24Data,
   output        LT24LCDOn
	);
	
	//Initialize LT24 display
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

	reg resetGC;    //Reset game clock.

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
		.CLOCK_OUT	(50)
		) GameClock (
		.clk_in		(clock),
		.rst			(resetGC),
		.clk_out		(game_clock)
		);
	
	wire 	        game_clock;
	wire [7:0]	paddle_1_x, paddle_2_x;
	wire [7:0]	ball_x;
	wire [8:0]	ball_y;
	
	wire			pixelReady;
	reg 			pixelWrite;
	wire [15:0]	graphicOut;
	reg  [15:0]	pixelData;
	
	wire [8:0]	y_addr;
	wire [7:0] 	x_addr;
	
	wire p1_scores, p2_scores, p1_wins, p2_wins;
	wire update_score;
	wire [3:0] score1;
	wire [3:0] score2;
	wire [7:0] bcd_score1;
	wire [7:0] bcd_score2;
	
	Ball GameBall (
		.reset		(resetApp),									
		.clock		(game_clock),							
		.player_1_x	(paddle_1_x),						
		.player_2_x	(paddle_2_x),						
		.ball_y		(ball_y),			
		.ball_x		(ball_x),
		.player_1_scored	(p1_scores),
		.player_2_scored	(p2_scores)
		);


	Paddle Paddle1 (
		.reset 		(resetApp),
		.clock		(game_clock),
		.up			(~player_1_up),
		.down			(~player_1_down),
		.paddle_x	(paddle_1_x)
	);

	Paddle#(
		.POSITION_Y (290)
		) Paddle2 (
		.reset 		(resetApp),
		.clock		(game_clock),
		.up			(~player_2_up),
		.down			(~player_2_down),
		.paddle_x	(paddle_2_x)
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
		
	win GameScore(
		.clock		(game_clock),
		.reset		(resetApp),
		.p1_scored	(p1_scores),
		.p2_scored	(p2_scores),
		.win1			(p1_wins),
		.win2			(p2_wins),
		.score1		(score1),
		.score2		(score2),
		.update_score	(update_score)

	);
	
	BinaryToBCD #(
		.INPUT_LENGTH		(4),
		.N_DIGITS			(2)
	)converter1(
		.clock				(clock),
		.start				(update_score),
		.binary				(score1),
		.bcd					(bcd_score1),
		.completed			(conv_comp1)
	);
	
	wire conv_comp1, conv_comp2;
	
	Display7Segment score1digit1 (
		.reset			(resetApp),
		.N_in				(bcd_score1 [3:0]),
		.update			(conv_comp1),
		.N_out			(display_score1 [6:0])
	);
	
	Display7Segment score1digit2 (
		.reset			(resetApp),
		.N_in				(bcd_score1 [7:4]),
		.update			(conv_comp1),
		.N_out			(display_score1 [13:7])
	);
	
	BinaryToBCD #(
		.INPUT_LENGTH		(4),
		.N_DIGITS			(2)
	)converter2(
		.clock				(clock),
		.start				(update_score),
		.binary				(score2),
		.bcd					(bcd_score2),
		.completed			(conv_comp2)
	);
	
	Display7Segment score2digit1 (
		.reset			(resetApp),
		.N_in				(bcd_score2 [3:0]),
		.update			(conv_comp2),
		.N_out			(display_score2 [6:0])
	);
	
	Display7Segment score2digit2 (
		.reset			(resetApp),
		.N_in				(bcd_score2 [7:4]),
		.update			(conv_comp2),
		.N_out			(display_score2 [13:7])
	);
	
	led LightShow(
		.clock		(clock),
		.reset		(resetApp),
		.right		(p1_wins),
		.left			(p2_wins),
		.led			(leds)
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
	
	reg [31:0] counter;
	
	always @(posedge clock) begin 
	
		if (resetApp) begin 
			
			counter <= 32'd0;
			
		end else if (pause) begin    //Stop game clock when pause. 
			
			resetGC <= 1'b1;
		
		end else if ((p1_wins || p2_wins) && (counter < 32'd350000000)) begin    //Wait about 7 seconds when a player wins, then continue to play
			
			counter <= counter + 1;
			resetGC <= 1'b1;
			
		end else begin
			
			resetGC <= 1'b0;
			
		end
		
	end
	
endmodule
