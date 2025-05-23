/*
Create a full adder. A full adder adds three bits (including carry-in) and produces a sum and carry-out.

Expected solution length: Around 2 lines.
Module Declaration

module top_module( 
    input a, b, cin,
    output cout, sum );
*/
module top_module( 
    input a, b, cin,
    output cout, sum );
	assign sum = a ^ b ^ cin;
	assign cout = (a&b)|(b&cin)|(cin&a);
endmodule
