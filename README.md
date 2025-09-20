# Assembly_Projects

This repository contains assembly language projects demonstrating fundamental concepts in microcontroller programming. The projects were developed using the **AT89C51 microcontroller** and a **Proteus simulation environment**. They make use of a connected **4x4 keypad** and a **16x2 LCD display**.

---

## Project 1: Basic Calculator
**File:** `calculator.asm`

### Description
This project implements a basic calculator that takes two two-digit numbers and an operator (`+`, `-`, `*`, `/`) from the user via the keypad. The program performs the corresponding arithmetic operation and displays the result on the LCD.

#### Key Concepts:
- Reading multi-digit numeric input from a keypad
- ASCII to hexadecimal conversion
- Implementing arithmetic operations (addition, subtraction, multiplication, division)
- Conditional logic and control flow
- Displaying output on an LCD

---

## Project 2: Timer-Based Frequency Generator
**File:** `frequency_generator.asm`

### Description
This project uses the microcontroller's internal timer to generate a square wave at a specific frequency. The user inputs two numbers and a character to select one of two different frequency modes and a specific frequency within that mode. The program then generates a **PWM signal** based on the calculated values.

#### Key Concepts:
- Configuring and using the 8051 timer in mode 2 (auto-reload)
- Dynamically calculating timer values to achieve specific frequencies
- Implementing different operational modes based on user input
- Generating a PWM signal on a designated output pin
- User input handling and display on an LCD

---

## Hardware and Software Requirements
- **Microcontroller:** AT89C51  
- **Keypad:** 4x4 Matrix Keypad  
- **Display:** 16x2 LCD  
- **Development Environment:** Proteus 8 Professional with ASEM-51 compiler

---

## Usage
1. Open the Proteus project file (**not included in repo**).
2. Import the assembly code for the AT89C51 microcontroller.
3. Simulate the circuit to test the functionality.
   - For the **calculator**: Enter two numbers and an operator.
   - For the **frequency generator**: Follow the on-screen prompts for input.

---

