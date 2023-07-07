module jk(input j, k, clk, rstn, output q, qbar);

    always @ (posedge clk, negedge rstn) begin
        if (!rstn) begin
            q <= 0;
            qbar <= 1;
        end
        else begin
            temp = ((j & qbar) | (~k & q)); // For SR Latch this line will change to (s | (~r & q))
            q <= temp;
            qbar <= ~temp;
        end 
    end 
endmodule
