module data_memory(
    input logic clk,               // Clock signal
    input logic rst,               // Reset signal
    input logic [31:0] A,          // Address input
    input logic [31:0] WD,         // Write Data
    input logic WE,                // Write Enable
    output logic [31:0] RD,        // Read Data
    output logic [31:0] prode      // Probe output 
);
    logic [31:0] memory [255:0];
	 assign RD = memory[A[7:0]];         
    assign prode = memory[A[7:0]]; 

    always_ff @(posedge clk or negedge rst) begin
        if (!rst) begin
            for (int i = 0; i < 256; i++) begin
                memory[i] <= i;
				end
			end
        else if (WE) begin
            memory[A[7:0]] <= WD;       
        
    end
	 end

         

endmodule


