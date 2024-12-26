module top(
    input logic clk, rst,
    input logic[1:0] sw, 
    output logic[31:0] ALUResult, 
    output logic[31:0] RD1, RD2, 
    output logic[31:0] prode_register_file, 
    output logic[31:0] prode_data_memory, 
    output logic[6:0] display_led 
);

logic[31:0] inst_0 = 32'b0;

logic[31:0] inst_lw = 32'b010101_00000_00001_0000_0000_0000_0101; // LW 

logic[31:0] inst_sw = 32'b010100_00000_00110_0000_0000_0000_0010; // SW 

logic[31:0] inst_ex;
assign inst_ex = (sw == 1) ? inst_lw : (sw == 2) ? inst_sw : inst_0;

logic [31:0] SignImm, ALUSrc_out, MemtoReg_out, MemData;
logic [4:0] WriteReg;
logic MemtoReg, ALUSrc, RegDst, WE, WE3;
logic [2:0] ALUControl;

assign MemtoReg = (inst_ex[31:26] == 6'b010101); // LW
assign WE = (inst_ex[31:26] == 6'b010100); // SW
assign ALUSrc = 1; 
assign RegDst = 0; 
assign WE3 = (inst_ex[31:26] == 6'b010101);
assign ALUControl = 3'b010;
	
register_file r_f(
    .clk(clk),
    .rst(rst),
    .A1(inst_ex[25:21]),
    .A2(inst_ex[20:16]), 
    .A3(WriteReg),
    .WD3(MemtoReg_out), 
    .WE3(WE3), 
    .RD1(RD1),
    .RD2(RD2),
    .prode(prode_register_file)
);

alu alu_inst(
    .SrcA(RD1),
    .SrcB(ALUSrc_out),
    .ALUControl(ALUControl),
    .ALUResult(ALUResult)
);

data_memory d_mem(
    .clk(clk),
    .rst(rst),
    .A(ALUResult), 
    .WD(RD2), 
    .WE(WE), 
    .RD(MemData), 
    .prode(prode_data_memory)
);


MUX_MemtoReg mux_memtoreg(
    .MemtoReg(MemtoReg),
    .ALUResult(ALUResult),
    .RD(MemData),
    .MemtoReg_out(MemtoReg_out)
);

MUX_RegDst mux_regdst(
    .RegDst(RegDst),
    .rt(inst_ex[20:16]),
    .rd(inst_ex[15:11]),
    .MUXRegDst_out(WriteReg)
);

MUX_ALUSrc mux_alusrc(
    .ALUSrc(ALUSrc),
    .regData(RD2),
    .immData(SignImm),
    .ALUSrc_out(ALUSrc_out)
);

sign_extend sign_ext(
    .imm(inst_ex[15:0]),
    .SignImm(SignImm)
);

display t2(
	.value(prode_register_file), 
	.segments(display_led)
);


endmodule





