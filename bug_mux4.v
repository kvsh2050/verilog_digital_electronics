module top_module (
    input [1:0] sel,
    input [7:0] a,
    input [7:0] b,
    input [7:0] c,
    input [7:0] d,
    output [7:0] out  ); //

    wire [7:0] muxW0, muxW1;
    mux2 muxM0 ( sel[0],    a,    b, muxW0 );
    mux2 muxM1 ( sel[0],    c,    d, muxW1 );
    mux2 muxM2 ( sel[1], muxW0, muxW1,  out );
    
endmodule
