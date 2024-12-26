module sword (input logic sw, reset, clk, 
output logic v);

	logic s0,s1,vout,nexts0,nexts1;

	d_ff dffs1 (nexts1,clk,s1);
	d_ff dffs0 (nexts0,clk,s0);

	always_comb begin
		nexts0 = s0;
		nexts1 = s1;


		nexts0 = (~reset & ~sw & s0) | reset;
		nexts1 = (sw & ~reset & s0) | (s1 & ~reset);
		
		v = s1;
end
	

	
endmodule 

