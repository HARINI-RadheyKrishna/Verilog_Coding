module tb;

    reg d, q;
    wire rstneg, clk;

    dff inst3(.d(d1), .clk(clk1), .rstneg(rstneg1), .q(q1));

    initial begin
        d1 <= 0;
        clk1 <= 0;
        rstneg1 <= 0;

        $monitor ("d = %0b clk = %0b rstneg = %0b q = %0b", d1, clk1, rstneg1, q1);

        for (i = 0; i< 8; i = i + 1)
            {rstneg1, d1, clk1} = i; 
            #10;
        end
    end

    // shiftreg(.d(d2), .clk(clk2), .rstneg(rstneg2), .q(q2));

    // initial begin
    //     d2 <= 0;
    //     clk2 <= 0;
    //     rstneg2 <= 0;

    //     $monitor ("d = %0b clk = %0b rstneg = %0b q = %0b", d1, clk1, rstneg1, q1);

    //     for (ii = 0; ii < 8; ii = ii + 1)
    //         {rstneg2, d2, clk2} = ii; 
    //         #10;
    //     end
    // end
endmodule