# Enhanced Traffic Light Controller

## Project Overview
This project implements an **Enhanced Traffic Light Controller** using **Verilog**, featuring adaptive timing and pedestrian crossing signals. It is designed to improve traffic flow and pedestrian safety by incorporating pedestrian walk signals and dynamic traffic light timing.

---

## Features
- **Adaptive Traffic Control**: Adjusts traffic light timing based on vehicle traffic conditions and pedestrian crossings.
- **Pedestrian Walk Signals**: Includes a pedestrian button that activates walk signals, adjusting traffic patterns accordingly.
- **State Machine Design**: Manages vehicle and pedestrian signals through an adaptive state machine.
- **Real-time Simulation & Verification**: Simulated using **ModelSim**, synthesized, and verified using **Quartus Prime**.

---

## Tools Used
- **Verilog**: For coding the traffic light controller.
- **ModelSim**: For simulating and verifying the design.
- **Quartus Prime**: For synthesizing the design and generating RTL schematics.

---

## Functional Description
1. **Traffic Signal Control**: Manages the flow of vehicles at intersections with green, yellow, and red signals.
2. **Pedestrian Signal Control**: Allows pedestrians to press a button and trigger a walk signal, pausing vehicle traffic for safe crossing.
3. **State Transitions**: The state machine adapts dynamically based on traffic and pedestrian inputs, controlling light signals accordingly.

---

## Simulation & Testing

### Steps to Simulate in ModelSim:
1. Compile the Verilog source code.
2. Set up the testbench for generating clock and input signals.
3. Run the simulation using **Run All**.
4. View waveforms in the **Wave** window to observe signal transitions.

### Synthesis in Quartus Prime:
1. Import Verilog code into **Quartus Prime**.
2. Synthesize the design.
3. Verify using RTL Viewer and check timing reports.

