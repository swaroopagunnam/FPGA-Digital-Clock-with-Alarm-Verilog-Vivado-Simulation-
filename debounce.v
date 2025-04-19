module debounce (
    input clk,             // fast clock (e.g. 1kHz-10kHz)
    input noisy_btn,
    output reg clean_btn
);

    reg [2:0] shift_reg = 3'b000;

    always @(posedge clk) begin
        shift_reg <= {shift_reg[1:0], noisy_btn};

        // Output goes high only when all three samples are high
        if (shift_reg == 3'b111)
            clean_btn <= 1;
        else if (shift_reg == 3'b000)
            clean_btn <= 0;
        // else: maintain current state (acts like hysteresis)
    end
endmodule
