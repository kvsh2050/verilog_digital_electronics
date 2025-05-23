module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input [3:1] r,   // request
    output [3:1] g   // grant
); 
    //reg 
    reg [1:0] state, next;
    localparam A = 0, G1 = 1, G2 = 2, G3 = 3 ;

    //seq
    always@(posedge clk) begin 
        if(!resetn) state <= A;
        else state <= next;
    end

    //comb 
    always@(*) begin 
        case(state)
            A:begin
                if(r[1]) next = G1;
                else if(r[2] & ~r[1]) next = G2;
                else if (~r[1] & ~r[2] & r[3]) next = G3;
                else next = A; 
            end
            G1: next = r[1] ? G1 : A;
            G2: next = r[2] ? G2 : A;
            G3: next = r[3] ? G3 : A;
        endcase
    end 

    //output 
    assign g[1] = (state == G1);
    assign g[2] = (state == G2);
    assign g[3] = (state == G3);
endmodule
