# EE 306 – LC-3 Programming Assignments
**Department of Electrical and Computer Engineering, The University of Texas at Austin**  
Instructor: Yale N. Patt  
Fall 2023

---

## Overview
This repository contains LC-3 programs for **EE 306: Introduction to Computer Systems**, Fall 2025. Each program implements a fundamental computer engineering concept, including integer comparison, bit manipulation, array sorting, and linked list operations.

All programs are written in **LC-3 machine language or assembly** and are intended to be run on the **LC-3 Simulator**.

---

## Assignments

### **Programming Assignment 1**
**Part 1 – Compare Two 2’s Complement Integers**  
- **Description:** Compares two integers stored at memory locations `x3100` and `x3101`.  
- **Output:** Stores `-1` if X > Y, `0` if X = Y, and `1` if X < Y in memory location `x3102`.  
- **File:** `comparison.bin`  

**Part 2 – Find First '1' in Bit Vector**  
- **Description:** Finds the index of the first `1` in a bit vector stored at `x3100`.  
- **Output:** Stores the index in memory location `x3101`.  
- **File:** `bsr.bin`  

---

### **Programming Assignment 2 – Sort an Array of 2’s Complement Integers**
- **Description:** Sorts an array of 2’s complement integers in **descending order**.  
- **Input:** Base address of array at `x3200`, number of elements at `x3201`.  
- **Output:** Sorted array stored starting at the same base address.  
- **File:** `sort.asm`  

---

### **Programming Assignment 3 – Insert New Recruit into Linked List**
- **Description:** Inserts a new node into a sorted linked list roster based on player position and depth chart. Updates depth chart numbers for remaining nodes.  
- **Input:**  
  - Old roster head pointer at `x4000`  
  - New recruit pointer at `x4001`  
- **Output:** Updated roster linked list in-place.  
- **File:** `insert_recruit.asm`  

---

## Usage
1. Load the program into the **LC-3 Simulator**.
2. Manually set memory values for test cases as required.
3. Run the program and observe memory updates to verify correctness.

---

## Notes
- Programs assume **LC-3 architecture constraints**.
- Memory is directly manipulated; no dynamic allocation is used.
- Programs are written individually for each assignment to ensure proper grading and testing.

---

## License
All code and materials are intended for educational purposes for EE 306, Fall 2023 at UT Austin.

# Nim Game – EE 306 Lab 4

**Department of Electrical and Computer Engineering, The University of Texas at Austin**  
**Course:** EE 306 – Fall 2023 
**Lab:** 5 – Stone Game (Nim)  

---

## Overview
This project implements the classic **Nim game**, referred to here as **Stone**, where two players take turns removing stones from a set of rows. The game continues until the last stone is removed. In this version:  

- Players: **Player 1** and **Player 2**  
- Game board: multiple rows of stones, with each row containing a variable number of stones  
- Rules: Players take turns removing **one or more stones** from a single row.  
- **Objective:** Avoid being the player forced to remove the last stone. The player who removes the last stone **loses**.  

---

## How to Play
1. Start the game.  
2. Players alternate turns.  
3. On a turn, a player selects a **row** and a number of stones to remove.  
4. The game continues until all stones are removed.  
5. The player who removes the **last stone loses**, and the other player wins.  

---

## Features
- Interactive **turn-based gameplay** between two players.  
- Displays the current state of the game board after each move.  
- Validates player input to ensure legal moves.  
- Automatically determines the winner at the end of the game.  

---

## Files
- `nim.asm` – LC-3 assembly program implementing the Nim game (Stone).  

---

## Usage
1. Load `nim.asm` into the **LC-3 Simulator**.  
2. Run the program and follow the on-screen instructions for selecting rows and stones.  
3. Continue until the game ends, and the program announces the winner.  

---

## Notes
- The game is implemented using **LC-3 memory and registers** for state management.  
- No extra memory is used beyond what is required for the game board and players.  
- Designed for educational purposes to explore **loops, conditionals, and user interaction** in LC-3 assembly.  

---

## License
Educational project for **EE 306, Fall 2023** at The University of Texas at Austin.

# Lab 5 – Polling vs Interrupt Driven I/O

**Department of Electrical and Computer Engineering, The University of Texas at Austin**  
**Course:** EE 306 – Fall 2023  
**Lab:** 6 – Keyboard I/O: Polling vs Interrupts  

---

## Overview
The purpose of this lab is to demonstrate the difference between **polling-based I/O** and **interrupt-driven I/O** using the **keyboard** as an input device. Students will implement two versions of a program that prints banners and receives a user input specifying the time dinner will be served.  

- **Polling-based I/O:** The program waits for user input before continuing.  
- **Interrupt-driven I/O:** The program can continue executing while waiting for input, and the input is handled asynchronously via an **interrupt service routine (ISR)**.  

---

## Part 1 – Polling-Based I/O

### Program Behavior
1. Start execution at memory location `x3000`.  
2. Print the following banner **10 times**:
====================
* *** ****
* * * * *
* ***** ****
* * * * *
***** * * ****

 * * ***** ***** * * * ***** ***** * * * **** ====================
Banners left to print: N
====================
Banners left to print: N
- `N` indicates the **number of banners remaining**.  
- After printing the **first banner**, the program waits for the user to press a number key (1–9) to indicate the **dinner time**.  
- Example input: `4`  

Part 2b – Keyboard Interrupt Service Routine (ISR)

Starts at x1000.

Executes when a key is pressed, printing dinner time:

<line feed>
Dinner will be served at X:00 PM
<line feed>


Include two newlines: one before and one after the text.

Save and restore all registers used.

End with RTI instruction.

Optionally, disable further interrupts if only one input is expected.

Part 2c – Operating System Enabling Code

Located at x0800 (privileged space).

Sets up the keyboard interrupt vector (x80) to point to the ISR at x1000.

Ensures unprivileged mode after enabling interrupts.

The program counter starts at x800, and R6 contains x3000 (system stack base).

Implementation Notes

Interrupts can occur at any time, so ISR output may appear in the middle of banner printing.

Ensure all registers are properly saved/restored in the ISR to avoid corrupted output (� on console indicates missed save/restore).

Include a delay routine to make banner output observable.

Do not change the system stack base (R6 = x3000).

The number of banners can be increased if the machine outputs too quickly for input testing.

Submission Instructions

Submit two programs:

Polling-based solution: polling.asm

Interrupt-based solution: interrupt.asm

Submit both files on Canvas.

Sample Output (Polling Example)
====================
* *** ****
* * * * *
***** ****
* * * * *
***** *
* * **** *
* * *****
***** * *
* * ****
====================
Banners left to print: 9
Dinner will be served at 4:00 PM
...

For the interrupt-driven version, the Dinner will be served at X:00 PM message may appear at any point during banner printing.

License

Educational project for EE 306, Fall 2023 at The University of Texas at Austin.

