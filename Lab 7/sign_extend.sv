module sign_extend(
    input logic [15:0] imm,       
    output logic [31:0] SignImm  
);
    assign SignImm = {{16{imm[15]}}, imm};
endmodule
