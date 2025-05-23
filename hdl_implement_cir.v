module top_module (
    input clk,
    input resetn,   // synchronous reset
    input in,
    output out);
    reg in1, in2, in3;
always@(posedge clk) begin 
if(!resetn) begin 
out <= 'b0;
in1 <= 'b0;
in2 <= 'b0;
in3 <= 'b0; //why ? becoz, you are reseting all flipflops 
end
else begin 
in1 <= in ;
in2 <= in1;
in3 <= in2;
out <= in3;
end 
end 
endmodule
