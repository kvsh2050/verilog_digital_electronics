//hdlc frame detection/
/*
Synchronous HDLC framing involves decoding a continuous bit stream of data to look for bit patterns that indicate the beginning and end of frames (packets). Seeing exactly 6 consecutive 1s (i.e., 01111110) is a "flag" that indicate frame boundaries. To avoid the data stream from accidentally containing "flags", the sender inserts a zero after every 5 consecutive 1s which the receiver must detect and discard. We also need to signal an error if there are 7 or more consecutive 1s.

Create a finite state machine to recognize these three sequences:

    0111110: Signal a bit needs to be discarded (disc).
    01111110: Flag the beginning/end of a frame (flag).
    01111111...: Error (7 or more 1s) (err).

When the FSM is reset, it should be in a state that behaves as though the previous input were 0.

Here are some example sequences that illustrate the desired operation.

*/

module top_module(
    input clk,
    input reset,    // Synchronous reset
    input in,
    output disc,
    output flag,
    output err);
	 //state declaration
	 reg [3:0] state, next ;
	 localparam [3:0] START = 0, C1 = 1, C2 = 2, C3 = 3, C4 = 4, C5 = 5,C6 = 6,  DISCARD = 7, FLAG = 8, ERR = 9;

	 //sequential 
	 always@(posedge clk) begin 
	 	if(reset) state <= START ;
	 	else state <= next;
	 end 	
	 //comb
	 always@(*) begin
	 	case(state) 
	 		START : begin 
	 			if(in) next = C1; //0
	 			else next = START;	
	 		end  
	 		C1 : begin 
	 			if(in) next = C2 ; //1
	 			else next = START;
	 		end 
	 		C2 : begin 
	 			if(in) next = C3 ; //2 
	 			else next = START;
	 		end
	 		C3 : begin
	 			if(in) next = C4 ; //3
	 			else next = START;
	 		end 
	 		C4 : begin 
	 			if(in) next = C5 ; //4
	 			else next = START;
	 		end 
	 		C5 :begin
	 			if(in) next = C6; //5
	 			else next = DISCARD;
	 		end 
	 		C6 :begin 
	 			if(in) next = ERR ; //6
	 			else next = FLAG;
	 		end 
	 		DISCARD : begin 
	 			if(in) next = C1 ; 
	 			else next = START;
	 		end 
	 		FLAG : begin 
	 			if(in) next = C1 ; 
	 			else next = START;
	 		end 
	 		ERR : begin 
	 			if(in) next = ERR ; //7 
	 			else next = START;
	 		end 
	 	endcase 
	 end
	 assign err = (state == ERR) ;
	 assign flag = (state == FLAG) ;
	 assign disc = (state == DISCARD); 
endmodule
