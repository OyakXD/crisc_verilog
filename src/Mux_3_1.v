module Mux_3_1 #(parameter N=8) (
    input [N-1:0] I0, I1, I2,
    input [1:0] sel,
    output reg [N-1:0] O0
);
    always @(*) begin
        case(sel)
            2'b00: O0=I0;
            2'b01: O0=I1;
            2'b10: O0=I2;
            default: O0 = {N{1'b0}};
        endcase
    end
    
endmodule