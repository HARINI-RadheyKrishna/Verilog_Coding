module asyncFIFO (input sys_clk,
                    input spi_clk,
                    input rstn, 
                    input spi_in,
                    input wp,
                    input rp,
                    input flag,
                    output full,
                    output empty,
                    output spi_out);

    reg [7:0] fifo [0:7];
    reg [2:0] readdepth;
    reg [2:0] writedepth;
    reg [2:0] state, state1;

    if (!rstn) begin
        rp = 0;
        wp = 0;
        fifo = 0;
        flag = 0;
        state1 = start;
        state = start;
    end

    else begin
        always @ (posedge spi_clk) begin 
            case (state) begin
                start: begin
                    rp <= 0;
                    flag <= 0;
                    fifo <= 0;
                    state <= read;
                end 

                read: begin
                    if (full) begin
                        wp <= 0;
                        spi_out <= fifo[rp];
                        rp <= rp + 1;
                        readdepth <= readdepth - 1;
                    end 

                    else begin
                        spi_out <= fifo[rp];
                        flag <= 0;
                        rp <= rp + 1;
                        readdepth <= readdepth - 1;
                    end 
                end 
            endcase

            if (readdepth == 0) begin
                empty <= 1'b1;
                flag <= 1'b0;
            end
        end 

        always @ (posedge sys_clk) begin
            case (state1) begin
                start: begin
                    wp <= 0;
                    flag <= 0;
                    fifo <= 0;
                    state <= write;
                end 

                write: begin
                    if (empty) begin
                        rp <= 0;
                        fifo[wp] <= spi_in;
                        wp <= wp + 1;
                        writedepth <= writedepth +1;
                        flag <= 0;
                    end 

                    else begin
                        fifo[wp] <= spi_in;
                        wp <= wp + 1;
                        writedepth <= writedepth +1;
                        flag <= 0;
                    end
                end 
            endcase
        

            if (writedepth == 8) begin
                full <= 1'b1;
                flag <= 1'b1;
            end 
        end 
    end 
endmodule 





        