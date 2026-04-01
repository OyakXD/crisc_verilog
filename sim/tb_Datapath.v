`timescale 1ps/1ps

module tb_Datapath;

    parameter N = 8;

    // Sinais de entrada
    reg clk;
    reg rst;
    reg [N-1:0] instruction;
    reg [N-1:0] ram_data;
    wire [N-1:0] result;
    wire [N-1:0] ram_addr;

    Datapath #(.N(N)) dut (
        .i_Clk(clk),
        .i_Rst(rst),
        .i_Instruction(instruction),
        .i_RAM_Data(ram_data),
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
        instruction = 8'b0;
        ram_data = 8'b0;

        #10 rst = 0;

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

        // LI R1, #10
        instruction = 8'b11101001;
        #10;

        $display("Conteúdo de R0: %d", dut.reg_file.r_Registers[0]);
        $display("Conteúdo de R1: %d", dut.reg_file.r_Registers[1]);

        // SUB R1, R0
        instruction = 8'b00110001;
        #10;

        $display("RESULTADO DA SUBTRAÇÃO EM R1: %d", dut.reg_file.r_Registers[1]);

        $finish;
    end
endmodule