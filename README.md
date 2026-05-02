**Note:** This repository currently contains the core ALU logic. The full project environment and control unit (FSM) files will be uploaded once migrated from the lab workstation.

# 8-Bit Micro-coded ALU Processor
This project implements an 8-bit microcoded processor on an FPGA, using a finite state machine (FSM) to control arithmetic and logic operations across a shared datapath.

This project demonstrates how control units and datapaths interact in processor design, a fundamental concept in computer engineering.

## Key Components

* **Registers (Latch 1 & 2):** Two 8-bit registers used to capture and hold operands \(A\) and \(B\) from the DE2 board's physical switches.

* **Control Unit (FSM):** A 4-bit state machine that cycles through states 0–8, acting as the instruction sequencer.

* **4x16 Decoder:** Converts the FSM state into a "one-hot" microcode vector, ensuring only one ALU operation is active per clock cycle.

* **Dual ALUs:** Two separate logic blocks (ALU_1 for basic math, ALU_2 for complex bit manipulation) that share the same control path.
  * **ALU_1:** Implements core arithmetic and logic operations (addition, subtraction, bitwise logic).
    
  * **ALU_2:** Demonstrates datapath flexibility by supporting advanced bit manipulations (rotations, shifts, inversions) using the same control structure.

## Hardware Mapping (DE2 Board)

* **Switches (SW):** Used for manual data input of 8-bit operands A and B.

* **Keys (Buttons):** Used for `Clock` pulses and system `Reset`.

* **LEDs/7-Segment:** Provide visual feedback of the current FSM state and the 8-bit `Result`.

## Inputs and Signals

- `A[7:0]` – 8-bit input operand A  
- `B[7:0]` – 8-bit input operand B  
- `OP[15:0]` – Control signals from decoder (one-hot encoded)  
- `clk` – System clock  
- `reset` – Resets FSM and registers  
- `load_A` – Loads value into register A  
- `load_B` – Loads value into register B  
- `Result[7:0]` – Output of ALU

## ALU Operations

* **ALU_1:**

| State | OP Bit | Operation |
|------|--------|----------|
| 0    | OP(0)  | A + B |
| 1    | OP(1)  | A - B |
| 2    | OP(2)  | A AND B |
| 3    | OP(3)  | A OR B |
| 4    | OP(4)  | A XOR B |
| 5    | OP(5)  | NOT (A AND B) |
| 6    | OP(6)  | NOT (A OR B) |
| 7    | OP(7)  | A + 1 |
| 8    | OP(8)  | B + 1 |

* **ALU_2:**
  
| State | OP Bit | Operation |
|------|--------|----------|
| 0    | OP(0)  | Rotate A right by 4 bits |
| 1    | OP(1)  | A XOR B |
| 2    | OP(2)  | Inverse bit significance of B |
| 3    | OP(3)  | (A + B) - 2 |
| 4    | OP(4)  | Rotate B left by 2 bits|
| 5    | OP(5)  | Invert even bits of B |
| 6    | OP(6)  | Swap A and B’s lower 4 bits) |
| 7    | OP(7)  | Shift B to the right by 2 bits, input bit = 0 |
| 8    | OP(8)  | Invert 4 lower bits of A |

## Simulation

The design was verified using waveform simulation in Quartus to confirm correct ALU outputs for each state.

#### **ALU_1: Arithmetic & Logic Operations**
This simulation confirms the execution of basic arithmetic (addition/subtraction) and bitwise logic. You can observe the `Result` bus updating as the FSM cycles through instruction states.

<img width="685" height="346" alt="Screenshot 2026-05-02 174556" src="https://github.com/user-attachments/assets/1df45ce3-71fc-437c-acea-c648bbab96b4" />

#### **ALU_2: Complex Bit Manipulations**
This simulation verifies the custom bit-shuffling logic, including rotations and inversions. It demonstrates the initial system `reset` and the synchronous `load` of operands A and B.

<img width="684" height="364" alt="Screenshot 2026-05-02 174530" src="https://github.com/user-attachments/assets/86e71985-8407-46c7-baf1-4f5d6b40e7c3" />

## Results

- Successfully implemented and tested on DE2 FPGA board  
- Verified correct operation across all FSM states using simulation  
- Demonstrated separation of control path and datapath in a working system
