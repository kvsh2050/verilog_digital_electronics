/*
Taken from 2015 midterm question 4

See mt2015_q4a and mt2015_q4b for the submodules used here. The top-level design consists of two instantiations each of subcircuits A and B, as shown below. 

*/

module top_module (input x, input y, output z);
        wire wire1,wire2,wire5,wire6;
        assign  wire1= (x ^ y) & x;
        assign wire2 = ~(x ^ y);
	assign z = wire5 ^ wire6;
	assign wire5 = wire1 | wire2;
	assign wire6 = wire1 & wire2;
endmodule

