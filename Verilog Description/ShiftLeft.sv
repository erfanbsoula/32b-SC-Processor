module ShiftLeft #(parameter N = 32, SH = 2) (
    input wire [N-1:0] In,
    output wire [N+SH-1:0] Out
);

    assign Out = { In, {SH {1'b0}} };

endmodule