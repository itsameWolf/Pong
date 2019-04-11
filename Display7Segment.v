module Display7Segment #(
	parameter INVERT_OUTPUT = 1
)(
	input  		[3:0] N_in,
	input					update,
	output reg	[6:0] N_out
);

always @(posedge update) begin
case (N_in)
	4'b0000: N_out <= 7'b0111111;
	4'b0001: N_out <= 7'b0000110;
	4'b0010: N_out <= 7'b1011011;
	4'b0011: N_out <= 7'b1001111;
	4'b0100: N_out <= 7'b1100110;
	4'b0101: N_out <= 7'b1101101;
	4'b0110: N_out <= 7'b1111101;
	4'b0111: N_out <= 7'b0000111;
	4'b1000: N_out <= 7'b1111111;
	4'b1001: N_out <= 7'b1101111;
	default: N_out <= 7'b0111111;
endcase
if (INVERT_OUTPUT) begin
	N_out <= ~N_out;
	end
end

endmodule 