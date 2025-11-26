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
        if(!reset_n) begin
            counter <= 0;
            LED <= 0;
        end
        else if(counter == 25_000_000 - 1) begin
            counter <= 0;
            LED <= LED + 1;
        end
        else
            counter <= counter + 1;
    end
    
endmodule