`timescale 1ps/1ps

module tb_Datapath;

    parameter N = 8;

    // Sinais de entrada
    reg clk;
    reg rst;
    reg [N-1:0] instruction;
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
        //instruction = 8'b0;

        #15 rst = 0;

        #500;

        /*

        // LI R1, #7
        instruction = 8'b11011101;
        #10;

        // MOV R2, R1
        instruction = 8'b00010110;
        #10;

        $display("Conteúdo de R1: %d", dut.reg_file.r_Registers[1]);
        $display("Conteúdo de R2: %d", dut.reg_file.r_Registers[2]);
        #10

        // ADD R2, R1
        instruction = 8'b00100110;
        #10;

        // MOV R3, R2
        instruction = 8'b00011011;
        #10;

        $display("RESULTADO DA SOMA EM R3: %d", dut.reg_file.r_Registers[3]);

        // LI R0, #5
        instruction = 8'b11010100;
        #10;

        // LI R1, #5
        instruction = 8'b11010101;
        #10;

        $display("Conteúdo de R0: %d", dut.reg_file.r_Registers[0]);
        $display("Conteúdo de R1: %d", dut.reg_file.r_Registers[1]);

        // SUB R1, R0
        instruction = 8'b00110001;
        #10;
        $display("RESULTADO DA SUBTRAÇÃO EM R1: %d", dut.reg_file.r_Registers[1]);

        // B R3
        instruction = 8'b10000111;
        #10;

        // STR R3, R1
        instruction = 8'b10101101;
        #10

        #100
        $display("MEMORIA RAM COM O VALOR ENCONTRADO:");
        for(i = 0; i < 256; i = i + 1) begin
            if(dut.ram.r_Contents[i] !== 8'dx && dut.ram.r_Contents[i] !== 0) begin
                $display("Endereço [%d] = %d", i, dut.ram.r_Contents[i]);
            end
        end

        $display("MEMORIA RAM COMPLETA:");
        for(i = 0; i < 256; i = i + 1) begin
            $display("Endereço [%d] = %d", i, dut.ram.r_Contents[i]);
        end
        #10

        // LDR R1, R3
        instruction = 8'b10011101;
        #10

        $display("VALOR LIDO DA MEMORIA RAM GUARDADA EM R1 = %d", dut.reg_file.r_Registers[1]);
        */
        $finish;
    end
endmodule