module LED_COUNTER(
    clk,
    rst_n,
    led
);
    input clk;
    input rst_n;
    output reg led;

    reg [24:0] counter;
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)
            counter <= 0;
        else if(counter == 25_000_000)
            counter <= 0;
        else
            counter <= counter + 1'd1;
    end
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)
            led <= 0;
        else if(counter == 25_000_0000)
            led <= ~led;
endmodule
