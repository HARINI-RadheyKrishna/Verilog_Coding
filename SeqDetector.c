module seqdet (input clk, input rstn, input in, output out);
    
    parameter IDLE    = 0, 
                S1    = 1,
                S10   = 2,
                S101  = 3,
                S1011 = 4;
    
    reg [2 : 0] state, next_state;
    reg out;
    //assign out = (state == S1011)? 1 : 0;

    always @ (posedge clk) begin
        if (!rstn)
            state <= IDLE;
        else begin
            state <= next_state;
            out <= (state == S1011)? out_temp : 0;
        end
    end
    
    always @ (in, state) begin
        case (state)
            IDLE: begin
                if (in)
                    next_state = S1;
                else 
                    next_state = IDLE;
            end 

            S1: begin
                if (!in)
                    next_state = S10;
                else
                    next_state = IDLE;
            end 

            S10: begin
                if (in)
                    next_state = S101;
                else
                    next_state = IDLE;
            end 

            S101: begin
                if (in)
                    next_state = S1011;
                else
                    next_state = IDLE;

            S1011: begin
                next_state = IDLE;
                out_temp = 1;
            end 
        endcase
    end 
endmodule