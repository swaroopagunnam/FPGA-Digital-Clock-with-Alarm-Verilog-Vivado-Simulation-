module Topmodule (
    input clk,              // e.g., 100MHz main clock
    input reset,
    input btn_set,
    input btn_mode,
    output [6:0] seg,
    output [3:0] an,
    output alarm_led        // Output signal when alarm triggers
);
    wire clk_1Hz, clk_1kHz;

    // Clock divider for 1Hz
    clock_divider #(50_000_000) clk_div_1Hz (
        .clk(clk),
        .reset(reset),
        .clk_out(clk_1Hz)
    );

    // Clock divider for 1kHz (for display and debounce)
    clock_divider #(50_000) clk_div_1kHz (
        .clk(clk),
        .reset(reset),
        .clk_out(clk_1kHz)
    );

    // Time counter
    wire [5:0] seconds, minutes;
    wire [4:0] hours;

    time_counter time_cnt (
        .clk_1Hz(clk_1Hz),
        .reset(reset),
        .seconds(seconds),
        .minutes(minutes),
        .hours(hours)
    );

    // Debounce buttons
    wire btn_set_clean, btn_mode_clean;

    debounce db_set (
        .clk(clk_1kHz),
        .noisy_btn(btn_set),
        .clean_btn(btn_set_clean)
    );

    debounce db_mode (
        .clk(clk_1kHz),
        .noisy_btn(btn_mode),
        .clean_btn(btn_mode_clean)
    );

    // Alarm FSM
    wire [5:0] alarm_min;
    wire [4:0] alarm_hour;
    wire alarm_active;

    alarm_fsm alarm (
        .clk(clk_1Hz),
        .reset(reset),
        .btn_set(btn_set_clean),
        .btn_mode(btn_mode_clean),
        .curr_hour(hours),
        .curr_min(minutes),
        .alarm_hour(alarm_hour),
        .alarm_min(alarm_min),
        .alarm_on(alarm_active)
    );

    // Display (show HH:MM)
    display_controller display (
        .clk(clk_1kHz),
        .hours(hours),
        .minutes(minutes),
        .seg(seg),
        .an(an)
    );

    assign alarm_led = alarm_active;

endmodule
