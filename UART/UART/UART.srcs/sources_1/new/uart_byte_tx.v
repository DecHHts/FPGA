module uart_byte_tx(
    clk,
    reset_n,
    data,
    uart_tx,
    led
    );
    
    input clk;
    input reset_n;
    input data;
    output reg uart_tx;
    output led;
    
    //波特率计数器 1/9600 * 10^9 /20 -1 = 5207
    reg [12:0] baud_div_cnt;
    reg en_baud_cnt;
    parameter MCNT_BAUD = 5208 - 1;

    always@(posedge clk or negedge reset_n)
    begin
        if(!reset_n)
            baud_div_cnt <= 0;
        else if(en_baud_cnt) begin
            if(baud_div_cnt == MCNT_BAUD)
                baud_div_cnt <= 0;
            else
                baud_div_cnt <= baud_div_cnt + 1'd1;
        end
        else
            baud_div_cnt <= 0;
    end
    //位计数器
    reg [3:0] bit_cnt;
    parameter MCNT_BIT = 9;
    always@(posedge clk or negedge reset_n)
    begin
        if(!reset_n)
            bit_cnt <= 0;
        else if(baud_div_cnt == MCNT_BAUD) begin
            if(bit_cnt == MCNT_BIT)
                bit_cnt <= 0;
            else
                bit_cnt <= bit_cnt + 1'd1;
        end
    end

    //定时1s时间的计数器
    
    //位发送逻辑
    always@(posedge clk or negedge reset_n)
    begin
        if(!reset_n)
            uart_tx <= 1'd1; //空闲状态为高电平
        else begin
            case(bit_cnt)
                0: uart_tx <= 1'd0
                
            endcase
        end
    end
    //控制LED输出翻转逻辑

endmodule
