module top_module (input a, input b, input c, output out);//
	wire out1;
    andgate ( out1 , a, b, c, 1, 1 );
    assign out = ~out1;

endmodule
