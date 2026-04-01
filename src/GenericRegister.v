module GenericRegister #(parameter N=8)(
    input i_Load,
    input i_Clk,
    input i_Rst,
    input [N-1:0] i_D,
    output reg [N-1:0] o_Q
);

    always @(posedge i_Clk or posedge i_Rst) begin
        if(i_Rst == 1) begin
            o_Q <= {N{1'b0}};
        end else if (i_Load == 1) begin
            o_Q <= i_D;
        end
    end

    
endmodule