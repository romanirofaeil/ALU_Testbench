module ALU (
            input clk,
            input reset,
            input valid,
            input[1:0] sel,
            input[3:0] a,
            input[3:0] b,
            output[6:0] c
            );
    reg[6:0] tmp_c;
    //Reset
    always @(posedge reset)
        tmp_c <= 0;
    //ALU operations
    always @(posedge clk)
        if(valid)
            case(sel)
                0: tmp_c <= a + b;
                1: tmp_c <= a - b;
                2: tmp_c <= a * b;
                default: tmp_c <= a / b;
            endcase
    assign c = tmp_c;
endmodule
