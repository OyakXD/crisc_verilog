module Ula #(parameter N=8) (
    input [N-1:0] i_Op_1,
    input [N-1:0] i_Op_2,
    input [3:0] i_Sel,
    output o_Flag_zero,
    output reg [N-1:0] o_Result
);

    always @(*) begin
        case(i_Sel)
            4'b0001: o_Result = (i_Op_2);
            4'b0010: o_Result = (i_Op_1 + i_Op_2);
            4'b0011: o_Result = (i_Op_1 - i_Op_2);
            4'b0100: o_Result = (i_Op_1 & i_Op_2);
            4'b0101: o_Result = (i_Op_1 | i_Op_2);
            4'b0110: o_Result = (i_Op_1 << i_Op_2);
            4'b0111: o_Result = (i_Op_1 >> i_Op_2);
            4'b1000: o_Result = (~i_Op_1);
            4'b1011: o_Result = (i_Op_1 - i_Op_2);
        default: o_Result = {N{1'b0}};
        endcase
    end

    assign o_Flag_zero = (o_Result == {N{1'b0}});

    
endmodule