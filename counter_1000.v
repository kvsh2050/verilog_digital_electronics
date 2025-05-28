//counter with 1000 period

module top_module (
    input clk,
    input reset,
    output [9:0] q);
    //counter is seq
    always@(posedge clk) begin 
        if(reset) q <= 10'd0;
        else begin 
            if(q == 10'd999) q <= 10'd0;
            else q <= q + 1'b1;
        end 
    end 
endmodule