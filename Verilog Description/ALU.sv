module ALU (
    input wire [31:0] InA, InB,
    input wire [2:0] ALUOp,
    output wire [31:0] Res,
    output wire Zero 
);

    assign Res = (
        ALUOp == 3'b000 ? (InA + InB) :
        ALUOp == 3'b001 ? (InA - InB) :
        ALUOp == 3'b010 ? (InA & InB) :
        ALUOp == 3'b011 ? (InA | InB) :
        ALUOp == 3'b100 ? (
            InA < InB ? 31'b1 : 31'b0
        ) :
        32'b0
    );

    assign Zero = (Res == 0) ? 1'b1 : 1'b0;

endmodule