`timescale 1ns/1ps

module tb;

    reg clk = 0; 
    reg rst_a, d_a, en_a;
    wire d_b, d_d, d_g, rst_b, rst_d, rst_g, en_b, en_g, en_d;
    wire q_a, q_b, q_d, q_g;

    dff_alpha u1 (.clk(clk), .rst(rst_a), .en(en_a), .d(d_a), .q(q_a));
    dff_beta u2 (.clk(clk), .rst(rst_b), .en(en_b), .d(d_b), .q(q_b));
    dff_delta u3 (.clk(clk), .rst(rst_d), .en(en_d), .d(d_d), .q(q_d));
    dff_gamma u4 (.clk(clk), .rst(rst_g), .en(en_g), .d(d_g), .q(q_g));
  
    always #5 clk = ~clk;

    assign d_b = d_a;
    assign rst_b = rst_a;
    assign en_b = ~en_a;

    assign d_g = d_a;
    assign rst_g = ~rst_a;
    assign en_g = en_a;

    assign d_d = d_a;
    assign rst_d = ~rst_a;
    assign en_d = ~en_a;

    initial begin 
        rst_a = 1'b1;

        #52 rst_a = 1'b0;
        #95 rst_a = 1'b0;

        en_a = 1'b0;

        #72 en_a = 1;
        #92 en_a = 0;
        #112 en_a = 1;

        d_a = 1'b0;

        #55 d_a = 1'b0;
        #65 d_a = 1'b0;
        #75 d_a = 1'b0;
        #85 d_a = 1'b0;
        #95 d_a = 1'b0;
        #105 d_a = 1'b0;
        #115 d_a = 1'b0;
        #125 d_a = 1'b0;
        #135 $finish;
    end 

    reg [31:0] the_file_alpha, the_file_beta, the_file_gamma, the_file_delta;
    initial begin
        the_file_alpha = $fopen("dff_alpha.out", "w");
        $fdisplay(the_file_alpha, "The simulation reports for dff_alpha: ");
        $fmonitor(the_file_alpha, "At time %d ns, clk = %b, rst = %b, en = %b, d = %b, q = %b", $time, clk, rst_a, en_a, d_a, q_a);
        
        the_file_beta = $fopen("dff_beta.out", "w");
        $fdisplay(the_file_beta, "The simulation reports for dff_beta: ");
        $fmonitor(the_file_beta, "At time %d ns, clk = %b, rst = %b, en = %b, d = %b, q = %b", $time, clk, rst_b, en_b, d_b, q_b);   
        
        the_file_gamma = $fopen("dff_gamma.out", "w");
        $fdisplay(the_file_gamma, "The simulation reports for dff_gamma: ");
        $fmonitor(the_file_gamma, "At time %d ns, clk = %b, rst = %b, en = %b, d = %b, q = %b", $time, clk, rst_g, en_g, d_g, q_g);    
        
        the_file_delta = $fopen("dff_delta.out", "w");
        $fdisplay(the_file_delta, "The simulation reports for dff_delta: ");
        $fmonitor(the_file_delta, "At time %d ns, clk = %b, rst = %b, en = %b, d = %b, q = %b", $time, clk, rst_d, en_d, d_d, q_d);
        
        #135 $fclose(the_file_alpha);
        #135 $fclose(the_file_beta);
        #135 $fclose(the_file_gamma);
        #135 $fclose(the_file_delta);
        $finish;
    end

endmodule