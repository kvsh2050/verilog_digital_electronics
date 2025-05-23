module top_module (
    input clk,
    input areset,
    input x,
    output z
); 
	localparam [1:0] S0 =2, S1 = 3, S2 = 1 ;
	reg [1:0] state, next;
	always@(posedge clk, posedge areset) begin 
		if(areset) state <= S0;
		else state <= next;
	end 
	always@(*) begin 
		case(state)
			S0 : next = x ? S1 : S0;
			S1 : next = x ? S2 : S1;
			S2 : next = x ? S2 : S1;
			default : next = S0;
		endcase
	end 
	assign z = (state == S1); 
endmodule
	 
