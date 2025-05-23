/*
You are given a four-bit input vector in[3:0]. We want to know some relationships between each bit and its neighbour:

    out_both: Each bit of this output vector should indicate whether both the corresponding input bit and its neighbour to the left (higher index) are '1'. For example, out_both[2] should indicate if in[2] and in[3] are both 1. Since in[3] has no neighbour to the left, the answer is obvious so we don't need to know out_both[3].
    
    out_any: Each bit of this output vector should indicate whether any of the corresponding input bit and its neighbour to the right are '1'. For example, out_any[2] should indicate if either in[2] or in[1] are 1. Since in[0] has no neighbour to the right, the answer is obvious so we don't need to know out_any[0].
    
    out_different: Each bit of this output vector should indicate whether the corresponding input bit is different from its neighbour to the left. For example, out_different[2] should indicate if in[2] is different from in[3]. For this part, treat the vector as wrapping around, so in[3]'s neighbour to the left is in[0].

*/
module top_module( 
    input [3:0] in,
    output [2:0] out_both,
    output [3:1] out_any,
    output [3:0] out_different );
	integer i;
	always@(*) begin 
		for (i = 0; i < 4; i++) begin 
			if(i == 0) begin
				out_both[i] = in[i] & in[i+1];
				out_different[i] = in[i] ^ in[i+1];
			end 
			else if ( i == 3) begin 
				out_different[i] = in[i] ^ in[i+1-4]; // does this indicate memory element maybe in comb which is not recomemded 
			end 
			else begin 
				out_both[i] = in[i] & in[i+1];
				out_different[i] = in[i] ^ in[i+1];
			end 
		end
		for ( i = 1 ; i < 4 ; i++) begin 
			out_any[i] =  in[i] | in[i-1];
		end 
	end 
endmodule

//their sol
module top_module (
	input [3:0] in,
	output [2:0] out_both,
	output [3:1] out_any,
	output [3:0] out_different
);

	// Use bitwise operators and part-select to do the entire calculation in one line of code
	// in[3:1] is this vector:   					 in[3]  in[2]  in[1]
	// in[2:0] is this vector:   					 in[2]  in[1]  in[0]
	// Bitwise-OR produces a 3 bit vector.			          |      |      |
	// Assign this 3-bit result to out_any[3:1]:	               o_a[3] o_a[2] o_a[1]

	// Thus, each output bit is the OR of the input bit and its neighbour to the right:
	// e.g., out_any[1] = in[1] | in[0];	
	// Notice how this works even for long vectors.
	assign out_any = in[3:1] | in[2:0];

	assign out_both = in[2:0] & in[3:1];
	
	// XOR 'in' with a vector that is 'in' rotated to the right by 1 position: {in[0], in[3:1]}
	// The rotation is accomplished by using part selects[] and the concatenation operator{}.
	assign out_different = in ^ {in[0], in[3:1]};
	
endmodule

