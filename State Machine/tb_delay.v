module tb();

  // Declare signals for testbench
  reg A;
  reg B;
  wire out1;
  wire out2;
  wire out3;
  wire out4;
  wire out5;

  // Instantiate the OR gate models
  or_gate_inertial_blocking u1 (.A(A), .B(B), .out1(out1));
  or_gate_inertial_non_blocking u2 (.A(A), .B(B), .out2(out2));
  or_gate_transport_blocking u3 (.A(A), .B(B), .out3(out3));
  or_gate_transport_non_blocking u4 (.A(A), .B(B), .out4(out4));
  or_gate_continuous u5 (.A(A), .B(B), .out5(out5));

  // Generate stimulus
  initial begin
    $display("Starting simulation...");
    $monitor("At time %t ns, A = %b, B = %b, out1 = %b, out2 = %b, out3 = %b, out4 = %b, out5 = %b", $time, A, B, out1, out2, out3, out4, out5);

    // Apply stimulus
    #0 A = 1; B = 1;
    #4 A = 1; B = 0;
    #3 A = 0; B = 0;
    #4 A = 0; B = 1;
    #3 A = 0; B = 0;
    #20 $finish;
  end

endmodule
