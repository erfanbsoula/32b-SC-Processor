module RegisterFile (
    input wire Clk, Rst, RegWrite,
    input wire [4:0] ReadRegister1, ReadRegister2, WriteRegister,
    input wire [31:0] WriteData,
    output wire [31:0] DataRead1, DataRead2
);
    integer n;

    reg [31:0] registerArray [1:31];
    assign DataRead1 = (ReadRegister1 == 5'd0) ? 32'd0 : registerArray[ReadRegister1];
    assign DataRead2 = (ReadRegister2 == 5'd0) ? 32'd0 : registerArray[ReadRegister2];

    always @(posedge Clk) begin
        if(Rst) begin
            for (n = 0; n < 32; n = n + 1) begin
                registerArray[n] <= 32'd0;
            end
        end
        else if (RegWrite && (WriteRegister != 5'd0) )
            registerArray[WriteRegister] <= WriteData;
    end

endmodule