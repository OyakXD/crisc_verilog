module Datapath #(parameter N=8) (
    input i_Clk,
    input i_Rst,
    output [N-1:0] o_Result,
    output [N-1:0] o_RAM_Addr
);

    // FIOS DE CONEXÃO

    // Sinais de controle
    wire w_Reg_WE;
    wire [3:0] w_Ula_op;
    wire w_Branch_Eq, w_Branch_NEq, w_Branch_BEq;
    wire [1:0] w_Mux_Sel;
    wire w_Mem_WE;
    wire w_Zero_Flag;
    wire w_Branch_Final;

    // Sinais de dados
    wire [N-1:0] w_Data_RS;
    wire [N-1:0] w_Data_RD;
    wire [N-1:0] w_Ula_Result;
    wire [N-1:0] w_Mux_Out;
    wire [N-1:0] i_RAM_Data;
    wire [N-1:0] w_RAM_IO_Data;
    wire [N-1:0] w_Immediate = {4'b0000, w_Instruction[5:2]};
    wire [N-1:0] w_PC_Current;
    wire [N-1:0] w_PC_Next;
    wire [N-1:0] w_I0 = w_PC_Current + 1;
    wire [N-1:0] w_Instruction;
   

    Control control_unit (
        .i_Instruction(w_Instruction),
        .o_Reg_WE(w_Reg_WE),
        .o_Ula_op(w_Ula_op),
        .o_Mux_Sel(w_Mux_Sel),
        .o_Mem_WE(w_Mem_WE),
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
        .i_Source_Select(w_Instruction[3:2]),
        .i_Destiny_Select(w_Instruction[1:0]),
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

    Memory ram (
        .i_Clk(i_Clk),
        .i_Enable(1'b1),
        .i_Write_Enable(w_Mem_WE),
        .i_Address(w_Ula_Result),
        .io_Data(w_RAM_IO_Data)
    );

    Branch branch (
        .i_Zero_Flag(w_Zero_Flag),
        .i_Branch_Eq(w_Branch_Eq),
        .i_Branch_BEq(w_Branch_BEq),
        .i_Branch_NEq(w_Branch_NEq),
        .o_Branch_Result(w_Branch_Final)
    );

    MuxPC muxPC (
        .I0(w_I0),
        .I1(w_Immediate),
        .sel(w_Branch_Final),
        .o_Next_Addr(w_PC_Next)
    );

    ProgramCounter pc (
        .i_Clk(i_Clk),
        .i_Rst(i_Rst),
        .i_Next_Addr(w_PC_Next),
        .o_PC(w_PC_Current)
    );

    Rom rom (
        .i_Addr(w_PC_Current),
        .o_Instruction(w_Instruction)
    );

    assign i_Instruction_Internal = w_Instruction;
    assign i_RAM_Data = w_RAM_IO_Data;
    assign o_Result = w_Ula_Result;
    assign o_RAM_Addr = w_Ula_Result;
    assign w_RAM_IO_Data = (w_Mem_WE) ? w_Data_RD : {N{1'bz}};

    
endmodule