// Code your design here
module ones(
  input [15:0] number,
  output reg [3:0] count);
  
  reg [15:0] temp;
  reg [4:0] i;
  reg [15:0] binary;
   
  always @(*) begin
    temp = number;
    binary = 0;
    
    for (i = 0; i < 16; i = i + 1) begin
      binary[i] = temp[0];
      temp = temp >> 1;
    end
    
    count = binary[15] + binary[14] + binary[13] + binary[12] +
    binary[11] + binary[10] + binary[9] + binary[8] +
    binary[7] + binary[6] + binary[5] + binary[4] +
    binary[3] + binary[2] + binary[1] + binary[0];
  end
endmodule 