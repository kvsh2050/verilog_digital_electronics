//around 1 line solution 
module top_module( 
    input a, b, sel,
    output out ); 
	assign out = sel ? b : a;
endmodule
