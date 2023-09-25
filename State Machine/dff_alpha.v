module dff_alpha(clk, rst, en, d, q);

    input clk, rst, en, d;
    output reg q;

    always @(negedge clk, posedge rst) begin 

        if (rst) begin
            q <= 1'b0;
        end    
        
        else begin
            if (en)
                q <= d;
        end 
    end
endmodule 
