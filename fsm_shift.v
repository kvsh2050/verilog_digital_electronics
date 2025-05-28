module top_module (
    input clk,
    input reset,      // Synchronous reset
    output shift_ena);
    //fsm asserts the shift exactly after 4 cycles after seq is detected 
    //this must be fsm
    //reg 
    reg [3:0] state, next;
    localparam A = 0, B = 1, C = 2, D = 3, E = 4 ;
    always@(posedge clk) begin
        state <= next;
    end
    always@(*) begin 
        case(state)
            A : next = (reset) ? B : A;
            B : next = C ;
            C : next = D;
            D : next = E;
            E : next = A;
        endcase
    end 
    assign shift_ena  = (state == E | state == B | state == C | state == D );
endmodule
