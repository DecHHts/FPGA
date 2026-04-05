module LED_FLOW(
    clk,
    rst_n,
    led
);
    input clk;
    input rst_n;
    output reg [7:0] led;

    reg [24:0] clk_counter;
    reg [3:0]  led_counter;
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            clk_counter <= 0;
        end else begin
            if(clk_counter == 25_000_000-1)
                clk_counter <= 0;
            else
                clk_counter <= clk_counter + 1;
        end
    end
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            led_counter <= 0;
        end else begin
            if(clk_counter == 25_000_000-1)
                led_counter <= led_counter + 1;
        end
    end
    
    always@(*)begin
        case(led_counter)
            0:led=8'b0000_0001;
            1:led=8'b0000_0010;
            2:led=8'b0000_0100;
            3:led=8'b0000_1000;
            4:led=8'b0001_0000;
            5:led=8'b0010_0000;
            6:led=8'b0100_0000;
            7:led=8'b1000_0000;
        endcase
    end
endmodule
