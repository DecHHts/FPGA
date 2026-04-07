`timescale 1ns/1ns
module TASK3_tb();
    reg clk;
    reg rst_n;
    reg [7:0] button;
    wire led;
    TASK3 U_TASK3(
        .clk(clk),
        .rst_n(rst_n),
        .button(button),
        .led(led)
    );
    initial clk = 1;
    always #10 clk = ~clk;
    initial begin
        rst_n = 0;
        #201;
        rst_n = 1;
        button = 8'b00001111;
        #1_000_000_000;
        button = 8'b11110000;
        #1_000_000_000;
        button = 8'b11001100;
        #1_000_000_000;
        button = 8'b00110011;
        #1_000_000_000;
        button = 8'b01010101;
        #1_000_000_000;
        button = 8'b10101010;
        #1_000_000_000;
        $finish;
    end
endmodule
