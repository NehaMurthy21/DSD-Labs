module d_ff(input logic d, clk,
output logic q);

always @ (posedge clk) begin
	q <= d; // Setting state to d on clock edge
end 
endmodule 