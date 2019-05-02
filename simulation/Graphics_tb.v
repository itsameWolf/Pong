`timescale 1 ns/100 ps

module Graphics_tb;

	reg clock, reset;
	reg	[7:0] pixel_x;
	reg	[8:0] pixel_y;
	reg [7:0] ball_x; 
	reg [8:0] ball_y;
	reg [7:0] p1_paddle;
	reg [7:0] p2_paddle;
	wire [15:0]	pixel_rgb;
	
	Graphics Graphics_dut (
	.clock				(clock),
	.reset				(reset),
	.ball_x				(ball_x),
	.ball_y				(ball_y),
	.paddle_1_y			(p1_paddle),
	.paddle_2_y			(p2_paddle),
	.pixel_x			(pixel_x),
	.pixel_y			(pixel_y),
	.pixel_rgb			(pixel_rgb)
	);
	
	localparam NUM_CYCLES = 100;
	localparam CLOCK_FREQ = 50000000;
	
	initial begin
	clock = 1'b0;
	reset = 1'b1;
	pixel_x = 7'd0;
	pixel_y = 8'd0;
	p1_paddle = 7'd10;
	p2_paddle = 7'd10;
	ball_x = 7'd100;
	ball_y = 8'd100;
	end

	real HALF_CLOCK_PERIOD = (1000000000.0 / $itor(CLOCK_FREQ)) / 2;
	integer half_cycles = 0;
	
	always begin
		#(HALF_CLOCK_PERIOD)
		if (half_cycles == 10) begin
			reset = ~reset;
		end
		clock = ~clock;
		half_cycles = half_cycles + 1;
		
		if (half_cycles == 20) begin 
			pixel_x = 7'd10;
			pixel_y = 8'd10;
		end
		
		if (half_cycles == 30) begin 
			pixel_x = 7'd100;
			pixel_y = 8'd100;
		end
		
		if (half_cycles == 40) begin 
			pixel_x = 7'd10;
			pixel_y = 8'd310;
		end
		
		if (half_cycles == (2*NUM_CYCLES)) begin
			half_cycles = 0;
			$stop;
		end
	end

endmodule