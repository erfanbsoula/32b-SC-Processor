`timescale 1ns/1ns
module InstMem (
    input wire [31:0] Address,
    output wire [31:0] Instruction
);

    wire [8:0] adr;
    assign adr = Address[10:2];

    reg [31:0] instMem [0:511];
    assign Instruction = instMem[adr];

    initial begin
        $readmemb("program.txt", instMem);
    end

endmodule