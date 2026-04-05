`timescale 1ns/1ns
module LED_FLOW_tb();
    reg clk;
    reg rst_n;
    wire [7:0] led;

    LED_FLOW(
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
        $finish;
    end
endmodule
