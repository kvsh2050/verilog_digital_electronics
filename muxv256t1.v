/*
Create a 4-bit wide, 256-to-1 multiplexer. The 256 4-bit inputs are all packed into a single 1024-bit input vector. sel=0 should select bits in[3:0], sel=1 selects bits in[7:4], sel=2 selects bits in[11:8], etc.

Expected solution length: Around 1–5 lines.

    - With this many options, a case statement isn't so useful.
    - Vector indices can be variable, as long as the synthesizer can figure out that the width of the bits being selected is constant. It's not always good at this. An error saying "... is not a constant" means it couldn't prove that the select width is constant. In particular, in[ sel*4+3 : sel*4 ] does not work.
    - Bit slicing ("Indexed vector part select", since Verilog-2001) has an even more compact syntax. 
*/
module top_module( 
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out );

	//assign out[3:0] = in[((sel*4)+3) : (sel*4)]; //syn problem 
	assign out[3:0] = in[sel*4 +: 4]; //indexed vector part select operator in assign -> start from sel*4 and add 3 bit to it 
endmodule
//assign out[3:0] = in[((sel*4)+3) : (sel*4)];
