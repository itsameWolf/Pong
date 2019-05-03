module Yaddr#(
	parameter Y_MAX = 9'd320
	)(
	input wire			clock,
	input wire 			reset,
	input wire 			enable,
	output reg [8:0] 	y_addr
	);
	
	always @(posedge clock or posedge reset) begin 
		
		if (reset) begin 
			
			y_addr <= 9'd0;
		
		end else if (enable) begin
			
			if (y_addr >= Y_MAX) begin
				
				y_addr <= 9'd0;
				
			end else begin 
				
				y_addr <= y_addr + 9'd1;
				
			end
			
		end
		
	end
	
endmodule
