# FPGA-Digital-Clock-with-Alarm-Verilog-Vivado-Simulation-
A digital clock implemented in Verilog, featuring timekeeping, 7-segment display, and an alarm system. Fully testable in simulation .
🧠 Features
✅ Real-time clock: Hours, Minutes, Seconds counter

✅ Alarm functionality with settable time

✅ FSM-based alarm control using buttons

✅ 7-segment display output for HH:MM

✅ Debounced input buttons

✅ Testbench included for full simulation

✅ Fully synthesizable Verilog (Vivado/ISE)

 Project Structure
text
Copy
Edit
├── clock_divider.v         # Generates 1Hz & 1kHz clocks
├── time_counter.v          # Counts hours, minutes, seconds
├── display_controller.v    # Drives 7-segment display (optional in sim)
├── alarm_fsm.v             # FSM to set & trigger alarm
├── debounce.v              # Cleans up noisy button signals
├── digital_clock_top.v     # Top-level module connecting everything
├── tb_digital_clock_top.v  # Simulation testbench
└── digital_clock.vcd       # Optional waveform output (for GTKWave)


🚀 How to Run the Simulation
# Compile all Verilog files
iverilog -o sim.out *.v

# Run the simulation
vvp sim.out

# View waveform
digital_clock.vcd
🧪 Using Vivado (xsim)
Open Vivado > Create New Project > Add Sources (all .v files)

Set tb_digital_clock_top as top module for simulation

Run simulation and view waveforms

 Block Diagram
    +--------------------+
        |  clock_divider.v   | --> 1Hz, 1kHz
        +--------------------+
                  |
        +--------------------+
        |   time_counter.v   | --> Hours, Minutes, Seconds
        +--------------------+
                  |
        +--------------------+
        |   alarm_fsm.v      | <-- btn_set, btn_mode
        +--------------------+
                  |
        +--------------------+       +----------------------+
        | debounce.v (x2)    |       | display_controller.v |
        +--------------------+       +----------------------+
                  |                           |
        +---------------------------------------------+
        |           digital_clock_top.v               |
        +---------------------------------------------+
📸 Screenshots / Waveform Output
(Vivado waveform viewer )

⏰ Alarm triggering after 2 minutes

🟢 Button presses and state transitions

🧠 Time increment logic in simulation

📌 Skills 
RTL design (Verilog)

FSM design

Simulation testbenches

Clock management & debouncing

Design hierarchy and modularity

Vivado simulation workflow
