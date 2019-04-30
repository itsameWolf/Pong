module Yaddr#(
	parameter Y_MAX = 240
	)(
	input wire 			reset,
	input wire 			add,
	output reg [8:0] 	y_addr
	);
	
	always @(posedge add or posedge reset) begin 
		
		if (reset) begin 
			
			y_addr <= 0;
		
		end else if (y_addr < Y_MAX) begin
		
			y_addr <= y_addr + 1;
			
		end else begin 
		
			y_addr <= 0;
		
		end
		
	end
	
endmodule
