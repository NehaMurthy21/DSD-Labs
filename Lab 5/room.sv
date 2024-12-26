module room( input logic clk,n,s,e,w,v,reset, 
output logic s6,win,s5,d,s4,s3,sw,s2,s1,s0);

logic prevs0, prevs1,prevs2,prevs3,prevs4,prevs5,prevs6;

//D-FF entity connection
d_ff dffs0(prevs0,clk,s0);
d_ff dffs1(prevs1,clk,s1);
d_ff dffs2(prevs2,clk,s2);
d_ff dffs3(prevs3,clk,s3);
d_ff dffs4(prevs4,clk,s4);
d_ff dffs5(prevs5,clk,s5);
d_ff dffs6(prevs6,clk,s6);

always_comb begin
//assign each previous state to a state
	prevs0=s0;
	prevs1=s1;
	prevs2=s2;
	prevs3=s3;
	prevs4=s4;
	prevs5=s5;
	prevs6=s6;
//previous state equations
prevs0 = (~reset & w & s1) | (reset) | (s0 & ~reset & ~e);
prevs1 = (~reset & s0 & e) | (~reset & s2 & n) | (~reset & s1 & ~s);
prevs2= (~reset & s & s1) | (~reset & s3 & e) | (~reset & s2 & ~(w|(e&s)));
prevs3 = (~reset & s2 & w) | (~reset & ~e & s3);
prevs4 = (~reset & s2 & e & s);
prevs5 = (~reset & s4 & v) | (s5 & ~reset);
prevs6 = (~reset & s4 & ~v) | (s6 & ~reset);

d=s6;
win=s5;
sw=s3;

end
endmodule




