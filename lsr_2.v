/*
See Lfsr5 for explanations.

Build a 32-bit Galois LFSR with taps at bit positions 32, 22, 2, and 1.
Module Declaration

module top_module(
    input clk,
    input reset,    // Active-high synchronous reset to 32'h1
    output [31:0] q
); 
 This is long enough that you'd want to use vectors, not 32 instantiations of DFFs.

*/
module top_module(
    input clk,
    input reset,    // Active-high synchronous reset to 32'h1
    output [31:0] q
); 

always@(posedge clk) begin 
if(reset) q <= 32'h1;
else begin 
//logic 
q[31] <= q[0] ^ 1'b0 ;
q[30:22] <= q[31:23];
q[21] <= q[0] ^ q[22];
q[20:2] <= q[21:3];
q[1] <= q[0] ^ q[2];
q[0] <= q[0] ^ q[1];
end 
end 

endmodule

//other way
module top_module(
    input clk,
    input reset,    // Active-high synchronous reset to 32'h1
    output [31:0] q
); 
    always @(posedge clk)begin
        if(reset) q<=32'h1;
        else q<={q[0]^1'b0,q[31:23],q[22]^q[0],q[21:3],q[2]^q[0],q[1]^q[0]};
    end
endmodule
