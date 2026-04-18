# 📘 4-bit Barrel Shifter – Verilog

## 🔹 Overview

This project implements a **4-bit Barrel Shifter** in Verilog along with its testbench.
A barrel shifter performs **multi-bit shift operations in a single clock cycle**, making it faster than sequential shifters.

The design supports:

* Left circular shift
* Right circular shift

---

## 🔹 Features

* 4-bit input data
* 2-bit shift control (`sel_i`) → shift by 0–3 positions
* Mode selection:

  * `0` → Left shift
  * `1` → Right shift
* Circular (rotational) shifting
* Structural design using **4:1 multiplexers**
* Alternative behavioral implementation available (commented)

---

## 🔹 Module Description

### 📌 Inputs

* `a_i [3:0]` → Input data
* `sel_i [1:0]` → Shift amount
* `mode_i` → Shift direction

  * `0` → Left shift
  * `1` → Right shift

### 📌 Outputs

* `dout_o [3:0]` → Shifted output

---

## 🔹 Working Principle

### 🔸 Barrel Shifting

* Performs shifting in **one step** using multiplexers
* Avoids iterative shifting → improves speed

### 🔸 Left Circular Shift

Example (Input = `abcd`):

| Shift | Output |
| ----- | ------ |
| 0     | abcd   |
| 1     | bcda   |
| 2     | cdab   |
| 3     | dabc   |

---

### 🔸 Right Circular Shift

Example (Input = `abcd`):

| Shift | Output |
| ----- | ------ |
| 0     | abcd   |
| 1     | dabc   |
| 2     | cdab   |
| 3     | bcda   |

---

## 🔹 Design Approaches

### 🔸 Design 1 (Commented – Behavioral)

```id="bs_behav"
dout_o = (a_i << sel_i) | (a_i >> (4 - sel_i))   // Left
dout_o = (a_i >> sel_i) | (a_i << (4 - sel_i))   // Right
```

### 🔸 Design 2 (Implemented – Structural)

* Uses **4:1 MUX blocks**
* Separate paths:

  * `lout` → Left shift result
  * `rout` → Right shift result
* Final output selected using `mode_i`

---

## 🔹 MUX Description

### 📌 4:1 Multiplexer (`MUX4b`)

* Selects one of four inputs based on `sel_i`

| sel_i | Output |
| ----- | ------ |
| 00    | a_i    |
| 01    | b_i    |
| 10    | c_i    |
| 11    | d_i    |

---

## 🔹 Testbench Details

The testbench (`tb_bShifter4b`) verifies:

### 🔸 Input

* Fixed input: `0111`

### 🔸 Test Coverage

* Left shift (mode = 0)

  * Shift by 0, 1, 2, 3
* Right shift (mode = 1)

  * Shift by 0, 1, 2, 3

---

## 🔹 Simulation

### ▶️ Tools

* ModelSim / QuestaSim
* Xilinx Vivado
* Icarus Verilog + GTKWave

### ▶️ Run (Icarus Verilog Example)

```bash id="bs_run"
iverilog -o bShifter4b.vvp bShifter4b.v tb_bShifter4b.v
vvp bShifter4b.vvp
gtkwave bShifter.vcd
```

---

## 🔹 Output

* Console output using `$monitor`

* Displays:

  * Input data
  * Shift amount
  * Mode
  * Output

* Waveform dump file:

  ```
  bShifter.vcd
  ```

---

## 🔹 Sample Output Format

```id="bs_sample"
Time: 10 | Input: 0111, Sel: 01, Mode: 0 | Output: 1110
```

---

## 🔹 Applications

* ALUs in processors
* Data rotation in cryptographic systems
* Signal processing
* Bit manipulation operations in embedded systems

---

## 🔹 Design Insights

* Structural design using MUX improves hardware understanding
* Behavioral design is compact but less illustrative
* Barrel shifter provides **constant-time shifting**

---

## 🔹 File Structure

```id="bs_struct"
├── bShifter4b.v        # Barrel Shifter Design
├── MUX4b.v             # 4:1 Multiplexer Module
├── tb_bShifter4b.v     # Testbench
├── bShifter.vcd        # Waveform output (generated)
└── README.txt          # Documentation
```
