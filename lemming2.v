/*In addition to walking left and right, Lemmings will fall (and presumably go "aaah~") if the ground disappears underneath them.

In addition to walking left and right and changing direction when bumped, when ground=0, the Lemming will fall and say "aaah!". When the ground reappears (ground=1), the Lemming will resume walking in the same direction as before the fall. Being bumped while falling does not affect the walking direction, and being bumped in the same cycle as ground disappears (but not yet falling), or when the ground reappears while still falling, also does not affect the walking direction.

Build a finite state machine that models this behaviour. 
*/
module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah ); 
    	parameter WL = 2'b00, WR = 2'b01, LFALL = 2'b11, RFALL = 2'b10;
    	reg [1:0] state , next_state;
    	//next state logic - replace the wl and wr :\ when u walk left and u bump left u walk right
    	always@(*) begin 
    		case(state) 
    			WL: begin 
    			    if(bump_left & ground ) next_state = WR;
    				else if(~ground & ~bump_left) next_state = LFALL;
    				else if(~ground & bump_left) next_state = LFALL;
    				else next_state = WL;
    			end 
    			WR:begin 
			        if(bump_right & ground) next_state = WL;
    				else if(~ground & ~bump_right) next_state = RFALL;
    				else if(~ground & bump_right) next_state = RFALL;
    				else next_state = WR;
    			end 
    			LFALL:begin 
    				if(~ground) next_state = LFALL;
    				else next_state = WL;
    			end 
    			RFALL:begin 
    				if(~ground) next_state = RFALL;
    				else next_state = WR;
    			end 
    		endcase 
    	end 
    	//always seq
    	always@(posedge clk, posedge areset) begin
    		if(areset) state <= WL;
    		else begin
    			state <= next_state;
    		end 
    	end 
    	//output logic
	assign walk_left = ( state == WL ) ? 1'b1 : 1'b0;
	assign walk_right = ( state == WR) ? 1'b1 : 1'b0;
	assign aaah = (state == LFALL | state == RFALL) ? 1'b1 : 1'b0;
endmodule

