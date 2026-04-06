`timescale 1ps/1ps

module tb_Datapath;

    parameter N = 8;

    // Sinais de entrada
    reg clk;
    reg rst;
    wire [N-1:0] result;
    wire [N-1:0] ram_addr;
    integer i;

    Datapath #(.N(N)) dut (
        .i_Clk(clk),
        .i_Rst(rst),
        .o_RAM_Addr(ram_addr),
        .o_Result(result)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("simulacao.vcd");
        $dumpvars(0, tb_Datapath);
        // -- inicialização ---
        clk = 0;
        rst = 1;
        #15 rst = 0;    

        #50;
        #1;
        $display("Resultado = %d", dut.reg_file.r_Registers[1]);

        #10
        /*
        $display("MEMORIA RAM COMPLETA:");
        for(i = 0; i < 256; i = i + 1) begin
            $display("Endereço [%d] = %d", i, dut.ram.r_Contents[i]);
        end
        */
        /*
        $display("VALOR LIDO DA MEMORIA RAM GUARDADA EM R1 = %d", dut.reg_file.r_Registers[1]);
        */

        $finish;
    end
endmodule