module dff (input d, input clk, input rstneg, output q);
	always @ (posedge clk or rstneg) begin
		if (!rstneg)
			q <= 0;
		else
			q <= d;	
	end
endmodule

module shiftreg (input d, input clk, input rstneg, output q); // Here output q is by default a wire type and is not a register
	wire [2:0] q[2]; // Wire of array datatype and not a register as the output from one ff is connected to the input of the next ff through wire and not register
	dff inst1 (.d(d), .clk(clk), .rstneg(rstneg), .q(q[0]));
	dff inst2 (.d(q[0]), .clk(clk), .rstneg(rstneg), .q(q[1]));
	dff inst2 (.d(q[1]), .clk(clk), .rstneg(rstneg), .q(q[2]));
	dff inst2 (.d(q[2]), .clk(clk), .rstneg(rstneg), .q(q));
endmodule 
