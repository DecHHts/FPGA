`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/02/09 10:08:10
// Design Name: 
// Module Name: uart_byte_rx_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module uart_byte_rx_tb();

    reg clk;
    reg reset_n;
    reg uart_rx;
    wire rx_done;
    wire [7:0] rx_data;

    uart_byte_rx u_uart_byte_rx(
        .clk(clk),
        .reset_n(reset_n),
        .uart_rx(uart_rx),
        .rx_done(rx_done),
        .rx_data(rx_data)
    );

    initial clk = 1;
    always #10 clk = ~clk;

    initial begin
        reset_n = 0;
        uart_rx = 1;
        #201;
        reset_n = 1;
        #200;
        uart_rx = 0;    #(5208*20);//起始位
        uart_rx = 1;    #(5208*20);//bit0
        uart_rx = 0;    #(5208*20);//bit1
        uart_rx = 1;    #(5208*20);//bit2
        uart_rx = 0;    #(5208*20);//bit3
        uart_rx = 1;    #(5208*20);//bit4
        uart_rx = 0;    #(5208*20);//bit5
        uart_rx = 1;    #(5208*20);//bit6
        uart_rx = 0;    #(5208*20);//bit7
        uart_rx = 1;    #(5208*20);//停止位

        #(5208*20*10);

        uart_rx = 0;    #(5208*20);//起始位
        uart_rx = 0;    #(5208*20);//bit0
        uart_rx = 1;    #(5208*20);//bit1
        uart_rx = 0;    #(5208*20);//bit2
        uart_rx = 1;    #(5208*20);//bit3
        uart_rx = 0;    #(5208*20);//bit4
        uart_rx = 1;    #(5208*20);//bit5
        uart_rx = 0;    #(5208*20);//bit6
        uart_rx = 1;    #(5208*20);//bit7
        uart_rx = 1;    #(5208*20);//停止位

        #(5208*20*10);

        uart_rx = 0;    #(5208*20);//起始位
        uart_rx = 1;    #(5208*20);//bit0
        uart_rx = 1;    #(5208*20);//bit1
        uart_rx = 1;    #(5208*20);//bit2
        uart_rx = 1;    #(5208*20);//bit3
        uart_rx = 0;    #(5208*20);//bit4
        uart_rx = 0;    #(5208*20);//bit5
        uart_rx = 0;    #(5208*20);//bit6
        uart_rx = 0;    #(5208*20);//bit7
        uart_rx = 1;    #(5208*20);//停止位

        #(5208*20*10);

        uart_rx = 0;    #(5208*20);//起始位
        uart_rx = 0;    #(5208*20);//bit0
        uart_rx = 0;    #(5208*20);//bit1
        uart_rx = 0;    #(5208*20);//bit2
        uart_rx = 0;    #(5208*20);//bit3
        uart_rx = 1;    #(5208*20);//bit4
        uart_rx = 1;    #(5208*20);//bit5
        uart_rx = 1;    #(5208*20);//bit6
        uart_rx = 1;    #(5208*20);//bit7
        uart_rx = 1;    #(5208*20);//停止位
        
        #(5208*20*10);
        $stop;

    end

endmodule
