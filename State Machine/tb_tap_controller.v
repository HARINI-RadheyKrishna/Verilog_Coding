

`timescale 1ns/10ps

module tb;
  reg TCLK;
  reg TRST;
  reg TMS;
  wire [3:0] STATE;
  reg [31:0] tap_controller_outfile;
  integer file;

  tap_controller u1 (
    .TCK(TCLK),
    .TRST(TRST),
    .TMS(TMS),
    .STATE(STATE)
  );

  always #25 TCLK = ~TCLK;

  initial fork

    TCLK = 0;
    TRST = 1;
    TMS = 1;
    
    #50 TRST = 0;

    #100 TMS = 0; 

    #150 TMS = 1;
    #200 TMS = 0; 

    #250 TMS = 0;
    #300 TMS = 1;

    #350 TMS = 0;
    #400 TMS = 1;

    #450 TMS = 1;
    #500 TMS = 0;

    #550 TMS = 0;
    #600 TMS = 1;

//Second sequence
    #650 TMS = 1; 
    #700 TMS = 0;

    #750 TMS = 0;
    #800 TMS = 1;

    #850 TMS = 0; 
    #900 TMS = 1; 

    #950 TMS = 1; 
    #1000 TMS = 0; 

    #1050 TMS = 1; 
    #1100 TMS = 1;

    #1150 TMS = 1;
    #1200 TMS = 1;


    #1250 $finish;
  join

  initial begin
    tap_controller_outfile = $fopen("tap_controller.out", "w");
    $fmonitor(tap_controller_outfile, "At time %d ns, TMS=%b, TCLK =%b, TRST = %b, STATE=%b", $time, TMS, TCLK, TRST, STATE);
  end

endmodule