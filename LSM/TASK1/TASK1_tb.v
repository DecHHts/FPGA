`timescale 1ns/1ns
module TASK1_tb();
    reg clk;
    reg rst_n;
    wire led;
    TASK1 U_TASK1(
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
        #2_000_000_000;
        $finish;
    end
endmodule
