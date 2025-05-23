/*


Write a top-level Verilog module (named top_module) for the shift register, assuming that n = 4. Instantiate four copies of your MUXDFF subcircuit in your top-level module. Assume that you are going to implement the circuit on the DE2 board.

    Connect the R inputs to the SW switches,
    clk to KEY[0],
    E to KEY[1],
    L to KEY[2], and
    w to KEY[3].
    Connect the outputs to the red lights LEDR[3:0].

(Reuse your MUXDFF from exams/2014_q4a.)
Module Declaration

module top_module (
    input [3:0] SW,
    input [3:0] KEY,
    output [3:0] LEDR
); 
	
*/
module top_module (
    input [3:0] SW,
    input [3:0] KEY,
    output [3:0] LEDR
); // n = 4

wire q0, q1, q2, q3;
MUXDFF md1 (.clk(KEY[0]) , .in1(q3), .in2(KEY[3]), 	.Q(q3), 	.sel(KEY[1]), 	.sel1(KEY[2]), .in3(SW[3])); //n-1
MUXDFF md2 (.clk(KEY[0]) , .in1(q2), .in2(q3), 	 	.Q(q2), 	.sel(KEY[1]), 	.sel1(KEY[2]), .in3(SW[2]));
MUXDFF md3 (.clk(KEY[0]) , .in1(q1), .in2(q2), 	 	.Q(q1), 	.sel(KEY[1]), 	.sel1(KEY[2]), .in3(SW[1]));
MUXDFF md4 (.clk(KEY[0]) , .in1(q0), .in2(q1), 	 	.Q(q0), 	.sel(KEY[1]), 	.sel1(KEY[2]), .in3(SW[0])); //0
assign LEDR = { q3, q2, q1, q0};
endmodule

module MUXDFF (input clk, sel, sel1, in1, in2, in3, output Q);

wire mux_out1, mux_out;
assign mux_out1 = sel ? in2 : in1;
assign mux_out = sel1 ? in3 : mux_out1;
always@(posedge clk) begin 
Q <= mux_out;
end 

endmodule
