module tb;
    reg A, B;
    wire sum, carry;
    integer i;


    ha u0(.a(a), .b(b), .sum(sum), .carry(carry));
    initial begin

        a <= 0;
        b <= 0;

        $monitor ("a = %0b, b = %0b, sum = %0b, carry = %0b", a, b, sum, carry);

        for (i = 0; i < 4; i = i+1) begin
            {a, b} = i;
            #10;
        end
    end 
endmodule