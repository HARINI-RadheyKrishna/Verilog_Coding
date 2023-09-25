`timescale 1ns/1ps

module tb;
 
    reg clk; 
    reg rst;
    reg shift; 
    reg load; 
    reg dir;
    reg [7:0] data; 
    reg ser_in;
    wire [7:0] q;

    shift_reg u1 (
        .clk(clk), 
        .rst(rst), 
        .data(data), 
        .ser_in(ser_in), 
        .shift(shift), 
        .load(load), 
        .dir(dir), 
        .q(q)
    );

    always #1 clk = ~clk;

    initial 
    fork
        clk = 1;
        rst = 1;
        #2.2 rst = 0;
        #9 rst = 1;
        #10.2 rst = 0;
        load = 1;
        #4.2 load = 0;
        shift = 1;
        #8.2 shift = 0;
        data = 8'b10101010;
        dir = 0;
        #6.2 dir = 1;
        ser_in = 0;
        #6.2 ser_in = 1;
        #12 $finish;
    join


    reg [31:0] file;
    initial 
    begin
        file = $fopen("shift_reg.out");
        $fmonitor(file, "At time %d ns, clk=%b, rst=%b, load=%b, shift=%b, data=%b, dir=%b, ser_in=%b, q=%b", 
            $time, clk, rst, load, shift, data, dir, ser_in, q);
        #12 $fclose(file);
    end
endmodule