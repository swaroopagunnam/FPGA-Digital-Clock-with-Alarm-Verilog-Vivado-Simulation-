module clock_divider #(parameter DIVISOR = 500_000_000)(
    input clk,
    input reset,
    output reg clk_out
);
    reg [31:0] count = 0;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            count <= 0;
            clk_out <= 0;
        end else begin
            if (count == DIVISOR - 1) begin
                count <= 0;
                clk_out <= ~clk_out;
            end else begin
                count <= count + 1;
            end
        end
    end
endmodule
