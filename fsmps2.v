module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output done); //
	//assume for every clock cycle it sends data
	parameter CHECKER = 3'd0, RECV_BYTE1 = 3'd1, LAST_BYTE = 3'd2, DONE = 3'd3;
	reg [2:0] state , next_state ;
	 
    // State transition logic (combinational)
    	//reg [7:0] byte_2, byte_3;
	always@(*)begin 
		case(state)
			CHECKER: begin 
				if(in[3] == 1) next_state = RECV_BYTE1; //byte 1
				else next_state = CHECKER;
			end 
			RECV_BYTE1:begin
				//byte_2 = in ;
				next_state = LAST_BYTE;
			end 
			LAST_BYTE: begin 
				//byte_3 = in ;
				next_state = DONE;
			end 
			DONE: begin 
				if(in[3] == 1)
					next_state = RECV_BYTE1;
				else next_state = CHECKER;
			end 
		endcase
	end 
    // State flip-flops (sequential)	
 	always@(posedge clk) begin 
 		if(reset) begin 
 			state <= CHECKER ;
 		end 
 		else begin 
 			state <= next_state;
 		end 
 	end 
    // Output logic
	assign done  = (state == DONE);
endmodule

