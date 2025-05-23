module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4);

    //declaration
    reg [6:1] next ;
    localparam A = 6'b000_001 , B = 6'b000_010 , C = 6'b000_100 , D = 6'b001_000 , E = 6'b010_000 , F = 6'b100_000;
    //combinational

    //try it in one hot fsm logic with 6 digits
    assign Y2 = (~w & y[1]); 
    assign Y4 = (w & (y[2] | y[3] | y[5] | y[6]));

endmodule
