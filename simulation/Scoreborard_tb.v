`timescale 1 ns/100 ps

module Scoreboard_tb;
	
	reg				clock;
	reg				start;
	reg 	[7:0] 	binary_in;
	wire	[11:0]	disp_out;

	Scoreboard Scoreboard_dut(
		.binary		(binary_in),
		.clock		(clock),
		.update		(start),
		.score		(disp_out)
	);
	
	localparam NUM_CYCLES = 500;
	localparam CLOCK_FREQ = 50000000;
	
	initial begin

		clock = 1'b0;
		start = 1'b0;
		binary_in = 8'd11; 
	
	end
	
	real HALF_CLOCK_PERIOD = (1000000000.0 / $itor(CLOCK_FREQ)) / 2;
	integer half_cycles = 0;
	
	always begin
		#(HALF_CLOCK_PERIOD)
		if (half_cycles == 10) begin
			start = ~start;
		end
		
		if (half_cycles == 14) begin
			start = ~start;
		end
		
		if (half_cycles == 500) begin
			binary_in = 8'd7;
		end
		
		if (half_cycles == 502) begin
			start = ~start;
		end
		
		if (half_cycles == 504) begin
			start = ~start;
		end
		
		clock = ~clock;
		half_cycles = half_cycles + 1;
		
		if (half_cycles == (2*NUM_CYCLES)) begin
			half_cycles = 0;
			$stop;
		end
	end

endmodule