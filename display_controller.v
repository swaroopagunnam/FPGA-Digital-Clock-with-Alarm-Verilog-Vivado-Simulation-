module display_controller (
    input clk,  // Fast clock for multiplexing (e.g. 1kHz-10kHz)
    input [4:0] hours,
    input [5:0] minutes,
    output reg [6:0] seg,   // 7-segment segments (abcdefg)
    output reg [3:0] an     // Anode signals for 4 digits
);

    reg [3:0] digit;
    reg [1:0] mux_index = 0;
    wire [3:0] bcd_digits[3:0];

    // Extract BCD digits
    assign bcd_digits[3] = hours / 10;  // Tens hour
    assign bcd_digits[2] = hours % 10;  // Ones hour
    assign bcd_digits[1] = minutes / 10;  // Tens min
    assign bcd_digits[0] = minutes % 10;  // Ones min

    // 7-segment decoder
    always @(*) begin
        case (digit)
            4'd0: seg = 7'b1000000;
            4'd1: seg = 7'b1111001;
            4'd2: seg = 7'b0100100;
            4'd3: seg = 7'b0110000;
            4'd4: seg = 7'b0011001;
            4'd5: seg = 7'b0010010;
            4'd6: seg = 7'b0000010;
            4'd7: seg = 7'b1111000;
            4'd8: seg = 7'b0000000;
            4'd9: seg = 7'b0010000;
            default: seg = 7'b1111111;
        endcase
    end

    // Multiplexing logic
    always @(posedge clk) begin
        mux_index <= mux_index + 1;
        case (mux_index)
            2'd0: begin
                an <= 4'b1110;
                digit <= bcd_digits[0]; // min ones
            end
            2'd1: begin
                an <= 4'b1101;
                digit <= bcd_digits[1]; // min tens
            end
            2'd2: begin
                an <= 4'b1011;
                digit <= bcd_digits[2]; // hour ones
            end
            2'd3: begin
                an <= 4'b0111;
                digit <= bcd_digits[3]; // hour tens
            end
        endcase
    end
endmodule
