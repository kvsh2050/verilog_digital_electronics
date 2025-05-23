module top_module(
    input clk,
    input in,
    input reset,
    output out);
    
 	parameter A = 2'b00, B = 2'b01, C = 2'b11, D = 2'b10; //states
	reg [1:0] state , next_state;
    // State transition logic
	always@(*) begin 
		case(state)
		A: begin
			if(in == 1) next_state =  B;
			else next_state = A;
		end 
		B: begin 
			if(in == 1) next_state = B;
			else next_state = C;
		end 
		C: begin 
			if(in ==1) next_state = D;
			else next_state = A;
		end 
		D: begin 
			if(in == 1) next_state = B;
			else next_state = C;
		end 
		endcase 
	end 
    // State flip-flops with asynchronous reset
	always@(posedge clk) begin 
		if(reset) state <= A;
		else state <= next_state;
	end 
    // Output logic
    	assign out = (state == D) ? 1:0;
	
endmodule

