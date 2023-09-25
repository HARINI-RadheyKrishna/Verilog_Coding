module shift_reg ( 
    input wire clk,
    input wire rst, 
    input wire shift, 
    input wire load, 
    input wire dir, 
    input wire [7:0] data, 
    input wire ser_in,
    output reg [7:0] q
);

    always @(posedge clk, posedge rst) begin
        if (rst)
            q <= 8'b0;
        else begin
            if (load) begin
                q <= data;
            end 
            else begin
                if (shift) begin
                    if (dir) begin
                        q[7] <= ser_in; //right shift
                        q[6:0] <= q[7:1];
                    end else begin
                        q[7:1] <= q[6:0]; //left shift
                        q[0] <= ser_in;
                end
                end
            end
        end
    end

endmodule 