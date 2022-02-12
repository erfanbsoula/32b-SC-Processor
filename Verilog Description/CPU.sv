module CPU (
    input wire Clk, Rst,
    input wire [31:0] MemReadData, Instruction,
    output wire [31:0] MemAddress, MemWriteData, InstructionAddr,
    output wire MemRead, MemWrite
);

    wire [1:0] PCSrc, RegDst;
    wire RegWSrc, ALUSrc, MemToReg, RegWrite;
    wire [2:0] ALUOperation;
    wire [5:0] OpCode, Func;
    wire Zero;

    DataPath dataPath (
        .Clk(Clk), .Rst(Rst), .PCSrc(PCSrc), .RegDst(RegDst),
        .RegWSrc(RegWSrc), .ALUSrc(ALUSrc), .MemToReg(MemToReg),
        .RegWrite(RegWrite), .ALUOperation(ALUOperation),
        .MemReadData(MemReadData), .Instruction(Instruction),
        .OpCode(OpCode), .Func(Func), .Zero(Zero),
        .MemAddress(MemAddress), .MemWriteData(MemWriteData),
        .InstructionAddr(InstructionAddr)
    );

    Controller controller (
        .OpCode(OpCode), .Func(Func), .Zero(Zero),
        .RegWSrc(RegWSrc), .RegWrite(RegWrite), .ALUSrc(ALUSrc),
        .MemRead(MemRead), .MemWrite(MemWrite),
        .MemToReg(MemToReg), .PCSrc(PCSrc), .RegDst(RegDst),
        .ALUOperation(ALUOperation)
    );

endmodule