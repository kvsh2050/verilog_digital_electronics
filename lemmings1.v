module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right); //  

    parameter WL=0, WR=1;
    reg state, next_state;

    always @(*) begin
        // State transition logic
        case(state) 
        	WL: if(bump_left) next_state = WR;
        	    else next_state = WL;
        	
        	WR: if(bump_right) next_state = WL;
        	    else next_state = WR;
        endcase 
    end

    always @(posedge clk, posedge areset) begin
        // State flip-flops with asynchronous reset
        if(areset) state <= WL;
        else state <= next_state;
    end

    // Output logic
    assign walk_left = (state == WL);
    assign walk_right = (state == WR);

endmodule

