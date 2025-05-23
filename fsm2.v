/*
This is a Moore state machine with two states, two inputs, and one output. Implement this state machine.

This exercise is the same as fsm2s, but using asynchronous reset.

*/

module top_module(
    input clk,
    input areset,    // Asynchronous reset to OFF
    input j,
    input k,
    output out); //  

    parameter OFF=0, ON=1; 
    reg state, next_state;

    always @(*) begin
        // State transition logic
        case(state)
        	OFF: begin 
        		if(j == 0) next_state = OFF;
        		else next_state = ON; 
        	end
        	ON: begin 
        		if(k == 0) next_state = ON;
        		else next_state = OFF;
        	end 
        endcase
    end

    always @(posedge clk, posedge areset) begin
        // State flip-flops with asynchronous reset
        if(areset) state <= OFF;
        else state <= next_state;
    end

    // Output logic
    assign out = (state == ON)? 1: 0;

endmodule

