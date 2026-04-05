module TASK1(
    clk,
    rst_n,
    led
);

    input clk;
    input rst_n;
    output reg led;

    reg [23:0] clk_counter;
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)
            clk_counter <= 0;
        else
            if(clk_counter == 23'd12_500_000 - 1)
                clk_counter <= 0;
            else
                clk_counter <= clk_counter + 1'b1;
    end
    reg [1:0] state_counter;
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)
            state_counter <= 0;
        else
            if(clk_counter == 23'd12_500_000 - 1)
                state_counter <= state_counter + 1;
    end
    always@(*)begin
        case(state_counter)
            0:led = 1;
            1:
            2:
            3:led = 0;
        endcase
    end
endmodule
