module Paddles #(

    parameter paddle_width = 9'd5,    //Width of paddles
    parameter paddle_length = 9'd40,    //Length of paddles
	 parameter paddleU_ini=9'd100,
	 parameter paddleD_ini=9'd100     //Starting position (middle)
	 ) (
	 input clock,
	 input reset,
	 input key3,
	 input key2,
	 input key1,
	 input key0,    //4 bottons for controlling paddles moving up and down
	 output wire [7:0] paddleU_pos,    //Upper paddle
	 output wire [7:0] paddleD_pos    //Lower paddle
	 );
	
   reg [7:0]	paddleU_ls;    //Upper paddle left side
	reg [7:0]	paddleU_rs;    //Upper paddle right side
	reg [7:0]	paddleD_ls;    //Lower paddle left side
	reg [7:0]	paddleD_rs;    //Lower paddle right side
	
	 //Paddles position
	 assign paddleU_pos = paddleU_ls + (paddle_length/ 8'd2 - 8'd1);
	 assign paddleD_pos = paddleD_ls + (paddle_length/ 8'd2 - 8'd1);
	
	 always @ (posedge clock) begin
	 
      if (reset) begin    //Put paddles in the middle when reset
		  
		   paddleU_ls=paddleU_ini;
	      paddleD_ls=paddleD_ini;
			
	   end 
		  
		if (key3 && paddleU_ls>=8'd0) begin     //Move upper paddle left with botton3 when the paddle doesn't reach the boundry
		  
            paddleU_ls=paddleU_ls-8'd1;
				paddleU_rs=paddleU_rs-8'd1;
			
      end 
		  
		if (key2 && paddleU_rs<=8'd239) begin   //Move upper paddle right with botton2 when the paddle doesn't reach the boundry   
		
			paddleU_ls=paddleU_ls+8'd1;
			paddleU_rs=paddleU_rs+8'd1;
			
	   end 
		
		if (key1 && paddleD_ls>=8'd0) begin     //Move lower paddle left with botton1 when the paddle doesn't reach the boundry
		
         paddleD_ls=paddleD_ls-8'd1;
			paddleD_rs=paddleD_rs-8'd1;
			
	   end
		
		if (key0 && paddleD_rs<=8'd239) begin   //Move lower paddle right with botton1 when the paddle doesn't reach the boundry   
		  
         paddleD_ls=paddleD_ls+8'd1;
			paddleD_rs=paddleD_rs+8'd1;	
			
	     end
	 end

endmodule	  