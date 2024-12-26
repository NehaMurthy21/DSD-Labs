module MUX_RegDst(
    input logic RegDst,                  
    input logic [4:0] rt,             
    input logic [4:0] rd,             
    output logic [4:0] MUXRegDst_out            
);
    assign MUXRegDst_out = RegDst ? rd : rt;
endmodule

