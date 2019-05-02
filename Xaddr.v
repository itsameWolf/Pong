module Xaddr#(
	parameter X_MAX = 240
	)(
	input wire			clock,
	input wire 			reset,
	input wire 			enable,
	output reg [7:0] 	x_addr
	);
	
	always @(posedge clock or posedge reset) begin 
		
		if (reset) begin 
			
			x_addr <= 0;
		
		end else if (enable) begin
		
			if (x_addr >= X_MAX) begin
		
				x_addr <= 8'd0;
			
			end else begin 
		
			x_addr <= x_addr + 9'd1;
		
			end
			
		end
	
	end
	
endmodule
