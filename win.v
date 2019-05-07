module win (
    input clock,
	 input reset,
	 input p1_scored,
	 input p2_scored,
	 output reg win1,
	 output reg win2,
	 output reg [3:0]	score1,
	 output reg [3:0]	score2,
	 output reg	update_score    //update_score is used for triggering converting binary numbers to BCD.
	 );
	
	localparam MAX_SCORE = 10;		
	
	always @ (posedge clock) begin
	   if (reset) begin 
		     score1 <= 4'b0;
			  score2 <= 4'b0;
			  win1 <= 0;
			  win2 <= 0;
			  update_score <= 0;
	   end else if (p1_scored) begin    //Add 1 to score1 when player1 scores.
		     score1 <= score1 + 1'b1;
			  update_score <= 1;
	   end else if (score1 == MAX_SCORE) begin    //When player1 scores 10 points, player1 wins. 
		     win1 <= 1;
			  update_score <= 0;    //Stop scoring when a player wins.
		 end else if (p2_scored) begin    //Add 1 to score2 when player2 scores.
		     score2 <= score2 + 1'b1;
			  update_score <= 1;
		 end else if (score2 == MAX_SCORE) begin    
		     win2 <= 1;
			  update_score <= 0;
		 end else 
			update_score <= 0;
	end

endmodule
