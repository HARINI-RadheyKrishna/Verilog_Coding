module ha (input a, b, output sum, carry);

    assign sum = a ^ b;
    assign carry = a & b;

    /* Another way is to use the always block

    module ha(input a, b, output reg sum, carry); 
// Always an output inside a procedural block should be of register type
        always @(a or b) begin
            {carry, sum} = a + b; 
        end
    endmodule

Register access for an always block - Why?
1. declaring a variable as register ensures that the 
memory accessing time is greatly reduced and improve
the timing of the design

2. Also, if the variable is used in a time-critical operation such as
high speed counter can reduce the risk of timing violations

3. When a variable is used within a loop, declaring it as a register
can improve the performance of the loop by reducing the number of
memory accesses.
    */

endmodule