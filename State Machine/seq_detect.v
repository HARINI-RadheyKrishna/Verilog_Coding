module shift_reg (
    input wire clk, 
    input wire rst, 
    input wire [7:0] data,
    input wire shift,
    input wire load,
    input wire dir,
    input wire ser_in,
    output reg [7:0] q
);
    wire [2:0] sel;

    assign sel = {load, shift, dir};

    always @(sel) begin
        if (rst)
            q <= 8'b0;
        else begin
            case (sel)
                3'b1xx : q <= data;
                3'b011 : q <= {data[6:0], ser_in};
                3'b010 : q <= {ser_in, data[7:1]};
                default : q <= q;
            endcase
        end
    end
endmodule

module sequence_det(
    input wire CLK,
    input wire [7:0] D_IN,
    input wire RST,
    output wire MATCH
);
    wire [7:0] q;

    shift_reg u1 (
        .clk(CLK), 
        .rst(RST), 
        .data(D_IN), 
        .shift(1'b1), 
        .load(1'b0), 
        .dir(1'b0),
        .ser_in(D_IN[0]),
        .q(q)
    );

    assign MATCH = ((RST)?0:(q==8'b1101_0101));

endmodule