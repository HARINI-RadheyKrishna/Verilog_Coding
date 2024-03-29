module tb;
    reg f;
    reg [1:0] sel;
    wire a, b, c, d;
    integer i;

    demux1x4 u0 (.f(f), .sel(sel), .a(a), .b(b), .c(c), .d(d));
    intial begin

        f <= 0;
        sel <= 0;
        
        $monitor ("f = %0b, sel = %0b, a = %0b, b = %0b, c = %0b, d = %0b");

        for(i = 0; i < 8; i = i + 1) 
        begin
            {f, sel} = i;
            #10;

        end
    end
endmodule

