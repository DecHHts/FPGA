`timescale 1ns/1ns
module LED_COUNTER_tb();
    reg clk;
    reg rst_n;
    wire led;
    LED_COUNTER U_LED_COUNTER(
        .clk(clk),
        .rst_n(rst_n),
        .led(led)
    );
    initial clk = 1;
    always #10 clk = ~clk;
    initial begin
        rst_n = 0;
        #201;
        rst_n = 1;
        #2000_000_000;
        $stop;
    end
endmodule
