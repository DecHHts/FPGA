module LED_Flow(
    clk,
    reset_n,
    LED
);
    input clk;
    input reset_n;
    output reg [7:0] LED;
    
    reg [24:0] counter;
    
    always@(posedge clk or negedge reset_n) begin
        if(!reset_n)
            counter <= 0;
        else if(counter == 25_000_000 - 1)
            counter <= 0;
        else
            counter <= counter + 1;
    end
    
    always@(posedge clk or negedge reset_n) begin
        if(!reset_n)
            LED <= 0;
        else if(LED == 0)
            LED <= 8'b0000_0001;
        else if(counter == 25_000_000 - 1) begin
                if(LED == 8'b10000000)
                    LED <= 8'b00000001;
                else
                    LED <= LED << 1;
        end
    end
    
endmodule
