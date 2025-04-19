module alarm_fsm (
    input clk,
    input reset,
    input btn_set,
    input btn_mode,
    input [4:0] curr_hour,
    input [5:0] curr_min,
    output reg [4:0] alarm_hour,
    output reg [5:0] alarm_min,
    output reg alarm_on
);
    // State encoding
    parameter IDLE = 2'b00,
              SET_HOUR = 2'b01,
              SET_MIN = 2'b10;

    reg [1:0] state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            alarm_hour <= 0;
            alarm_min <= 0;
            alarm_on <= 0;
        end else begin
            case (state)
                IDLE: begin
                    if (btn_mode)
                        state <= SET_HOUR;

                    // Compare current time to alarm time
                    if (curr_hour == alarm_hour && curr_min == alarm_min)
                        alarm_on <= 1;
                    else
                        alarm_on <= 0;
                end

                SET_HOUR: begin
                    if (btn_set) begin
                        if (alarm_hour == 23)
                            alarm_hour <= 0;
                        else
                            alarm_hour <= alarm_hour + 1;
                    end
                    if (btn_mode)
                        state <= SET_MIN;
                end

                SET_MIN: begin
                    if (btn_set) begin
                        if (alarm_min == 59)
                            alarm_min <= 0;
                        else
                            alarm_min <= alarm_min + 1;
                    end
                    if (btn_mode)
                        state <= IDLE;
                end
            endcase
        end
    end
endmodule


/* system verilog version below code
module alarm_fsm (
    input clk,
    input reset,
    input btn_set,
    input btn_mode,
    input [4:0] curr_hour,
    input [5:0] curr_min,
    output reg [4:0] alarm_hour,
    output reg [5:0] alarm_min,
    output reg alarm_on
);
    typedef enum reg [1:0] {
        IDLE = 2'b00,
        SET_HOUR = 2'b01,
        SET_MIN = 2'b10
    } state_t;

    state_t state = IDLE;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            alarm_hour <= 0;
            alarm_min <= 0;
            alarm_on <= 0;
        end else begin
            case (state)
                IDLE: begin
                    if (btn_mode)
                        state <= SET_HOUR;
                    // Alarm match logic
                    if (curr_hour == alarm_hour && curr_min == alarm_min)
                        alarm_on <= 1;
                    else
                        alarm_on <= 0;
                end

                SET_HOUR: begin
                    if (btn_set) begin
                        if (alarm_hour == 23)
                            alarm_hour <= 0;
                        else
                            alarm_hour <= alarm_hour + 1;
                    end
                    if (btn_mode)
                        state <= SET_MIN;
                end

                SET_MIN: begin
                    if (btn_set) begin
                        if (alarm_min == 59)
                            alarm_min <= 0;
                        else
                            alarm_min <= alarm_min + 1;
                    end
                    if (btn_mode)
                        state <= IDLE;
                end
            endcase
        end
    end
endmodule
*/