/*Create a 100-bit binary adder. The adder adds two 100-bit numbers and a carry-in to produce a 100-bit sum and carry out.

Expected solution length: Around 1 line.
Module Declaration

module top_module( 
    input [99:0] a, b,
    input cin,
    output cout,
    output [99:0] sum );
*/

module top_module( 
    input [99:0] a, b,
    input cin,
    output cout,
    output [99:0] sum );
	assign { cout , sum[99:0] }= a[99:0] + b[99:0] + cin;
endmodule

