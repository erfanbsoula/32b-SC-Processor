module DataPath (
    input wire Clk, Rst,
    input wire [1:0] PCSrc, RegDst,
    input wire RegWSrc, ALUSrc, MemToReg, RegWrite,
    input wire [2:0] ALUOperation,
    input wire [31:0] MemReadData, Instruction,
    output wire [5:0] OpCode, Func,
    output wire [31:0] MemAddress, MemWriteData, InstructionAddr,
    output wire Zero
);

    wire [31:0] pCOut, pCNext, pCLoad, regWriteData, jumpAddr;
    wire [31:0] branchOffset, branchAddr, aluOut, memOrALU;
    wire [31:0] regReadData1, regReadData2, immediateEx, aluInB;
    wire [4:0] writeRegister;

    Register pc ( .Clk(Clk), .Rst(Rst), .In(pCLoad), .Out(pCOut) );
    assign InstructionAddr = pCOut;

    Adder adder1 ( .InA(pCOut), .InB(32'd4), .Res(pCNext) );

    assign OpCode = Instruction[31:26];
    assign Func = Instruction[5:0];

    Mux4 #( .N(5) ) writeRegSel (
        .In0(Instruction[20:16]), .In1(Instruction[15:11]),
        .In2(5'd31), .In3(), .Sel(RegDst),
        .OutP(writeRegister)
    );

    Mux2 regWriteDataSel (
        .In0(pCNext), .In1(memOrALU), .Sel(RegWSrc),
        .OutP(regWriteData)
    );

    RegisterFile regFile (
        .Clk(Clk), .Rst(Rst), .RegWrite(RegWrite),
        .ReadRegister1(Instruction[25:21]),
        .ReadRegister2(Instruction[20:16]),
        .WriteRegister(writeRegister),
        .WriteData(regWriteData),
        .DataRead1(regReadData1),
        .DataRead2(regReadData2)
    );

    SignExtend #( .NI(16) ) signExtend (
        .In(Instruction[15:0]), .Out(immediateEx)
    );

    ShiftLeft #( .N(26), .SH(2) ) shiftLeftJumpIm (
        .In(Instruction[25:0]), .Out(jumpAddr[27:0])
    );
    assign jumpAddr[31:28] = pCOut[31:28];

    Mux2 aluSrcSel (
        .In0(regReadData2), .In1(immediateEx),
        .Sel(ALUSrc), .OutP(aluInB)
    );

    ALU alu (
        .InA(regReadData1), .InB(aluInB),
        .ALUOp(ALUOperation),
        .Res(aluOut), .Zero(Zero)
    );

    assign MemAddress = aluOut;
    assign MemWriteData = regReadData2;

    Mux2 memToRegSel (
        .In0(aluOut), .In1(MemReadData),
        .Sel(MemToReg), .OutP(memOrALU)
    );

    ShiftLeft #( .N(30), .SH(2) ) shiftLeftOffset (
        .In(immediateEx[29:0]), .Out(branchOffset)
    );

    Adder adder2 (
        .InA(pCNext), .InB(branchOffset),
        .Res(branchAddr)
    );

    Mux4 pcSrcSel (
        .In0(pCNext), .In1(branchAddr), .In2(jumpAddr),
        .In3(regReadData1), .Sel(PCSrc), .OutP(pCLoad)
    );

endmodule