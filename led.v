module led (
    input clock,
	 input reset,
	 input right,
	 input left,
	output wire [9:1] led    //9 leds blink when a player wins.
	 );
	 
	reg [24:0] counter = 25'b0;    //Divide frequency to 50MHz/2^25=1.49 Hz.
	 reg enable;
	 reg [9:1] led_loop;
	 wire enable_loop;
	 
	 assign enable_loop = enable;
	 assign led = led_loop;
	 
	 always @ (posedge clock) begin
	     if (reset) begin
		      counter <= 25'b0;
		  end else begin
		      counter <= counter+1'b1;    //Add one to counter at every posedge of system clock.
		  end
	 end 
	 
	 always @ (posedge clock) begin
	     if (reset) begin
		      enable <= 1'b0;
	     end else if (counter==25'hffffff) begin    //When the counter is full, produce a enable signal to light up leds.
		      enable <= 1'b1;
		  end else begin
		      enable <= 1'b0;
		  end 
	 end 
	 
	 always @ (posedge clock) begin
	     if (reset) begin
		      led_loop <= 9'b100000000;    //Initially light up led9.
		  end else if(enable_loop && left) begin
			  led_loop <= {led_loop[1], led_loop[9:2]};    //Leds light up from left to right in turn.
		  end else if(enable_loop && right) begin
			  led_loop <= {led_loop[8:1], led_loop[9]};    //Leds light up from right to left in turn.
		  end
	 end

endmodule
