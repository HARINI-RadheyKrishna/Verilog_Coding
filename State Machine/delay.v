module or_gate_inertial_blocking(
  input A, 
  input B, 
  output reg out1
);
  integer file;
  reg A_reg, B_reg;
  initial begin
  	file = $fopen("delay.out", "w");
  	$fclose(file);
  end

  always @(A, B) begin
    file = $fopen("delay.out", "a");
    if (file != 0) begin
      A_reg = 1'b0;
      B_reg = 1'b0;
      #4 out1 = A | B;
      $fwrite(file, "At time %t ns, A = %b, B = %b, out1 = %b", $time, A_reg, B_reg, out1);
      $fclose(file); // Close the file
      //#20 $finish;
    end else begin
      $display("Error: Unable to open delay.out for writing.");
    end
  end

endmodule

// Similar corrections for the other modules...


module or_gate_inertial_non_blocking(
  input A, 
  input B, 
  output reg out2
);
  integer file;

  always @(A, B) begin
    file = $fopen("delay.out", "a");
    if (file != 0) begin
    #4 out2 <= A | B;
    $fwrite(file, "At time %t ns, A = %b, B = %b, out2 = %b", $time, A, B, out2);
      $fclose(file); // Close the file
      //#20 $finish;
    end else begin
      $display("Error: Unable to open delay.out for writing.");
    end
  end

endmodule

module or_gate_transport_blocking(
  input A, 
  input B, 
  output reg out3
);
  integer file;
  reg A_reg, B_reg;

  always @(A, B) begin
    file = $fopen("delay.out", "a");
    if (file != 0) begin
    	A_reg = 1'b0;
    	B_reg = 1'b0;
    	out3 = #4 A_reg | B_reg;
    	$fwrite(file, "At time %t ns, A = %b, B = %b, out3 = %b", $time, A_reg, B_reg, out3);
    	$fclose(file); // Close the file
      //#20 $finish;
    end else begin
      $display("Error: Unable to open delay.out for writing.");
    end
  end

endmodule


module or_gate_transport_non_blocking(
  input A, 
  input B, 
  output reg out4
);
  integer file;

  always @(A, B) begin
    file = $fopen("delay.out", "a");
    if (file != 0) begin
    	out4 <= #4 A | B;
    	$fwrite(file, "At time %t ns, A = %b, B = %b, out4 = %b", $time, A, B, out4);
	$fclose(file); // Close the file
      //#20 $finish;
    end else begin
      $display("Error: Unable to open delay.out for writing.");
    end
  end

endmodule

module or_gate_continuous(
  input A, 
  input B, 
  output reg out5
);
  reg A_reg, B_reg;
  integer file;

  always @(A, B) begin
    file = $fopen("delay.out", "a");
    if (file != 0) begin
    	#4 assign out5 = A | B;
    	$fwrite(file, "At time %t ns, A = %b, B = %b, out5 = %b", $time, A, B, out5);
	$fclose(file); // Close the file
      #20 $finish;
    end else begin
      $display("Error: Unable to open delay.out for writing.");
    end
  end

endmodule
