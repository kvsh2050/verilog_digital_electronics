/*You are provided with a BCD (binary-coded decimal) one-digit adder named bcd_fadd that adds two BCD digits and carry-in, and produces a sum and carry-out.

module bcd_fadd (
    input [3:0] a,
    input [3:0] b,
    input     cin,
    output   cout,
    output [3:0] sum );

Instantiate 4 copies of bcd_fadd to create a 4-digit BCD ripple-carry adder. Your adder should add two 4-digit BCD numbers (packed into 16-bit vectors) and a carry-in to produce a 4-digit sum and carry out.
*/
module top_module ( 
    input [15:0] a, b,
    input cin,
    output cout,
    output [15:0] sum );
	bcd_fadd ba1( .a(a[3:0]), .b(b[3:0]), .cin(cin), .cout(cout1), .sum(sum[3:0]) );
	bcd_fadd ba2( .a(a[7:4]), .b(b[7:4]), .cin(cout1), .cout(cout2), .sum(sum[7:4]) );
	bcd_fadd ba3( .a(a[11:8]), .b(b[11:8]), .cin(cout2), .cout(cout3), .sum(sum[11:8]) );
	bcd_fadd ba4( .a(a[15:12]), .b(b[15:12]), .cin(cout3), .cout(cout), .sum(sum[15:12]) );
endmodule
