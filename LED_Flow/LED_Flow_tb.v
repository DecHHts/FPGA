`timescale 1ns/1ns

module LED_Flow_tb();

    reg clk;
    reg reset_n;
    wire [7:0] LED;

    LED_Flow U_LED_Flow (
        .clk(clk),
        .reset_n(reset_n),
        .LED(LED)
    );

    initial clk = 0;
    always #10 clk = ~clk;

    initial begin
        reset_n = 0;
        #201;
        reset_n = 1;
        #2000_000_000;
        #2000_000_000;
        $stop;
    end

endmodule
