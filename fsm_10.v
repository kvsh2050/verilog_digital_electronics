module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input x,
    input y,
    output f,
    output g
); 
//declare
reg [3:0] state, next ;
localparam A = 0, F = 1, MON = 2, S1 = 3, S2 = 4, M1 = 5, M2 = 6, G0 = 7, G1 = 8;

//seq
always@(posedge clk) begin 
    if(!resetn) state <= A;
    else state <= next;
end 

//comb 
always@(*) begin 
    case(state)
        A:      next = (~resetn) ? A : F;
        F:      next = MON;
        MON:    next = x ? S1  : MON;
        S1:     next = x ? S1 : S2;             //why the successive does not play a part here then mon:s2 ? because we need a overlapping case
        S2:     next = x ? M1  : MON;
        M1:     next = y ? G1  : M2;
        M2:     next = y ? G1  : G0;
        G0:     next = (~resetn) ? A : G0;
        G1:     next = (~resetn) ? A : G1;
    endcase
end 

//output 
assign f =  (state == F);
assign g = (state == G1 || state == M1 || state == M2) ;

endmodule
