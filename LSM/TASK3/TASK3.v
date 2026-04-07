module TASK3(
    clk,
    rst_n,
    led,
    button
);
    input clk;
    input rst_n;
    input [7:0] button;
    output reg led;

    reg [7:0] button_status;
    reg [23:0] clk_counter;
    reg [2:0] state_counter;
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)
            clk_counter <= 0;
        else begin
            if(clk_counter == 24'd12_500_000 - 1)
                clk_counter <= 0;
            else
                clk_counter <= clk_counter + 1;
        end
    end

    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)
            state_counter <= 0;
        else
            state_counter <= state_counter + 1;
    end

    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            button_status <= button;
            led <= 0;
        end else begin
            if((state_counter == 7) && (clk_counter == 24'd12_500_000 - 1))
                button_status <= button;
            if(clk_counter == 24'd12_500_000 - 1)
                led <= button_status[state_counter];
        end
    end
endmodule
