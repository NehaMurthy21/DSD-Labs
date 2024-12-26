module sword (input logic sw, reset, clk, 
output logic v);

typedef enum {S0,S1} statetype;
statetype currentstate, nextstate;

logic vin=1'b0;


always_ff @ (posedge clk) begin
	if(reset) begin
		currentstate <= S0;
	end
	else currentstate <= nextstate;
	end
	always_comb begin
			vin=1'b0;

		
		case (currentstate)
			S0:begin 
				if(sw) begin
					vin = 1'b1;
					nextstate = S1;

				end 
				else begin
					vin = 1'b0;

					nextstate = S0;
				end
				end
				
				S1: begin
					vin = 1'b1;
					 nextstate = S1;
					end
			default: begin
				nextstate = S0;
				vin = 1'b0;
			end
			endcase
			end
			
			
			
			d_ff state0(vin,clk,v);
			
			endmodule 
