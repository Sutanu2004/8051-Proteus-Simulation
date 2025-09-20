# 8051-Proteus-Simulation
An entire 8051 development board simulated in Proteus, interfaced with external RAM, 8255 port extender
# 8085 Microprocessor System with 8255, External RAM, and Address Decoding

## Overview

This project implements a complete **8085 microprocessor-based system** in Proteus. The system integrates:

* The **8085 CPU**
* An **8255 Programmable Peripheral Interface (PPI)** as a port extender
* **External SRAM (6264)** for read/write memory
* Address decoding using a **74HC154** or **74HC138**
* **Latch (74LS373)** for multiplexed address/data separation

The system allows executing user programs that control LEDs, read inputs, and perform memory operations, just like a small microcomputer.

---

## Components Used

* **8085 Microprocessor** – core CPU
* **8255 PPI** – used for I/O port expansion
* **6264 SRAM (8KB)** – external memory for data storage
* **74LS373** – latching lower address byte (A0–A7)
* **74HC154 / 74HC138** – address decoders for chip select generation
* **Pull-up resistors** – for Port 0 (multiplexed address/data bus)
* **Clock + Reset circuit** – to start the processor

---

## Hardware Design

### 1. Address/Data Bus Multiplexing

* The **8085 (like the 8051)** multiplexes **A0–A7 with D0–D7** on AD0–AD7.
* A **74LS373 latch** is used with **ALE** to capture A0–A7 for stable addressing.

### 2. Address Decoding

* High address lines (A15–A12) are decoded using **74HC154** or **74HC138**.
* Example mapping:

  * **9000H–9FFFH** → External SRAM (6264)
  * **E800H–E803H** → 8255 (Port A, B, C, Control)

### 3. Memory (6264 SRAM)

* Connected as 8-bit parallel SRAM.
* Address lines: A0–A12 (13 bits → 8KB)
* Data lines: D0–D7 ↔ CPU data bus (AD0–AD7)
* **/CE** = decoded select for 9000H–9FFFH
* **/OE** = RD from CPU
* **/WE** = WR from CPU

### 4. 8255 PPI

* Mapped at **E800H–E803H**
* Internal registers selected using A0–A1:

  * A0=0, A1=0 → Port A
  * A0=1, A1=0 → Port B
  * A0=0, A1=1 → Port C
  * A0=1, A1=1 → Control Register

### 5. Control Signals

* **RD** and **WR** from CPU connected to both 8255 and 6264
* **CS** lines from decoder ensure only one device is active at a time
* **ALE** used to drive latch

---

## Software/Program Examples

### Example 1: Configure 8255

```assembly
MVI A, 80H    ; Set Port A output, others input
OUT E803H     ; Write control word to 8255
```

### Example 2: Write to External RAM

```assembly
LXI H, 9550H
MVI A, 55H
SHLD 9550H    ; Write 55H at 9550H
```

### Example 3: Blink LED on Port A

```assembly
MVI A, 82H
OUT E803H      ; Port A as output
LOOP: MVI A, 01H
OUT E800H      ; Write 01H to Port A
CALL DELAY
MVI A, 00H
OUT E800H
CALL DELAY
JMP LOOP
```

---

## Simulation in Proteus

The system was fully simulated in **Proteus**. Key observations:

* **Port 0** requires pull-up resistors for correct operation.
* Address decoding works correctly for both **8255** and **external SRAM**.
* Writing to **9000H–9FFFH** stores and retrieves data from the 6264.
* Writing to **E803H** updates the 8255 control register.


 peripherals like ROM, displays, and serial interfaces, making it a complete embedded learning platform.
