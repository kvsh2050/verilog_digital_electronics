module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging ); 
    parameter WL = 3'b000 , WR = 3'b010 , LDIG = 3'b011 , LFALL = 3'b100, RDIG = 3'b101, RFALL =3'b110, SPLASH = 3'b111 ; 
    reg [2:0] state, next_state;
    reg [7:0] count = 8'd0;
    reg en = 1'b0;
    //ff
    always@(posedge clk, posedge areset) begin 
        if(areset) state <= WL;
        else begin 
            state <= next_state; 
            if(state == LFALL | RFALL) begin
            	if(count > 8'd20) en <= 1'b1;
            	else count <= count + 1'b1;
            end
        end 
    end 
    //next state logic 
    always@(*) begin 
        case(state)
            	WL:begin 
                    if(bump_left & ~dig & ground) next_state = WR; 
                    else if(~ground) next_state = LFALL;
                    else if (dig & ground ) next_state = LDIG;
                    else next_state = WL;
                end 
                WR: begin 
                    if(bump_right & ~dig & ground) next_state = WL;
                    else if(~ground) next_state = RFALL;
                    else if(ground & dig ) next_state = RDIG;
                    else next_state = WR;
                end 
                LDIG:begin 
                    if(~ground) next_state = LFALL;
                    else next_state = LDIG;
                end 
                RDIG:begin 
                    if(~ground) next_state = RFALL;
                    else next_state = RDIG;
                end 
                LFALL:begin 
                    if(en & ground) next_state = SPLASH;
                    else if(ground) next_state = WL;
                    else next_state = LFALL;
                end 
                RFALL: begin 
                    if(en & ground) next_state = SPLASH;
                    else if(ground) next_state = WR;
                    else next_state = RFALL;
                end 
                SPLASH: begin 
                    next_state = SPLASH;
                end 
        endcase
    end 
    
    //output logic
    assign walk_left = (state == SPLASH)? 1'b0 :(state == WL)? 1'b1: 1'b0;
    assign walk_right = (state == SPLASH)? 1'b0 :(state == WR)? 1'b1: 1'b0;
    assign aaah = (state == SPLASH)? 1'b0: ((state == LFALL) || (state == RFALL))? 1'b1: 1'b0;
    assign digging = (state == SPLASH)? 1'b0: ((state == LDIG) || (state == RDIG)) ? 1'b1 : 1'b0;
    
endmodule

