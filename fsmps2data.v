module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output [23:0] out_bytes,
    output done); //
	localparam [1:0] BYTE1_C = 2'd0, BYTE2 = 2'd1, BYTE3 = 2'd2, DONE_C = 2'd3;
	reg [1:0] state, next_state; 
	reg[23:0] data;
    // FSM from fsm_ps2
	always@(*) begin 
	case(state) 
		BYTE1_C: next_state = (in[3]) ? (BYTE2) : (BYTE1_C);
		BYTE2: next_state = BYTE3;
		BYTE3: next_state = DONE_C;
		DONE_C: next_state = (in[3]) ? (BYTE2) : (BYTE1_C);
	endcase
	end 
    // New: Datapath to store incoming bytes.
	always@(posedge clk) begin 
		if(reset) data <= 24'b0;
		else begin 
			data <= {data[15:8] , data[7:0], in};
		end 
	end 
	//sequential 
	always@(posedge clk) begin 
		if(reset) state <= BYTE1_C;
		else begin
			 state <= next_state;
		end 
	end	
	//output 
	assign done = (state == DONE_C);
	assign out_bytes = (done) ? data : 24'b0;
	
endmodule

