/*
You are to design a one-input one-output serial 2's complementer Moore state machine. The input (x) is a series of bits (one per clock cycle) beginning with the least-significant bit of the number, and the output (Z) is the 2's complement of the input. The machine will accept input numbers of arbitrary length. The circuit requires an asynchronous reset. The conversion begins when Reset is released and stops when Reset is asserted. 
*/

module top_module (
    input clk,
    input areset,
    input x,
    output z
); 
    localparam [1:0] NONE = 00, A = 11;
    reg [1:0] state, next;
	
	always@(posedge clk, posedge areset) begin 
		if(areset) state <= NONE;
		else state <= next;
	end 
	always@(*) begin 
		case(state)
			NONE : next = x ? A : NONE;
			A    : next = x ? A : A ;
		endcase
	end 
	
	always@(*) begin 
        case(state)
			NONE	:	z = x ? 1: 0;
			A   	:	z = (x) ? 0 : 1;
		endcase
	end 
endmodule
