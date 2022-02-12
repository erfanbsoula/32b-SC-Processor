`timescale 1ns/1ns
module DataMem (
    input wire Clk, MemRead, MemWrite,
    input wire [31:0] Address, WriteData,
    output wire [31:0] ReadData
);

    wire [8:0] adr;
    assign adr = Address[10:2];

    reg [31:0] regMem [0:511];
    assign ReadData = MemRead ? regMem[adr] : 32'b0;

    always @(posedge Clk) begin
        if (MemWrite)
            regMem[adr] <= WriteData;
    end

    initial begin
        $readmemb("data.txt", regMem);
        #4000
        // displaying the results of the test program
        $display("\nmemory[2000] = %b", regMem[500]);
        $display("memory[2004] = %b\n", regMem[501]);
    end

endmodule