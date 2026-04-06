module Memory #(parameter N = 8) (
    input i_Clk,
    input i_Enable,
    input i_Write_Enable,
    input [N-1:0] i_Address,
    inout [N-1:0] io_Data
);

    reg [N-1:0] r_Contents [0:(2**N)-1];

    // Se enable = 1 e write_enable = 0, a ram coloca o dado no barramento
    // se não ele fica em alta impedância ('z') para não dar conflito.
    assign io_Data = (i_Enable && !i_Write_Enable) ? r_Contents[i_Address] : {N{1'bz}};

    integer k;
    initial begin
        for(k = 0; k < (2**N) ; k = k + 1) begin
            r_Contents[k] = 8'b0;
        end
    end

    always @(posedge i_Clk) begin
        if(i_Enable && i_Write_Enable) begin
            r_Contents[i_Address] <= io_Data;
        end
    end

    
endmodule