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
    reg [2:0] x; 

    always @(posedge clk) begin
        if (!rst_n) begin
            palavra_atual <= 8'b0;
            encontrado <= 1'b0;
            x <= 7;
        end else if (setar_palavra) begin
            // Armazenar palavra
            palavra_atual <= palavra;
            encontrado <= 0;
            x <= 7;
        end else if (start && encontrado == 1'b0) begin
            // Comparar palavra
            if (palavra_atual[x] == bit_in) begin
                x <= x - 1;
                if (x == 0) begin
                    encontrado <= 1'b1;
                    x <= 7;
                end
            end else begin
                x <= 7;
            end
        end
    end
    

endmodule
