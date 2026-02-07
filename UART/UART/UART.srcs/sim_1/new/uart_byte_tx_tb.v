`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/02/07 13:37:55
// Design Name: 
// Module Name: uart_byte_tx_tb
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


module uart_byte_tx_tb();
    
    reg clk;
    reg reset_n;
    reg [7:0] data;
    wire uart_tx;
    wire led;
    
    uart_byte_tx u_uart_byte_tx(
    .clk(clk),
    .reset_n(reset_n),
    .data(data),
    .uart_tx(uart_tx),
    .led(led)
    );
    
    defparam u_uart_byte_tx.MCNT_DLY = 50_000_0 - 1;
    
    initial clk = 1;
    always #10 clk = ~clk;
    
    initial begin
        reset_n = 0;
        #201;
        reset_n = 1;
        
        data = 8'b0101_0101;
        #30_000_000;
        data = 8'b1010_1010;
        #30_000_000;
        
        $stop;
    end
        
endmodule
