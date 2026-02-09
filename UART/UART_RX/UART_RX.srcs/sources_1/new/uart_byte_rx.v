`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/02/07 23:37:21
// Design Name: 
// Module Name: uart_byte_rx
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


module uart_byte_rx(
    clk,
    reset_n,
    uart_rx,
    rx_done,
    rx_data
    );

    input clk;
    input reset_n;
    input uart_rx;
    output reg rx_done;
    output reg [7:0] rx_data;

    reg en_baud_cnt;
    reg [29:0] baud_div_cnt;
    reg bit1, bit2;
    wire is_down, is_up;
    reg [3:0] bit_cnt;
    wire tmp_rx_done;
    reg dff0, dff1;
    reg [7:0] tmp_rx_data;

    parameter BAUD = 9600;
    parameter CLOCK_FREQ = 50_000_000;
    parameter MCNT_BAUD = CLOCK_FREQ / BAUD - 1;
    parameter MCNT_BIT = 9;

    assign tmp_rx_done = (baud_div_cnt == MCNT_BAUD) && (bit_cnt == 9);
    always@(posedge clk) begin
        rx_done <= tmp_rx_done;
        if(rx_done)
            rx_data <= tmp_rx_data;
    end

    //波特率计数器使能逻辑
    always@(posedge clk or negedge reset_n)begin
        if(!reset_n)
            en_baud_cnt <= 0;
        else if(is_down)
            en_baud_cnt <= 1;
        else if((baud_div_cnt == MCNT_BAUD/2) && (bit_cnt == 0) && (dff1 == 1))
            en_baud_cnt <= 0;
        else if(tmp_rx_done)
            en_baud_cnt <= 0;
    end

    //波特率计数器
    always@(posedge clk or negedge reset_n)begin
        if(!reset_n)begin
            baud_div_cnt <= 0;
        end else if(en_baud_cnt)begin
            if(baud_div_cnt == MCNT_BAUD)begin
                baud_div_cnt <= 0;
            end else begin
                baud_div_cnt <= baud_div_cnt + 1'b1;
            end
        end
    end

    //位计数器
    always@(posedge clk or negedge reset_n)begin
        if(!reset_n)
            bit_cnt <= 0;
        else if(baud_div_cnt == MCNT_BAUD) begin
            if(bit_cnt == MCNT_BIT)begin
                bit_cnt <=0;
            end else begin
                bit_cnt <= bit_cnt + 1'b1;
            end
        end
    end


    //下降沿检测
    always@(posedge clk)begin
        dff0 <= uart_rx;
        dff1 <= dff0;
    end
    always@(posedge clk)begin
        bit1 <= dff1;
        bit2 <= bit1;
    end
    assign is_down = (!bit1) & bit2;
    assign is_up = bit1 & (!bit2);

    //位接收逻辑
    always@(posedge clk or negedge reset_n)begin
        if(!reset_n)begin
            rx_data <= 0;
        end else if(en_baud_cnt && (baud_div_cnt == MCNT_BAUD/2))begin
            case(bit_cnt)
                1:tmp_rx_data[0] <= dff1;
                2:tmp_rx_data[1] <= dff1;
                3:tmp_rx_data[2] <= dff1;
                4:tmp_rx_data[3] <= dff1;
                5:tmp_rx_data[4] <= dff1;
                6:tmp_rx_data[5] <= dff1;
                7:tmp_rx_data[6] <= dff1;
                8:tmp_rx_data[7] <= dff1;
                default: tmp_rx_data <= tmp_rx_data;
            endcase
        end
    end


endmodule
