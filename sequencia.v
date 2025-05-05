module Sequencia (
    input wire clk,
    input wire rst_n,

    input wire setar_palavra,
    input wire [7:0] palavra,

    input wire start,
    input wire bit_in,

    output reg encontrado
);

    reg [7:0] palavra_atual;
    reg [3:0] x;
    reg stts;

    always @(posedge clk) begin
        if (!rst_n) begin
            palavra_atual <= 8'b0;
            encontrado <= 1'b0;
            x <= 8;
            stts <= 1'b0;
        end else begin 
            if (setar_palavra) begin
                // Armazenar palavra
                palavra_atual <= palavra;
                encontrado <= 0;
                x <= 8;
            end else if(start) begin
                stts <= 1'b1;
            end if (x == 0) begin
                encontrado <= 1'b1;
                x <= 8;
            end else if (stts && encontrado == 1'b0) begin
                // Comparar palavra
                if (palavra_atual[x - 1] == bit_in) begin
                    x <= x - 1;
                end else begin
                    x <= 8;
                end 
            end
        end
    end

endmodule
