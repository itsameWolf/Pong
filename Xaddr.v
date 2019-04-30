module Xaddr#(
	parameter X_MAX = 320
	)(
	input wire			clock,
	input wire 			reset,
	input wire 			enable,
	output reg [9:0] 	x_addr
	);
	
	always @(posedge clock or posedge reset) begin 
		
		if (reset) begin 
			
			x_addr <= 0;
		
		end else if (enable && (x_addr < X_MAX)) begin
		
			x_addr <= x_addr + 1;
			
		end else begin 
		
			x_addr <= 0;
		
		end
	
	end
	
endmodule
