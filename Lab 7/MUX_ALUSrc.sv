module MUX_ALUSrc(
    input logic ALUSrc,                  
    input logic [31:0] regData,       
    input logic [31:0] immData,       
    output logic [31:0] ALUSrc_out           
);
    assign ALUSrc_out = ALUSrc ? immData : regData;
endmodule

