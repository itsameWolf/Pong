`timescale 1 ns/100 ps

module Display7Segment_tb;
	
	reg				clock;
	reg		[3:0] 	binary_in;
	reg 			update;
	wire	[6:0]	out;
	
	Display7Segment #(
		.INVERT_OUTPUT	(0)
	) Display7Segment_dut (
		.N_in			(binary_in),
		.update			(update),
		.N_out			(out)
	);
	
	initial begin

		clock = 1'b0;
		update = 1'b0;
		binary_in = 4'd3; 
	
	end
	
	localparam NUM_CYCLES = 500;
	localparam CLOCK_FREQ = 50000000;
	
	real HALF_CLOCK_PERIOD = (1000000000.0 / $itor(CLOCK_FREQ)) / 2;
	integer half_cycles = 0;
	
	always begin
		#(HALF_CLOCK_PERIOD)
		if (half_cycles == 50) begin
			update = ~update;
		end
		
		if (half_cycles == 52) begin
			update = ~update;
		end
		
		if (half_cycles == 500) begin
			binary_in = 4'd7;
		end
		
		if (half_cycles == 550) begin
			update = ~update;
		end
		
		if (half_cycles == 552) begin
			update = ~update;
		end
		
		clock = ~clock;
		half_cycles = half_cycles + 1;
		
		if (half_cycles == (2*NUM_CYCLES)) begin
			half_cycles = 0;
			$stop;
		end
	end
	
endmodule