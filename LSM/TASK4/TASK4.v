module TASK4(
    clk,
    rst_n,
    button,
    led
);
    input clk;
    input rst_n;
    input [7:0] button;
    output led;
    
    reg [23:0] clk_counter;
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)
            clk_counter <= 0;
        else
            if(clk_counter == 24'd12_500_000 - 1)
                clk_counter <= 0;
            else
                clk_counter <= clk_counter + 1;
    end

    reg [3:0] state_counter;
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)
            state_counter <= 0;
        else begin
            if(clk_counter == 24'd12_500_000 - 1)
                if(state_counter == 11)
                    state_counter <= 0;
                else
                    state_counter <= state_counter + 1;
        end
    end

    reg [7:0] button_status;
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)
            button_status <= 0;
        else if((state_counter == 3) && (clk_counter == 24'd12_500_000 - 1))
            button_status <= button;
    end

    always@(*)begin
        case(state_counter)
            0: led = 0;
            1: led = 0;
            2: led = 0;
            3: led = 0;
            4: led = button_status[0];
            5: led = button_status[1];
            6: led = button_status[2];
            7: led = button_status[3];
            8: led = button_status[4];
            9: led = button_status[5];
            10: led = button_status[6];
            11: led = button_status[7];
        endcase
    end
endmodule
