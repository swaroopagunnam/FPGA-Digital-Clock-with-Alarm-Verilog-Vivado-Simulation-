module time_counter (
    input clk_1Hz,     // 1Hz clock input from clock divider
    input reset,
    output reg [5:0] seconds,
    output reg [5:0] minutes,
    output reg [4:0] hours
);
    always @(posedge clk_1Hz or posedge reset) begin
        if (reset) begin
            seconds <= 0;
            minutes <= 0;
            hours <= 0;
        end else begin
            // Seconds counting
            if (seconds == 59) begin
                seconds <= 0;
                // Minutes counting
                if (minutes == 59) begin
                    minutes <= 0;
                    // Hours counting (24-hour format)
                    if (hours == 23)
                        hours <= 0;
                    else
                        hours <= hours + 1;
                end else begin
                    minutes <= minutes + 1;
                end
            end else begin
                seconds <= seconds + 1;
            end
        end
    end
endmodule
