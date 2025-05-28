//final design 
module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output [3:0] count,
    output counting,
    output done,
    input ack );
    //declaration 
    reg [3:0] shift_reg;
    localparam S0 = 0, S1 = 1, S2 = 2, S3 = 3, SH0 = 4, SH1 = 5, SH2 = 6, SH3 = 7, COUNT = 8, DONE = 9;
    reg[3:0] state, next;
    reg [3:0] count_0;
    reg [9:0] count_1000;

    always@(posedge clk) begin 
        if(reset) state <= S0;
        else state <= next; 
    end 

    always@(*) begin 
        case(state)
            S0    : next = data ? S1 : S0;
            S1    : next = data ? S2 : S0;
            S2    : next = data ? S2 : S3;
            S3    : next = data ? SH0 : S0;
            SH0   : next = SH1;
            SH1   : next = SH2;
            SH2   : next = SH3;
            SH3   : next = COUNT;
            COUNT : next = (count == 0 & count_1000 == 10'd999) ? DONE : COUNT;
            DONE  : next = (ack) ? S0 : DONE;
        endcase 
    end 

    always@(posedge clk) begin  
            case(state) 
                SH0     : count[3] <= data;
                SH1     : count[2] <= data;
                SH2     : count[1] <= data;
                SH3     : count[0] <= data;
                COUNT   : begin 
                    if(count_0 >= 0) begin  //DELAY+1 * 1000
                            if(count_1000 < 10'd999) count_1000 <= count_1000 + 1'b1;
                            else  begin 
                                count_1000 <= 10'd0;
                                count <= count - 1'b1;
                            end 
                    end 
                end 
                default : begin 
                    count_1000 <= 10'd0;
                end 
            endcase    
    end 

    //output 
    assign done = (state == DONE);
    assign counting = (state == COUNT);
endmodule
