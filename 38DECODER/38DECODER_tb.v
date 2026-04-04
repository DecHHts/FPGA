module _38DECODER_tb();
    reg [2:0] a;
    wire [7:0] y;
    _38DECODER U_38DECODER(
        .a(a),
        .y(y)
    );
    initial begin
        a = 3'b000;
        #20;
        a = 3'b001;
        #20;
        a = 3'b010;
        #20;
        a = 3'b011;
        #20;
        a = 3'b100;
        #20;
        a = 3'b101;
        #20;
        a = 3'b110;
        #20;
        a = 3'b111;
        #20;
        $finish;
    end
endmodule
