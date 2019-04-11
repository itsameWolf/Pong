module ClockDivider #(
	parameter CLOCK_IN = 50000000,								//Frequency in Hertz of the input clock
	parameter CLOCK_OUT = 128000,									//Frequency in Hertz of the output clock
	parameter HALF_CLOCK_RATIO = (CLOCK_IN/CLOCK_OUT)/2	//This is the number of ticks the counter will need increment to before toggling the output, it the ratio between input and output frequency divided by 2
	)(
	input 		clk_in,												//Clock input that will be divided
	input			rst,													//Active high reset signal that restore the circuit to it's initial state, it is required for proper module initialisation
	output reg	clk_out												//Output clock reduced to the desired frequency
);

	reg [23:0]	count;												//Register that gets incremented on every positive clock edge, the maximum value is 16777216, this allows  
		
	always @(posedge clk_in or posedge rst) begin			//Execute the following code on every clock or reset positive edge
		 if(rst) begin
			count <=	24'd0;											//If reset is high reset the counter to 0 and the output to high
			clk_out <= 1'b1;
		 end else begin
			if (count == (HALF_CLOCK_RATIO)-1) begin
				count <=	24'd0;										//Flip the output when the counter output reaches the required value
				clk_out <= ~clk_out;
			end else begin
				count <= count + 1'b1;								//Increment the counter
			end
		end
	end
	
endmodule
