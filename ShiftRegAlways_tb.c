module tb;

    reg d, clk, rstn;
    reg [3 : 0] out;
    integer i;
    
    lshift u0 (.d(d), .clk(clk), .rstn(rstn), .out(out));

    always #10 clk = ~clk;

    initial begin
        {d, clk, rstn} <= 0;

        #10 rstn <= 1;

        for (i = 0; i < 20; i = i + 1) begin
            @(posedge clk) d <= $random;
        end

        #20 $finish;
    end 
endmodule