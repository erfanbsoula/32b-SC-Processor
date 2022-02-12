`timescale 1ns/1ns
module TestBench ();

    reg clk, rst;

    // initializing memories
    // *************************************************
    wire [31:0] instructionAddress, instruction;
    InstMem instructionMemory (
        .Address(instructionAddress),
        .Instruction(instruction)
    );
    // *************************************************
    wire memRead, memWrite;
    wire [31:0] address, writeData, readData;
    DataMem dataMemory (
        .Clk(clk), .MemRead(memRead), .MemWrite(memWrite),
        .Address(address), .WriteData(writeData),
        .ReadData(readData)
    );
    // *************************************************

    CPU cpu (
        .Clk(clk), .Rst(rst), .MemReadData(readData),
        .Instruction(instruction),
        .MemAddress(address), .MemWriteData(writeData),
        .MemRead(memRead), .MemWrite(memWrite),
        .InstructionAddr(instructionAddress)
    );

    // modeling computer clock
    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        #6
        rst = 0;
        #4000
        $stop;
    end

endmodule