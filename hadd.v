/*
HADD 
Create a half adder. A half adder adds two bits (with no carry-in) and produces a sum and carry-out.

Expected solution length: Around 2 lines.
Module Declaration

module top_module( 
    input a, b,
    output cout, sum );
*/
module top_module( 
    input a, b,
    output cout, sum );
	assign sum = a ^ b ;
	assign cout = a & b;
endmodule
