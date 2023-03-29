module tb;
    reg rstn, sys_clk, spi_clk;
    reg [0:7] miso_q;
    reg [0:7] mosi;
    reg flag_q1;
    integer i, k, j;

    fifo_spi u0(.rstn(rstn), .sys_clk(sys_clk), .spi_clk(spi_clk), 
                .mosi(mosi), .miso_q(miso_q), .flag_q1(flag_q1)); //Module instantiation

    initial begin
        mosi = 8'b0;
        miso_q = 8'b0;
        sys_clk = 0;
        spi_clk = 0;
        flag_q1 = 0;
        while(1) begin
            for (j = 0; j <= 10000 ; j= j + 1) begin
                sys_clk = ~sys_clk;
            end 
        end 

        while(1) begin
            for (k = 0; k <= 10000; k = k + 1) begin
                spi_clk = ~spi_clk;
            end 

        for (i = 0; i < 8; i = i + 1) begin
            mosi = 8'b$random;
            #10
        end 
        if (i >= 8) begin // Corner case to test when the FIFO is full
            mosi = 8'b$random;
            $monitor ("mosi = %0b miso = %0b flag = %0b", mosi, miso_q, flag_q1); //Gives the current state of the mosi and miso pins of the master and slave respectively
            //The above 2 lines of code is to check how the data is being handled when the fifo is full 
        end
    end 
endmodule