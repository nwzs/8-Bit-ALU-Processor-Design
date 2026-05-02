## 8-Bit Micro-coded ALU Processor
In this project, I designed and implemented a microcoded 8-bit processing unit on an Altera DE2 FPGA board. The system features a custom-designed 4-bit Finite State Machine (FSM) that serves as the control unit, orchestrating operations across two distinct Arithmetic Logic Units (ALUs) 

## Key Implementation Details

* Hardware Platform: Leveraged the Terasic DE2 board, utilizing physical switches for operant inputs (A and B) and LEDs/7-segment displays for a real-time state and output visualization.

* Control Path: Developed a 4-bit FSM that cycles through instruction indices. A 4x16 decoder processes this output to generate a one-hot microcode control bus, which enables specific ALU functions.

*
