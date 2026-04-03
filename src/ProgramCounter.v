module ProgramCounter #(parameter N = 8) (
    input i_Clk,
    input i_Rst,
    input [N-1:0] i_Next_Addr,
    output reg [N-1:0] o_PC
);
    always @(posedge i_Clk) begin
        if (i_Rst)
            o_PC <= {N{1'b0}};
        else
            o_PC <= i_Next_Addr;
    end
    
endmodule