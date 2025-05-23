module top_module (
    input clk,
    input reset,   // Synchronous reset
    input s,
    input w,
    output z
);	
	localparam A = 0, B = 1;
	reg [1:0] state, next ;

	reg [1:0] count1, count ;

	
	always@(*) begin 
		case(state) 
			A : next = s ? B : A ;
			B : next = B;
		endcase
	end 
	always@(posedge clk) begin 
		if(reset) begin 
			state <= A;
			count1 <= 0;
			count <= 0;
		end 
		else begin 
			state <= next;
			case(state) 
				B :begin 
					if(count == 3) begin 
						count1 = 0;
						count = 0;
					end
					if( w == 1 ) begin 
						count1 = count1 + 1;
					end  
					count = count + 1;
				end
			endcase
		end 
	end 


	assign z = (count1 == 2) && (count == 3); 
endmodule



