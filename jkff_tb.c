module tb;

    reg j, k, rstn, clk;
    wire q, qbar;
    integer i;
    reg [3:0] delaynum;

    always #10 clk = ~clk; // This statement toggles the clock from 0 -> 1 or vv every 10 simulation time units
                          // which means that the time period of the clock is 20 simulation time units
    jk u0 (.j(j), .k(k), .clk(clk), .rstn(rstn), .q(q), .qbar(qbar));
    
    initial begin // This is the beginning of a combinational block statement
        {j, k, clk, rstn} <= 0;
        #10 rstn <= 1;

        for (i = 0; i < 10; i = i + 1) begin
            delaynum = $random;
            #(delaynum) j <= $random;
            #(delaynum) k <= $random;
        end 
        #20 $finish; //This line terminates the simulation so it must be used with caution
    end 
endmodule