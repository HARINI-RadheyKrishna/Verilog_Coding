module Top;
  reg [15:0] number;
  reg [3:0] count;

  ones u1 (.number(number), .count(count));
  
  initial begin
    number = $urandom();
    #10;
    $display (number);
    $display(count);
  end
endmodule 