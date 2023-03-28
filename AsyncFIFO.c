module asyncFIFO (input reg sys_clk, 
                    input reg spi_clk, 
                    input reg rstn, 
                    input reg spi_in, 
                    input reg wp, 
                    input reg rp, 
                    input reg flag, 
                    output reg full, 
                    output reg empty, 
                    output reg spi_out);

    assign rstn = 0;
    reg [7:0] fifo [0:7];
    reg [2:0] readdepth;
    reg [2:0] writedepth;
    reg [2:0] state, state1;

      
    always @ (*) begin
        if (!rstn) begin
            rp = 0;
            wp = 0;
            fifo = 0;
            flag = 0;
            state1 = START1;
            state = START;
        end

        case(state)
            START: begin
                rp = 0;
                flag = 0;
                fifo = 0;
                state = READ;
            end 

            READ: begin
                if (full) begin
                    wp = 0;
                    spi_out = fifo[rp];
                    rp = rp + 1;
                    readdepth = readdepth - 1;
                end 

                else begin
                    spi_out = fifo[rp];
                    flag = 0;
                    rp = rp + 1;
                    readdepth = readdepth - 1;
                end 
            end 
        endcase

        if (readdepth == 0) begin
            empty = 1'b1;
            flag = 1'b0;
        end
    
    
        case (state1)
            START1: begin
                wp <= 0;
                flag <= 0;
                fifo <= 0;
                state <= write;
            end 

            WRITE: begin
                if (empty) begin
                    rp = 0;
                    fifo[wp] = spi_in;
                    wp = wp + 1;
                    writedepth = writedepth +1;
                    flag = 0;
                end 

                else begin
                    fifo[wp] = spi_in;
                    wp = wp + 1;
                    writedepth = writedepth +1;
                    flag = 0;
                end
            end 
        endcase
        

        if (writedepth == 8) begin
            full = 1'b1;
            flag = 1'b1;
        end  
    end 

    always @(posedge spi_clk) begin

    end
endmodule 





        