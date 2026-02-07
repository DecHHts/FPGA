module uart_byte_tx(
    clk,
    reset_n,
    data,
    send_go,
    uart_tx,
    led,
    tx_done
    );
    
    input clk;
    input reset_n;
    input send_go;
    input [7:0] data;
    output reg uart_tx;
    output reg led;
    output tx_done;
    
    parameter BAUD = 9600;
    parameter CLOCK_FREQ = 50_000_000;
    
    //波特率计数器 1/9600 * 10^9 /20 -1 = 5207
    reg [29:0] baud_div_cnt;
    reg en_baud_cnt;
    parameter MCNT_BAUD = CLOCK_FREQ / BAUD - 1;
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
//    reg [25:0] delay_cnt;
//    parameter MCNT_DLY = 50_000_000 - 1;
//    always@(posedge clk or negedge reset_n)
//    begin
//        if(!reset_n)
//            delay_cnt <= 0;
//        else if(delay_cnt == MCNT_DLY)
//            delay_cnt <= 0;
//        else
//            delay_cnt <= delay_cnt + 1'b1;
//    end
    
    
    
    
    
    reg [7:0] r_data;
    always@(posedge clk or negedge reset_n)
    begin
        if(!reset_n)
            r_data <= 0;
        else if(send_go)
            r_data <= data;
        else
            r_data <= r_data;
    end
    
    //位发送逻辑
    always@(posedge clk or negedge reset_n)
    begin
        if(!reset_n)
            uart_tx <= 1'd1; //空闲状态为高电平
        else if(en_baud_cnt == 0)
            uart_tx <= 1'd1;
        else begin
            case(bit_cnt)
                0: uart_tx <= 1'd0;
                1: uart_tx <= r_data[0];
                2: uart_tx <= r_data[1];
                3: uart_tx <= r_data[2];
                4: uart_tx <= r_data[3];
                5: uart_tx <= r_data[4];
                6: uart_tx <= r_data[5];
                7: uart_tx <= r_data[6];
                8: uart_tx <= r_data[7];
                9: uart_tx <= 1'd1;
                default: uart_tx <= uart_tx;            
            endcase
        end
    end
    //控制LED输出翻转逻辑
    always@(posedge clk or negedge reset_n)
    begin
        if(!reset_n)
            led <= 0;
        else if(tx_done)
            led <= ~led;
    end
    
    //波特率计数器使能
    always@(posedge clk or negedge reset_n)
    begin
        if(!reset_n)
            en_baud_cnt <= 0;
        else if(send_go)
            en_baud_cnt <= 1;
        else if(tx_done)
            en_baud_cnt <= 0;
    end
    
    assign tx_done = (bit_cnt == 9) && (baud_div_cnt == MCNT_BAUD);
endmodule
