module Scoreboard #(
	parameter								INPUT_LENGTH = 8,
	parameter								N_DIGITS = 2
	)( 
	input wire	[INPUT_LENGTH-1:0]	binary,
	input wire								clock,
	input wire								update,
	output wire	[N_DIGITS*7-1:0]		score,
	//output wire	[13:0]					score,
	output wire [(N_DIGITS*4-1):0]	BCD_score,
	output wire 							completed_conversion
	);
	
//	wire [(N_DIGITS*4-1):0]	BCD_score;
//	wire 							completed_conversion;
	
	BinaryToBCD #(
		.INPUT_LENGTH		(INPUT_LENGTH),
		.N_DIGITS			(N_DIGITS)
	) BCDconverter (
		.clock				(clock),
		.start				(update),
		.binary				(binary),
		.bcd					(BCD_score),
		.completed			(completed_conversion)
	);
	
	Display7Segment Digit0(
		.N_in		(BCD_score[3:0]),
		.update	(completed_conversion),
		.N_out	(score[6:0])
	);
	
	Display7Segment Digit1(
		.N_in		(BCD_score[7:4]),
		.update	(completed_conversion),
		.N_out	(score[13:7])
	);

//	genvar i;
//	
//	generate 
//		for (i=0; i<N_DIGITS; i=i+1) begin: Generate7SegmentDisplay
//			
//			Display7Segment Display (
//			.N_in			(BCD_score[(i*4)+:4]),
//			.update		(completed_conversion),
//			.N_out		(score[(i*7)+:7])
//			);
//			
//		end
//		
//	endgenerate
	
endmodule
	