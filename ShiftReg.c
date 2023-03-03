module dff (input d, input clk, input rstneg, output q);
	always @ (posedge clk) begin
		if (!rstneg)
			q <= 0;
		else
			q <= d;	
	end
endmodule

module shiftreg (input d, input clk, input rstneg, output q);
wire [2:0] q[2];
dff inst1 (.d(d), .clk(clk), .rstneg(rstneg), .q(q[0]));
dff inst2 (.d(q[0]), .clk(clk), .rstneg(rstneg), .q(q[1]));
dff inst2 (.d(q[1]), .clk(clk), .rstneg(rstneg), .q(q[2]));
dff inst2 (.d(q[2]), .clk(clk), .rstneg(rstneg), .q(q));
endmodule 