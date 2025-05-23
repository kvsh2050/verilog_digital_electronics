module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    input w,
    output z
);
//reg 
reg [6:1] state, next;

//seq 
always@(posedge clk) begin 
    if(reset) state <= 6'b000_001;
    else state <= next;
end
//comb 
assign next[1] = (state[4] && ~w) | (state[1] && ~w);
assign next[2] = (state[1] && w);
assign next[3] = (state[2] && w) || (state[6] && w);
assign next[4] = (state[2] && ~w ) || (state[3] && ~w) || (state[5] && ~w) || (state[6] && ~w);
assign next[5] = (state[3] && w) || (state[5] && w);
assign next[6] = (state[4] && w);
//output 
assign z = (state[5] || state[6]);
endmodule
