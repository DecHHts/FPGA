module LED_FLOW(
    clk,
    rst_n,
    led
);
    input clk;
    input rst_n;
    output [7:0] led;

    reg [24:0] clk_counter;
    reg [7:0]  led_counter;
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
            if(led_counter == 7)
                led_counter <= 0;
            else
                led_counter <= led_counter + 1;
        end
    end
    
    always@(*)begin
        case(led_counter)
            1:led<=8'd0000_0001;
            2:led<=8'd0000_0010;
            3:led<=8'd0000_0100;
            4:led<=8'd0000_1000;
            5:led<=8'd0001_0000;
            6:led<=8'd0010_0000;
            7:led<=8'd0100_0000;
            8:led<=8'd1000_0000;
        endcase
    end
endmodule

