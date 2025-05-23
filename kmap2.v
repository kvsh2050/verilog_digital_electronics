module top_module(
    input a,
    input b,
    input c,
    input d,
    output out  ); 
	assign out = (~a & ~d) | (~b & ~c) | (c & ~a & b) | (c & d & a);
endmodule

