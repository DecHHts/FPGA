module uart_byte_tx(
    clk,
    reset_n,
    data,
    uart_tx,
    led
);

input clk;
input reset_n;
input [7:0] data;
output uart_tx;
output led;

endmodule