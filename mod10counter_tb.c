module tb;

    reg clk, rstn;
    wire o;
    //integer n = 10;

    mod10 u0 (.clk(clk), .rstn(rstn), .o(o));

    always #10 clk = ~clk;

    initial begin 
        {clk, rstn} <= 0;

        #10 rstn <= 1;
/* This code down here can be used if we want to redo the 
incrementation from 0 to 9 for n times.

        repeat (n) begin
            @(posedge clk);
        end 
        #10 $finish;  
        
else we can use the code below to indefinitely run the code till
the termination of the simulation time*/

        #1000 $finish;
    end 
endmodule