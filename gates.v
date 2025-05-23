/*

Ok, let's try building several logic gates at the same time. Build a combinational circuit with two inputs, a and b.

There are 7 outputs, each with a logic gate driving it:

    out_and: a and b
    out_or: a or b
    out_xor: a xor b
    out_nand: a nand b
    out_nor: a nor b
    out_xnor: a xnor b
    out_anotb: a and-not b

Expected solution length: Around 7 lines.
Module Declaration

module top_module( 
    input a, b,
    output out_and,
    output out_or,
    output out_xor,
    output out_nand,
    output out_nor,
    output out_xnor,
    output out_anotb
);

*/
module top_module( 
    input a, b,
    output out_and,
    output out_or,
    output out_xor,
    output out_nand,
    output out_nor,
    output out_xnor,
    output out_anotb
);
	assign out_and = a & b;
	assign out_or = a | b;
	assign out_xor = a ^ b;
	assign out_nand = ~(a & b);
	assign out_nor = ~(a | b);
	assign out_xnor = ~(a ^ b);
	assign out_anotb = a & (~b);
endmodule

