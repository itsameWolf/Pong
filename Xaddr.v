module Xaddr#(
	parameter X_MAX = 320
	)(
	input wire 			reset,
	input wire 			add,
	output reg [9:0] 	x_addr,
	output reg 			shift
	);
	
	always @(posedge add or posedge reset) begin 
		
		if (reset) begin 
			
			x_addr <= 0;
			shift <= 0;
		
		end else if (x_addr < X_MAX) begin
		
			x_addr <= x_addr + 1;
			shift <= 0;
			
		end else begin 
		
			x_addr <= 0;
			shift <= 1;
		
		end
	
	end
	
endmodule
