module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);
//reg 
reg [5:0] next;

//comb 
assign next[0] = (y[3] && ~w) | (y[0] && ~w);
assign next[1] = (y[0] && w);
assign next[2] = (y[1] && w) || (y[5] && w);
assign next[3] = (y[1] && ~w ) || (y[2] && ~w) || (y[4] && ~w) || (y[5] && ~w);
assign next[4] = (y[2] && w) || (y[4] && w);
assign next[5] = (y[3] && w);
//output 
assign Y1 = next[1];
assign Y3 = next[3];
endmodule

