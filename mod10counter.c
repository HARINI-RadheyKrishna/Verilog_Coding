module mod10(input clk, rstn, output o);

    always @(posedge clk, negedge rstn) begin
        if(!rstn) begin
            o <= 0;
        end 
        else begin
            if (o == 9) 
                o <= 0;
            else
                o <= o + 1;
        end 
    end 
endmodule
