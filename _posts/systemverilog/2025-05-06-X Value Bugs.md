---
number: 6
title: "SV6. X Value Bugs in Digital Circuit Design (FPGA/ASIC)"
date: 2025-05-06
categories:
  - SystemVerilog
tags:
  - Bugs
  - X-value
excerpt: "𝗫 can represent an uninitialized state, uncertainty, or a conflict in multiple driver situations. 
The X value does not physically exist in real hardware. 𝗦𝗶𝗺𝘂𝗹𝗮𝘁𝗶𝗼𝗻𝘀 tools interpret it as unknown logic. 
𝗦𝘆𝗻𝘁𝗵𝗲𝘀𝗶𝘀 tools interpret X as a don't care value."
header:
  teaser: /assets/images/6- X-Bugs.png
classes: wide
---



![Simulation Event Scheduling](/assets/images/6- X-Bugs.png)

## Video Tutorial

Watch this comprehensive video explanation of X Value Bugs:

<div class="video-container" style="position: relative; padding-bottom: 56.25%; height: 0; overflow: hidden; max-width: 100%; margin: 20px 0;">
  <iframe 
    src="https://www.youtube.com/embed/Cup6Wode6Uo" 
    style="position: absolute; top: 0; left: 0; width: 100%; height: 100%;" 
    frameborder="0" 
    allowfullscreen>
  </iframe>
</div>

# Understanding 'X' Values in Digital Design

`X` can represent an uninitialized state, uncertainty, or a conflict in multiple driver situations. The `X` value does **not** physically exist in real hardware:

- **Simulation tools** interpret `X` as unknown logic.
- **Synthesis tools** interpret `X` as a don’t care value.

> **Note:** `X` can indicate several types of bugs that might cause issues in your actual hardware. Below are key scenarios where ‘X’ values often point to design problems:

---

## 1. Uninitialized Registers

Without proper initialization, registers maintain an ‘X’ value in simulation. In real hardware, these registers will power up to unpredictable values, causing inconsistent behavior:

```verilog
always_ff @(posedge clk) begin
    if (enable)
        q <= d; 
    // Missing else clause and no reset logic
end
```
Or:
```verilog
always_ff @(posedge clk) begin
    if (reset)
        counter <= 4'b0000;
    else if (enable)
        counter <= counter + 1;
    // Missing else clause can create X during simulation
end
```

---

## 2. Incomplete Case Statements

When `sel` is `2'b11`, `out` becomes ‘X’ in simulation, showing a potentially latched signal or unintended behavior in hardware:

```verilog
always_comb begin
    case(sel)
        2'b00: out = a;
        2'b01: out = b;
        2'b10: out = c;
        // Missing 2'b11 case
    endcase
end
```

---

## 3. Cross-Clock Domain Issues

When signals cross between clock domains without proper synchronization, metastability can occur, appearing as ‘X’ values in simulation:

```verilog
// Clock domain A
logic signal_a;
// Clock domain B (no synchronizer)
always_ff @(posedge clk_b)
    captured_signal <= signal_a; // Potential metastability = X
```

---

## 4. Signal Conflicts (Multiple Drivers)

When both conditions are true simultaneously, the bus has multiple drivers causing an ‘X’ state (Nets can have multiple drivers. Variables do not support multiple-driver.):

```verilog
assign bus = condition ? value1 : 1'bz;
// Some code
assign bus = other_condition ? value2 : 1'bz;
```

---

## 5. Out-of-Range Array Indexing

This returns ‘X’ in simulation but might access invalid memory in hardware:

```verilog
logic [7:0] memory [0:15];
logic [4:0] address; // Can address beyond valid range (0-15)
logic [7:0] data = memory[address]; // X when address > 15
```

---

## 6. Incomplete Conditional Assignments

If neither condition is met, `output_signal` keeps its previous value, potentially becoming ‘X’:

```verilog
always_comb begin
    if (condition1)
        output_signal = value1;
    else if (condition2)
        output_signal = value2;
    // Missing final else clause
end
```

---

## 7. X-Optimism in Simulation vs. Reality

Simulators may handle ‘X’ values differently than actual hardware. In real hardware, an ‘X’ becomes either ‘0’ or ‘1’, potentially masking issues seen in simulation:

```verilog
if (control_signal === 1'bx)
    result = safe_value; // X-pessimism protection
else
    result = control_signal ? value1 : value2;
```