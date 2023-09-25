

module tap_controller (
    input wire TCK,
    input wire TRST,
    input wire TMS,
    output reg [3:0] STATE 
);

    parameter Test_logic_reset = 4'b0000;
    parameter Run_test_idle = 4'b0001;
    parameter Select_DR_Scan = 4'b0010;
    parameter Capture_DR = 4'b0011;
    parameter Shift_DR = 4'b0100;
    parameter Exit1_DR = 4'b0101;
    parameter Pause_DR = 4'b0110;
    parameter Exit2_DR = 4'b0111;
    parameter Update_DR = 4'b1000;
    parameter Select_IR_Scan = 4'b1001;
    parameter Capture_IR = 4'b1010;
    parameter Shift_IR = 4'b1011;
    parameter Exit1_IR = 4'b1100;
    parameter Pause_IR = 4'b1101;
    parameter Exit2_IR = 4'b1110;
    parameter Update_IR = 4'b1111;

    always @(posedge TCK) begin

        if (TRST)
            STATE <= Test_logic_reset;

        else begin
            case (STATE) 

                Test_logic_reset: STATE <= (TMS)? Run_test_idle : Test_logic_reset; 
                Run_test_idle: STATE <= (TMS)? Select_DR_Scan : Run_test_idle;
                Select_DR_Scan: STATE <= (TMS)? Select_IR_Scan : Capture_DR;
                Capture_DR: STATE <= (TMS)? Exit1_DR : Shift_DR;
                
                Shift_DR: STATE <= (TMS)? Exit1_DR : Shift_DR;
                Exit1_DR: STATE <= (TMS)? Update_DR : Pause_DR;
                Pause_DR: STATE <= (TMS)? Exit2_DR : Pause_DR;
                Exit2_DR: STATE <= (TMS)? Update_DR : Shift_DR;
                
                Update_DR: STATE <= (TMS)? Select_DR_Scan : Run_test_idle;
                Select_IR_Scan: STATE <= (TMS)? Test_logic_reset : Capture_IR;
                Capture_IR: STATE <= (TMS)? Exit1_IR : Shift_IR;
                Shift_IR: STATE <= (TMS)? Exit1_IR : Shift_IR;
                
                Exit1_IR: STATE <= (TMS)? Update_IR : Pause_IR;
                Pause_IR: STATE <= (TMS)? Exit2_IR : Pause_IR;
                Exit2_IR: STATE <= (TMS)? Update_IR : Shift_IR;
                Update_IR: STATE <= (TMS)? Select_DR_Scan : Run_test_idle;
                
                default: STATE <= Test_logic_reset;

            endcase
        end
    end
endmodule 