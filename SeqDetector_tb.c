module tb;

    reg in, out, rstn, clk;
    integer i;

    seqdet (.clk(clk), .rstn(rstn), .in(in), .out(out));

    initial begin
        clk <= 0;
        rstn <= 0;
        in <= 0;
    end 

    always #10 clk = ~clk;


    always @ (posedge clk) rstn <= 1;

    always @ (posedge clk) in <= 1;
    always @ (posedge clk) in <= 0;
    always @ (posedge clk) in <= 1;
    always @ (posedge clk) in <= 1;
    always @ (posedge clk) in <= 0;
    always @ (posedge clk) in <= 1;
    always @ (posedge clk) in <= 1;
    always @ (posedge clk) in <= 0;
    always @ (posedge clk) in <= 1;
    always @ (posedge clk) in <= 1;

    #500 $finish;
endmodule 