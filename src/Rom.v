module Rom #(parameter N = 8) (
    input [N-1:0] i_Addr,
    output [N-1:0] o_Instruction
);

    reg [N-1:0] r_Mem [0:255];
    integer i;

    initial begin
        for (i = 0; i < 255; i = i + 1) begin
            r_Mem[i] = {N{1'b0}};
        end

        $readmemb("bin/program.bin", r_Mem);
    end

    assign o_Instruction = r_Mem[i_Addr];
    
endmodule