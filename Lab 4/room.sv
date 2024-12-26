module room (input logic clk, n, s, e, w, v, reset, output logic s6, win, s5, d, s4, s3, sw, s2, s1, s0);
 
	 
	logic s0in = 1'b1, s1in =1'b0, s2in=1'b0, s3in=1'b0, s4in=1'b0, s5in=1'b0, s6in=1'b0, swin=1'b0, winin=1'b0, din=1'b0;
	 
	typedef enum {S0, S1, S2, S3, S4, S5, S6} statetype;
	statetype state, nextstate;
	 
	always_ff @(posedge clk) begin
    	if(reset) begin  
    	state <= S0;
    	end
    	else state<=nextstate;
	end
	 
    	always_comb begin
    	 
            	winin = 1'b0;
            	din = 1'b0;
            	swin = 1'b0;
 
    	case (state)
        	S0: begin
        	if(e) begin  
            	nextstate = S1;
        	end
        	else nextstate = S0;
        	end
        	 
        	S1: begin
            	if(s) begin
                	 
                	nextstate = S2;
            	end
            	else if(w) begin
                	 
 
                	nextstate <= S0;
            	end
            	else nextstate = S1;
        	end
        	 
        	S2: begin
            	if(n) begin
 
                	nextstate = S1;
                	 
            	end
            	else if(w) begin
                	nextstate = S3;
                	 
            	end
            	else if(e & s) begin
                	 
                	nextstate = S4;
            	end
            	else nextstate = S2;
        	end
        	 
        	S3: begin
            	 
            	if(e) begin
                	swin=1'b1;
 
                	nextstate=S2;
            	end
            	else nextstate = S3;
        	end  
        	 
        	S4: begin
            	 
            	if(v) begin
                	winin = 1'b1;
	 
                	nextstate = S5;
            	end
            	else if (~v) begin
                	 
                	din = 1'b1;
    	 
                	nextstate = S6;
            	end
            	else nextstate = S4;
            	 
        	end
        	 
			 S5: begin
        	winin = 1'b1;
        	nextstate = S5;
        	end
        	 
        	S6: begin  
        	din = 1'b1;
        	nextstate = S6;
        	end
        	 
      
        	default: begin
            	winin = 1'b0;
            	din = 1'b0;
            	swin = 1'b0;
            	nextstate = S0;
        	end
        	 
        	 
    	endcase	 
    	 
    	 
	end  
 
            	assign s6in = (nextstate == S6);
            	assign s5in = (nextstate == S5);
            	assign s4in = (nextstate == S4);
            	assign s3in = (nextstate == S3);
            	assign s2in = (nextstate == S2);
            	assign s1in = (nextstate == S1);
            	assign s0in = (nextstate == S0);
            	 
    	d_ff dflips0(s0in, clk, s0);
    	d_ff dflips1(s1in, clk, s1);
    	d_ff dflips2(s2in, clk, s2);
    	d_ff dflips3(s3in, clk, s3);
    	d_ff dflips4(s4in, clk, s4);
    	d_ff dflips5(s5in, clk, s5);
    	d_ff dflips6(s6in, clk, s6);
    	d_ff dflipsw(swin, clk, sw);
    	d_ff dflipwin(winin, clk, win);
    	d_ff dflipd(din, clk, d);
    	 
    	 
endmodule
