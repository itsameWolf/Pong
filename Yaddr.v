module Yaddr#(
	parameter Y_MAX = 240
	)(
	input wire			clock,
	input wire 			reset,
	input wire 			enable,
	output reg [8:0] 	y_addr
	);
	
	always @(posedge clock or posedge reset) begin 
		
		if (reset) begin 
			
			y_addr <= 0;
		
		end else if (enable && (y_addr < Y_MAX)) begin
		
			y_addr <= y_addr + 1;
			
		end else begin 
		
			y_addr <= 0;
		
		end
		
	end
	
endmodule
