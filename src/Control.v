module Control #(parameter N=8) (
    input [N-1:0] i_Instruction,
    output reg o_Reg_WE,
    output reg o_Reg_Dst,
    output reg [3:0] o_Ula_op,
    output reg o_Mem_WE,
    output reg o_Branch_Eq,
    output reg o_Branch_NEq,
    output reg o_Branch_BEq,
    output reg [1:0] o_Mux_Sel
);

    always @(*) begin

        // Evitar latches
        o_Ula_op = 4'b0000;
        o_Reg_WE = 0;
        o_Branch_BEq = 0;
        o_Branch_NEq = 0;
        o_Branch_Eq = 0;
        o_Mux_Sel = 2'b00;

        casez (i_Instruction)
            // MOV
            8'b0001????: begin
                o_Reg_WE = 1;
                o_Ula_op = 4'b0001;
                o_Mux_Sel = 2'b01;
            end

            // ADD
            8'b0010????: begin
                o_Reg_WE = 1;
                o_Ula_op = 4'b0010;
                o_Mux_Sel = 2'b01;
            end

            // SUB 
            8'b0011????: begin
                o_Reg_WE = 1;
                o_Ula_op = 4'b0011;
                o_Mux_Sel = 2'b01;
            end

            // AND
            8'b0100????: begin
                o_Reg_WE = 1;
                o_Ula_op = 4'b0100;
                o_Mux_Sel = 2'b01;
            end

            // OR
            8'b0101????: begin
                o_Reg_WE = 1;
                o_Ula_op = 4'b0101;
                o_Mux_Sel = 2'b01;
            end

            // SHR
            8'b0110????: begin
                o_Reg_WE = 1;
                o_Ula_op = 4'b0110;
                o_Mux_Sel = 2'b01;
            end

            // SHL
            8'b0111????: begin
                o_Reg_WE = 1;
                o_Ula_op = 4'b0111;
                o_Mux_Sel = 2'b01;
            end

            // NOT
            8'b100000??: begin
                o_Reg_WE = 1;
                o_Ula_op = 4'b1000;
                o_Mux_Sel = 2'b01;
            end

            // B
            8'b100001??: begin
                o_Branch_Eq = 1;
                o_Ula_op = 4'b0011;
                o_Mux_Sel = 2'b01;
            end

            // BEQ
            8'b100010??: begin
                o_Branch_BEq = 1;
                o_Ula_op = 4'b0011;
                o_Mux_Sel = 2'b01;
            end

            // BNE  
            8'b100011??: begin
                o_Branch_NEq = 1;
                o_Ula_op = 4'b0011;
                o_Mux_Sel = 2'b01;
            end
            
            // LDR
            8'b1001????: begin
                o_Reg_WE = 1;
                o_Mem_WE = 0;
                o_Ula_op = 4'b0001;
                o_Mux_Sel = 2'b10;
            end

            // STR
            8'b1010????: begin
                o_Reg_WE = 0;
                o_Mem_WE = 1;
                o_Ula_op = 4'b0001;
                o_Mux_Sel = 2'b01;
            end

            // LI
            8'b11??????: begin
                o_Reg_WE = 1;
                o_Mux_Sel = 2'b00;
            end

        endcase
    end
    
endmodule