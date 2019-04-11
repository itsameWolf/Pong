`timescale 1 ns/100 ps

module Ball_tb;

	reg clock, reset;
	reg [8:0] p1_paddle;
	reg [8:0] p2_paddle;
	wire [8:0] ball_v; 
	wire [8:0] ball_h;
	
	Ball #(
	.MAX_H				(320),
	.MAX_V				(240),
	.MIN_H				(0),
	.MIN_V				(0)
	) Ball_dut (
	.reset				(reset),
	.clock				(clock),
	.player1_paddle		(p1_paddle),
	.player2_paddle		(p2_paddle),
	.ball_h				(ball_h),
	.ball_v				(ball_v)
	);
	
	localparam NUM_CYCLES = 500;
	localparam CLOCK_FREQ = 50000000;
	
	initial begin
	clock = 1'b0;
	reset = 1'b1;
	p1_paddle = 8'd120;
	p2_paddle = 8'd200;
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
		
		if (half_cycles == (2*NUM_CYCLES)) begin
			half_cycles = 0;
			$stop;
		end
	end

endmodule