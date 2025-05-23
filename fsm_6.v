module top_module (
    input clk,
    input reset,   
    input w,
    output z);

    reg [6:1] next ;
    reg [6:1] y; //state
    
    always@(posedge clk) begin 
        if(reset) y <= 6'b000_001;
        else y <= next;
    end 

    assign next[2] = (~w & y[1]); 
    assign next[4] = (w & (y[2] | y[3] | y[5] | y[6]));
    assign next[1] = (w & y[1] )| ( w & y[4]);
    assign next[3] = (~w & y[2]) | ( ~w & y[6]);
    assign next[5] = (~w & y[3]) | (~w & y[5]);
    assign next[6] = (~w & y[4]);
    
    //output
    assign z = (y[5] | y[6]);
endmodule

//the next logic would be just to raise the bit in that particular location