module fifo_spi(input rstn, 
            input sys_clk,
            input spi_clk,
            inout mosi,
            inout miso_q,
            output flag_q1); //Module definition

//Parameters initialisation
    reg mosi, miso_q, rstn, sys_clk, spi_clk;
    reg [2:0] rp, wp, rp_q, wp_q;
    reg [0:7] fifo [7:0];
    reg [0:7] miso_q; //8-bit output data from the slave
    reg [0:7] mosi; //8-bit output data from the master
    reg [2:0] depth_inference, old_depth;
    reg flag_w, busy_flag;
    wire flag_q1, miso, empty, full, flag_q, state_q, state_q1;

    always @(*) begin //Here, we are resetting all the parameters to the initial values thereby clearing all the registers and wires so as to prepare for a new sequence of operations
        if (!rstn) begin
            rp = 1'b0;
            wp = 1'b0;
            old_depth = 1'b0;
            depth_inference = 1'b0;
            full = 1'b0;
            empty = 1'b0;
            fifo = 1'b0;
            busy_flag = 1'b0;
            flag_w = 1'b0;
            state1 = IDLE1;
            state = IDLE;
            state_q = state;
            state_q1 = state1;
        end 

        else begin
            case (state) //This case determines the next location of the fifo output, from where the data needs to be read and what happens if the fifo becomes full and how to raise a flag to denote back pressure
                IDLE: begin //This is the idle state of the processor where no reading takes place and the fifo is not read 
                    rp = 1'b0;
                    state = READ;
                    busy_flag = 1'b0;
                end 

                READ: begin //This is where the reading from the fifo takes place based on if the fifo is full or not. If the fifo is full, it means that there will be missing data as the master keeps on sending the data but there is no space for storing the new data.
                //So, in this case, the slave raises a busy flag thereby denoting the back pressure scenario to the master 
                    if ((depth_inference >= 6) & (old_depth == 0)) begin
                        miso = fifo[rp];
                        rp = rp + 1;
                        state = IDLE;
                        busy_flag = 1'b1; //THIS FLAG IF HIGH DENOTES BACK PRESSURE IN THE SLAVE AS THERE IS NO SPACE IN THE FIFO TO FILL THE INCOMING DATA AND IT RAISES THE FLAG CALLED BUSY
                    end 

                    else if ((depth_inference < 2) & (old_depth == 0)) begin
                        empty = 1'b1;
                        busy_flag = 1'b0; 
                        state = IDLE;
                    end 

                    else begin
                        busy_flag = 1'b0;
                        empty = 1'b0;
                        miso = fifo[rp];
                        rp = rp + 1;
                        state = IDLE;
                    end 
                end 
            endcase
        
            case (state1) //This case determines what is the next location of the fifo from the master point of view and this is synchronized later with the writing clock domain
                IDLE1: begin //No write operation occur and the fifo is idle except for the read operation as it is synchronized with another clcok domain
                    wp = 1'b0;
                    state1 = WRITE;
                    flag_w = 1'b0;
                end 

                WRITE: begin //This state helps to write data into the fifo after assessing if there is enough space or not in the fifo to accommodate new data.
                //And if the fifo is empty and the master has no new data to write, then the processor goes into idle state.
                    if ((depth_inference_w >= 6) & (old_depth == 0)) begin
                        full = 1'b1; // If the master is full then the data is held on until the fifo becomes empty. Until then the slave responds by sending a high busy pulse as flag. 
                        flag_w = 1'b1;
                        state = IDLE;
                    end 

                    else if ((depth_inference_w < 2) & (old_depth == 0)) begin
                        flag_w = 1'b0;
                        fifo[wp] = mosi;
                        wp = wp + 1;
                        state = IDLE; 
                    end 

                    else begin
                        flag_w = 1'b0;
                        full = 1'b0;
                        fifo[wp] = mosi;
                        wp = wp + 1;
                        state = IDLE;
                    end 
                end 
            endcase 
        end
    end

    always @ (posedge spi_clk) begin     //To update the contents of the fifo on every positive edge of the spi clock
        miso_q <= miso; //Registered output from the slave
        rp_q <= rp; //Registered pointer output of the fifo
        old_depth <= depth_inference;   //This provides the most recent value of the depth. i.e. the depth value in the previous clock
        depth_inference <= wp_q - rp_q;  //The depth value is the number of populated spaces in the fifo.
        flag_q <= busy_flag; //Registered flag output
        state_q <= state; //Registered state output
    end 

    always @ (posedge sys_clk) begin    //To update the contents of the fifo on every positive edge of the system clock
        wp_q <= wp; //Registered pointer output of the fifo
        fifo_q[wp_q] <= fifo[wp_q]; //Registered fifo output from the master
        old_depth <= depth_inference;
        depth_inference <= wp_q - rp_q;
        flag_q1 <= flag_w;
        state_q1 <= state1;
    end  
endmodule