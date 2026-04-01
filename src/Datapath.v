module Datapath #(parameter N=8) (
    input i_Clk,
    input i_Rst,
    input [N-1:0] i_Instruction,
    input [N-1:0] i_RAM_Data,
    output [N-1:0] o_Result,
    output [N-1:0] o_RAM_Addr
);

    // FIOS DE CONEXÃO
    // Sinais de controle
    wire w_Reg_WE;
    wire [3:0] w_Ula_op;
    wire w_Branch_Eq, w_Branch_NEq, w_Branch_BEq;
    wire [1:0] w_Mux_Sel;

    // Sinais de dados
    wire [N-1:0] w_Data_RS;
    wire [N-1:0] w_Data_RD;
    wire [N-1:0] w_Ula_Result;
    wire [N-1:0] w_Mux_Out;
    wire w_Zero_Flag;

    wire [N-1:0] w_Immediate = {4'b0000, i_Instruction[5:2]};

    Control control_unit (
        .i_Instruction(i_Instruction),
        .o_Reg_WE(w_Reg_WE),
        .o_Ula_op(w_Ula_op),
        .o_Mux_Sel(w_Mux_Sel),
        .o_Branch_Eq(w_Branch_Eq),
        .o_Branch_BEq(w_Branch_BEq),
        .o_Branch_NEq(w_Branch_NEq)
    );

    Mux_3_1 #(.N(N)) mux (
        .I0 (w_Immediate),
        .I1 (w_Ula_Result),
        .I2 (i_RAM_Data),
        .sel(w_Mux_Sel),
        .O0(w_Mux_Out)
    );

    RegisterFile reg_file (
        .i_Clk(i_Clk),
        .i_Rst(i_Rst),
        .i_Write_Enable(w_Reg_WE),
        .i_Write_Data(w_Mux_Out),
        .i_Source_Select(i_Instruction[3:2]),
        .i_Destiny_Select(i_Instruction[1:0]),
        .o_Read_Source(w_Data_RS),
        .o_Read_Destiny(w_Data_RD)
    );

    Ula alu (
        .i_Op_1(w_Data_RD),
        .i_Op_2(w_Data_RS),
        .i_Sel(w_Ula_op),
        .o_Flag_zero(w_Zero_Flag),
        .o_Result(w_Ula_Result)
    );

    assign o_Result = w_Ula_Result;
    assign o_RAM_Addr = w_Data_RS;

    
endmodule