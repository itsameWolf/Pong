module BinaryToBCD #(
	parameter INPUT_LENGTH = 8,
	parameter N_DIGITS = 2
	)(
	input	wire								clock,
	input	wire								start,
	input wire	[INPUT_LENGTH-1:0]	binary,
	output 	 	[N_DIGITS*4-1:0]		bcd,
	output 									completed
	);
	
	//define the states of the FSM
	localparam IDLE 					= 3'b000;
	localparam SHIFT					= 3'b001;
	localparam CHECK_SHIFT_INDEX	= 3'b010;
	localparam ADD						= 3'b011;
	localparam CHECK_DIGIT_INDEX	= 3'b100;
	localparam FINISHED				= 3'b101;
	
	//the default state is IDLE
	reg [2:0] state = IDLE;
	
	//counter to chek how many time the code has been ran
	reg [7:0] loop_counter = 0;
	
	//countet keep track of which digit of the output is been worked on
	reg [3:0] decimal_digit_index = 0;
	
	//buffers between the state machine and the modules inputs and outputs
	reg [INPUT_LENGTH-1:0]	binary_buf;
	reg 	[N_DIGITS*4-1:0]	bcd_buf;
	reg							completed_buf;
	
	always @(posedge clock) begin
		
		case (state)
			//wait for a start signal, the inputs are initialised
			IDLE :
				begin
				
				completed_buf <= 1'b0;
				
				if (start == 1'b1) begin
					
					binary_buf <= binary;
					state <= SHIFT;
					bcd_buf <= 0;
					
					end else begin
					
					state <= IDLE;
					
					end
					
				end
			//bitshift the inputs and outp to the left, move the MSB
			//of the input to the LSB of the output
			SHIFT	:
				begin
				
				bcd_buf <= bcd_buf << 1;
				bcd_buf[0] <= binary_buf[INPUT_LENGTH-1];
				binary_buf <= binary_buf << 1;
				state <= CHECK_SHIFT_INDEX;
				
				end
			//if all the bits of the input have been shifted to the output
			//the conversion is finished
			CHECK_SHIFT_INDEX :
				begin
				
				if (loop_counter == (INPUT_LENGTH-1)) begin
				
					loop_counter <= 0;
					state <= FINISHED;
					
				end else begin
				
					loop_counter <= loop_counter + 1;
					state <= ADD;
					
					end
					
				end
			//for each nibble of the output if it is bigger than 4
			//add 3 to it
			ADD :
				begin
				
				if (bcd_buf[(decimal_digit_index*4)+:4] > 4) begin
					
					bcd_buf[(decimal_digit_index*4)+:4] <= bcd_buf[(decimal_digit_index*4)+:4] + 3;
				
				end
				
				state <= CHECK_DIGIT_INDEX;
				
				end
			//check how many decimal digit have been converted	
			CHECK_DIGIT_INDEX:
				begin
				
				if (decimal_digit_index == N_DIGITS-1) begin
					
					decimal_digit_index <= 0;
					state <= SHIFT;
					
				end else begin
					
					decimal_digit_index <= decimal_digit_index + 1;
					state <= ADD;
					
				end
				
				end
			//send a pulse to signal that the conversion is finished	
			FINISHED :
				begin
				
				completed_buf <= 1'b1;
				state <= IDLE;
				
				end
				
			default:
				state <= IDLE;
				
		endcase

	end
	
	assign bcd = bcd_buf;
	assign completed = completed_buf;


endmodule 