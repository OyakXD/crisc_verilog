module Branch #(parameter N = 8) (
    input i_Zero_Flag,
    input i_Branch_Eq,
    input i_Branch_BEq,
    input i_Branch_NEq,
    output o_Branch_Result
);
    assign o_Branch_Result = (i_Branch_BEq && i_Zero_Flag) ||
                             (i_Branch_NEq && !i_Zero_Flag) ||
                             (i_Branch_Eq);
    
endmodule