

`timescale 1ns/1ps

module tb;

  reg CLK;
  reg [7:0] D_IN;
  reg RST;
  wire MATCH;
  integer filein, fileout;
  
  sequence_det u1 (
    .CLK(CLK),
    .D_IN(D_IN),
    .RST(RST),
    .MATCH(MATCH)
  );


  always #1 CLK = ~CLK; 

  initial begin
    CLK = 0;
    RST = 1;
    D_IN = 0; 

    filein = $fopen("pattern.in", "r");
    fileout = $fopen("seq.out", "w");

    #2; RST = 0; 
		$fwrite(fileout, "At time %4d ps, CLK=%4d, RST=%b, D_IN=%b, MATCH=%b \n", $time, CLK, RST, D_IN, MATCH);
		#2; RST = 0; 
		$fwrite(fileout, "At time %4d ps, CLK=%4d, RST=%b, D_IN=%b, MATCH=%b \n", $time, CLK, RST, D_IN, MATCH);
    #2; RST = 1; 
		$fwrite(fileout, "At time %4d ps, CLK=%4d, RST=%b, D_IN=%b, MATCH=%b \n", $time, CLK, RST, D_IN, MATCH);
		#2; RST = 1; 
		$fwrite(fileout, "At time %4d ps, CLK=%4d, RST=%b, D_IN=%b, MATCH=%b \n", $time, CLK, RST, D_IN, MATCH);
		#2; RST = 1; 
		$fwrite(fileout, "At time %4d ps, CLK=%4d, RST=%b, D_IN=%b, MATCH=%b \n", $time, CLK, RST, D_IN, MATCH);
		#2; RST = 1; 
		$fwrite(fileout, "At time %4d ps, CLK=%4d, RST=%b, D_IN=%b, MATCH=%b \n", $time, CLK, RST, D_IN, MATCH);
		RST = 0; 


    while (!$feof(filein)) begin
  
      $fscanf(filein, "%b", D_IN);
      #2;
      $fwrite(fileout, "At time %4d ps, CLK=%4d, RST=%b, D_IN=%b, MATCH=%b \n", $time, CLK, RST, D_IN, MATCH);
  
    end

    $fclose(filein);
    $fclose(fileout);    

    $finish;
  end

endmodule