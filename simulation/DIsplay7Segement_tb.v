`timescale 1 ns/100 ps

module Display7Segment_tb;
	
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
		binary_in = 7'h0;
		update = 0;
		#10;
		binary_in = 7'h1;
		update = 1;
		#1;
		update = 0;
		#9;
		binary_in = 7'h2;
		#10;
		binary_in = 7'h3;
		update = 1;
		#1;
		update = 0;
		#9;
		binary_in = 7'h4;
		#10;
		binary_in = 7'h5;
		#10;
		binary_in = 7'h6;
		#10;
		binary_in = 7'h7;
		update = 1;
		#1;
		update = 0;
		#9;
		binary_in = 7'h8;
		#10;
		binary_in = 7'h9;
		#10;
	end
	
endmodule