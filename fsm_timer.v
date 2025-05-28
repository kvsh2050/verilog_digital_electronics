module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output shift_ena,
    output counting,
    input done_counting,
    output done,
    input ack );
    //register 
    reg [3:0] state, next ; 
    localparam S0 = 0 , S1 = 1, S2 = 2, S3 = 3, S4 = 4, S5 = 5, S6 = 6, S7 = 7, WAIT = 8, DONE = 9;
    //seq
    always @(posedge clk) begin
        if(reset) state <= S0;
        else state <= next;
    end
    //comb 
    always@(*) begin 
        case(state)
            S0 : next = data ? S1 : S0;
            S1 : next = data ? S2 : S0;
            S2 : next = data ? S2 : S3;
            S3 : next = data ? S4 : S0;
            S4 : next = S5;
            S5 : next = S6;
            S6 : next = S7;
            S7 : next = WAIT;
            WAIT : next = (done_counting) ? DONE : WAIT;
            DONE : next = (ack) ? S0 : DONE;
        endcase
    end 
    //output 
    assign shift_ena = (state == S4 |state == S5 | state == S6 | state == S7  );
    assign counting = (state == WAIT);
    assign done = (state == DONE);
endmodule
