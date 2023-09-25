
module coin_return (input wire start, 
                    input wire clk, 
                    input wire reset, 
                    input wire avail_B, 
                    input wire avail_Q, 
                    input wire avail_D, 
                    input wire avail_N, 
                    input wire avail_P, 
                    output reg disp_B, 
                    output reg disp_Q, 
                    output reg disp_D, 
                    output reg disp_N, 
                    output reg disp_P,
                    output reg done
                    );

    wire [8:0] change;
    reg next_state, state;

    parameter IDLE = 2'b00;
    parameter START = 2'b01;
    parameter DISPENSE = 2'b10;
    parameter DONE = 2'b11;

    assign cash = {avail_B, avail_Q, avail_D, avail_N, avail_P};

    always @ (posedge clk, posedge reset) begin

        if (reset) begin

            disp_B <= 1'b0;
            disp_Q <= 1'b0;
            disp_D <= 1'b0;
            disp_N <= 1'b0;
            disp_P <= 1'b0;
            done <= 1'b0;
            state <= START;
        end else begin
            state <= next_state;
        end
    end

    always @(*) begin
        case (state)

            START: begin
                done <= 1'b0;
                disp_B <= 1'b0;
                disp_Q <= 1'b0;
                disp_D <= 1'b0;
                disp_N <= 1'b0;
                disp_P <= 1'b0;
                next_state = DISPENSE;
            end 

            DISPENSE: begin
                case (cash)
                    5'b1xxxx: begin
                        disp_B <= 1;
                        next_state = DONE;
                    end
                    5'b01xxx: begin 
                        disp_Q <= 1;
                        next_state = DONE;
                    end 
                    5'b001xx: begin
                        disp_D <= 1;
                        next_state = DONE;
                    end
                    5'b0001x: begin
                        disp_N <= 1;
                        next_state = DONE;
                    end 
                    5'b00001: begin
                        disp_P <= 1;
                        next_state = DONE;
                    end
                    default: begin
                        next_state = IDLE;
                        disp_B <= 1'b0;
                        disp_Q <= 1'b0;
                        disp_D <= 1'b0;
                        disp_N <= 1'b0;
                        disp_P <= 1'b0;
                    end 
                endcase
            end 
            
            DONE: begin
                done <= 1'b1;
                if (start)
                    next_state = START;
            end 

            IDLE: begin
                done <= 1'b1;
                disp_B <= 1'b0;
                disp_Q <= 1'b0;
                disp_D <= 1'b0;
                disp_N <= 1'b0;
                disp_P <= 1'b0;
                if (cash)
                    next_state = DISPENSE;
            end   
        endcase
    end 
endmodule 