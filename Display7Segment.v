module Display7Segment (
		input					reset,
		input  		[3:0] N_in,
		input					update,
		output reg	[6:0] N_out
	);
	
	always @(posedge update or posedge reset) begin
	
		if (reset) begin
		
			N_out <= 7'b1000000;
			
		end else
		
		case (N_in)
			
			4'b0000: N_out <= 7'b1000000;
			4'b0001: N_out <= 7'b1111001;
			4'b0010: N_out <= 7'b0100100;
			4'b0011: N_out <= 7'b0110000;
			4'b0100: N_out <= 7'b0011001;
			4'b0101: N_out <= 7'b0010010;
			4'b0110: N_out <= 7'b0000010;
			4'b0111: N_out <= 7'b1111000;
			4'b1000: N_out <= 7'b0000000;
			4'b1001: N_out <= 7'b0010000;
			default: N_out <= 7'b1000000;
			
		endcase
		
	end

endmodule 