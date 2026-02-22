module top_module(
    input logic clk,
    input logic reset
);

    logic [31:0] PCNext, PC, PCPlus4, PCTarget;
    logic [31:0] Instr, ImmExt;
    logic [31:0] SrcB, ALUResult, WriteData, ReadData, RD1, RD2, Result;

    logic PCSrc, ALUSrc, RegWrite, MemWrite, Zero; 


    logic [2:0] ALUControl;
    logic [1:0] ImmSrc, ResultSrc;

    pc my_pc(
        .clk,
        .reset,
        .PCNext,
        .PC
    );
    imem my_imem(
        .A(PC),
        .RD(Instr)
    );
    control my_control(
        .op(Instr[6:0]),
        .funct3(Instr[14:12]),
        .funct7b5(Instr[30]),
        .Zero(Zero),
        .RegWrite(RegWrite),
        .MemWrite(MemWrite),
        .ALUSrc(ALUSrc),
        .ALUControl(ALUControl),
        .ResultSrc(ResultSrc),
        .PCSrc(PCSrc),
        .ImmSrc(ImmSrc)
    );
    regfile my_regfile(
        .clk,
        .A1(Instr[19:15]),
        .A2(Instr[24:20]),
        .A3(Instr[11:7]),
        .RD1(RD1),
        .RD2(RD2),
        .WD3(Result),
        .reg_write(RegWrite)
    );
    extend my_extend(
        .in(Instr),
        .out(ImmExt),
        .ImmSrc(ImmSrc)
    );
    mux2 my_mux_alu_src(
        .sel(ALUSrc),
        .in0(RD2),
        .in1(ImmExt),
        .out(SrcB)
    );
    alu my_alu(
        .SrcA(RD1),
        .SrcB(SrcB),
        .ALUControl(ALUControl),
        .ALUResult(ALUResult),
        .Zero(Zero)
    );
    dmem my_dmem(
        .clk,
        .WE(MemWrite),
        .A(ALUResult),
        .WD(RD2),
        .RD(ReadData)
    );
    mux4 my_mux_result_src(
        .sel(ResultSrc),
        .in0(ALUResult),
        .in1(ReadData),
        .in2(PCPlus4),
        .in3(PCTarget), //这有啥用
        .out(Result)
    );
    mux2 my_mux_pc_src(
        .sel(PCSrc),
        .in0(PCPlus4),
        .in1(PCTarget),
        .out(PCNext)
    );
    assign PCPlus4 = PC + 4; // Calculate the next sequential PC value
    assign PCTarget = PC + ImmExt; // Calculate the branch target address



endmodule
    