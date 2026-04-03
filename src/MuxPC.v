module MuxPC #(parameter N = 8) (
    input [N-1:0] I0,
    input [N-1:0] I1,
    input sel,
    output [N-1:0] o_Next_Addr
);

    assign o_Next_Addr = (sel) ? I1 : I0;
    
endmodule