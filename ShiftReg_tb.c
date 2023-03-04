module tb;

    reg d, q;
    wire rstneg, clk;

    dff inst3(.d(d), .clk(clk), .rstneg(rstneg), .q(q));

    initial begin
        d <= 0;
        clk <= 0;
        rstneg <= 0;

        $monitor ("d = %0b clk = %0b rstneg = %0b q = %0b", d, clk, rstneg, q);

        for (i = 0; i< 8; i = i + 1)
            {rstneg, d, clk} = i; 
            #10;
        end
    end
endmodule