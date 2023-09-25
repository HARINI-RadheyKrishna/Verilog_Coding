module dff_delta(clk, rst, en, d, q);

    input clk, rst, en, d;
    output reg q;

    always @(negedge clk, negedge rst) begin 

        if (~rst) begin
            q <= 1'b0;
        end    
        
        else begin
            if (~en)
                q <= d;
        end 
    end
endmodule 
