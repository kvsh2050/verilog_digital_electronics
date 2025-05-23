/*
This is a Moore state machine with two states, one input, and one output. Implement this state machine. Notice that the reset state is B.

This exercise is the same as fsm1, but using synchronous reset. 
*/
// Note the Verilog-1995 module declaration syntax here:



module top_module(clk, reset, in, out);
    input clk;
    input reset;    // Synchronous reset to state B
    input in;
    output reg out;

    parameter A = 0, B = 1;
    reg present_state, next_state;
    
    always @(*) begin    // This is a combinational always block
        // State transition logic
        case(present_state)
        	A: begin  
			if(in == 1'b1) next_state = A;
			else next_state = B;
        	end  
        	B: begin 
			if(in == 1'b1) next_state = B;
			else next_state = A; 
        	end 
        endcase
    end

    always @(posedge clk) begin    // This is a sequential always block
        // State flip-flops with asynchronous reset
        if(reset) present_state <= B;
        else present_state <= next_state;
    end

    // Output logic
    assign out = (present_state == B)? 1:0;

endmodule

