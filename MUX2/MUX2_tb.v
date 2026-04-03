`timescale 1ns/1ns
module MUX2_tb();
    
    reg a;
    reg b;
    reg sel;
    wire out;

    MUX2 U_MUX2(
        .a(a),
        .b(b),
        .sel(sel),
        .out(out)
    );
    
    initial begin
        a = 0; b = 0; sel = 0;
        #20
        a = 0; b = 0; sel = 1;
        #20
        a = 0; b = 1; sel = 0;
        #20
        a = 0; b = 1; sel = 1;
        #20
        a = 1; b = 0; sel = 0;
        #20
        a = 1; b = 0; sel = 1;
        #20
        a = 1; b = 1; sel = 0;
        #20
        a = 1; b = 1; sel = 1;
        #20
    end

endmodule
