module RegisterFile #(parameter N=8) (
    input i_Clk,
    input i_Rst,
    input i_Write_Enable,
    input [N-1:0] i_Write_Data,
    input [1:0] i_Source_Select,
    input [1:0] i_Destiny_Select,
    output [N-1:0] o_Read_Source,
    output [N-1:0] o_Read_Destiny
);

    reg [N-1:0] r_Registers [0:N-1];
    integer i;

    always @(posedge i_Clk or posedge i_Rst) begin
        if (i_Rst) begin
            for(i = 0; i < N; i = i + 1) begin
                r_Registers[i] <= {N{1'b0}};
            end
        end else if (i_Write_Enable) begin
                r_Registers[i_Destiny_Select] <= i_Write_Data;
            end
        end

        assign o_Read_Source = r_Registers[i_Source_Select];
        assign o_Read_Destiny = r_Registers[i_Destiny_Select];
    
endmodule