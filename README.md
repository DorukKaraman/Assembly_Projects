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

## Project 3: PWM Duty Cycle Generator

* **File:** `cycle_generator.asm`  
* **Description:** This project creates a Pulse Width Modulation (PWM) signal with a user-defined duty cycle. The program reads two digits from the keypad to determine the duty cycle percentage. It then uses subroutines with fixed delays to generate the high and low portions of the square wave, effectively controlling the duty cycle. This project is a good example of how to implement a PWM signal without using the built-in timer features.

---

## Project 4: Timer Interrupt Counter

* **File:** `timer_interrupt.asm`  
* **Description:** This project uses a timer interrupt to count events. The program configures the microcontroller's timer to interrupt the main loop after a specific number of clock cycles. The interrupt service routine increments a counter, and the main program then displays the final count on the LCD. This project highlights a different approach to timer programming by using interrupts, which is more efficient for multitasking than a polling-based loop.

---

### Project 5: Array Comparison and Counter

* **File:** `array_comparison.asm`
* **Description:** This program compares two pre-defined arrays of numbers to find common elements. It iterates through each element of a smaller array and searches for it within a larger array. When a match is found, the value is stored in a separate memory location, and a counter is incremented.

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
   - For the **PWM duty cycle generator**: Input two digits to set the duty cycle percentage, e.g., "50" for 50%.
   - For the **timer interrupt counter**: Run the simulation and observe the counting on the LCD display.
   - For the **array comparison**: The program will run automatically on startup. The results (found values and the total count) will be stored in internal memory, which can be inspected in the Proteus simulation environment.

---

