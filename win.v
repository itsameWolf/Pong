module win (
    input clock,
	 input reset,
	 input p1_scored,
	 input p2_scored,
	 output reg win1,
	 output reg win2,
	 output reg [3:0]	score1,
	 output reg [3:0]	score2,
	 output reg	update_score
	 );
	
	localparam MAX_SCORE = 10;		
	
	always @ (posedge clock) begin
	   if (reset) begin 
		     score1 <= 4'b0;
			  score2 <= 4'b0;
			  win1 <= 0;
			  win2 <= 0;
			  update_score <= 0;
		end else if (p1_scored) begin
		     score1 <= score1 + 1'b1;
			  update_score <= 1;
		 end else if (score1 == MAX_SCORE) begin
		     win1 <= 1;
			  update_score <= 0;
		 end else if (p2_scored) begin
		     score2 <= score2 + 1'b1;
			  update_score <= 1;
		 end else if (score2 == MAX_SCORE) begin
		     win2 <= 1;
			  update_score <= 0;
		 end else 
			update_score <= 0;
	end

endmodule
