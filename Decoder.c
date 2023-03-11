module decoder3x8(input en, input [3:0] in, output [15:0] out);

    wire decode = 1 << in; // 1 will be shifted by the number given by the value of in; 
    // For eg. if the input value is 12 then 1 will be left shifted to 12 bits which is, 0001 0000 0000 0000 in binary; 
    assign out = en ? decode : 0;

endmodule