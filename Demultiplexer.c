module demux1x4(input f, input [1:0] sel, output a, b, c, d);

    assign a = f & (~sel[0] & ~sel[1]);
    assign b = f & (sel[0] & ~sel[1]);
    assign c = f & (~sel[0] & sel[1]);
    assign d = f & (sel[0] & sel[1]);

endmodule