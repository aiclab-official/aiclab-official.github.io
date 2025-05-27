---
number: 7
title: "SV7. SystemVerilog Built-in Data types: Data Type and Types"
date: 2025-05-07
categories:
  - SystemVerilog
tags:
  - Data Type
  - Net
  - Variable
excerpt: "It covers the key distinctions between:
Nets (representing connections) and Variables (representing storage).
2-state and 4-state data types, and how they relate to the keywords bit and logic.
How to perform fixed and variable bit/range selection on vectors."
header:
  teaser: /assets/images/7- Logic Net Variable.png
classes: wide
---



![Simulation Event Scheduling](/assets/images/7- Logic Net Variable.png)

## Video Tutorial

Watch this comprehensive video explanation of Data Type and Types:

<div class="video-container" style="position: relative; padding-bottom: 56.25%; height: 0; overflow: hidden; max-width: 100%; margin: 20px 0;">
  <iframe 
    src="https://www.youtube.com/embed/Jux_-AGtFMg" 
    style="position: absolute; top: 0; left: 0; width: 100%; height: 100%;" 
    frameborder="0" 
    allowfullscreen>
  </iframe>
</div>

# Data Type and Types in SystemVerilog

In SystemVerilog, a signal is defined with both a **Data Type** and a **Type**.

---

## Data Type

Data types can be broadly categorized into **Nets** and **Variables**.

- **Nets** are like physical wires, representing connections between components. They connect a driver (source) to a receiver (destination), transmitting signals between parts of a design.
- **Variables** are abstract storage elements, used mainly in simulation. For synthesis, variables might translate into physical registers based on their definition and usage.

---

## Type

Types are distinguished by the number of states they can represent:

- **2-state types**: Can hold values of `0` or `1`.
- **4-state types**: Can represent `0`, `1`, high impedance (`Z`), or unknown (`X`).

- The keyword `logic` declares a variable or a net as a **4-state** type.
- The keyword `bit` declares a **2-state** type.

**Variables** can be either 2-state or 4-state types.  
**Nets** are restricted to being only 4-state types.

---

## Nets

Nets function as connections, **not** storage elements. They represent the current value of their driver, can have multiple drivers, and **must** be of the `logic` type.

> If a signal is used but not explicitly declared, it is typically inferred as a net.

| Type | Description |
|------|-------------|
| `wire` | An interconnection wire that can have multiple drivers |
| `tri`  | Exactly the same as `wire`. It can be used to emphasize tri-state values |

### Net Data Type

Nets: Declaration and assignment examples:

#### Explicit continuous assignment:
```verilog
wire logic [31:0] data; // 32-bit packed vector
assign data = a * b;    // Explicit continuous assignment
```

#### Implicit continuous assignment:
```verilog
wire logic [31:0] data = a * b; // Implicit continuous assignment
```

Both methods are functionally equivalent.

> **Note:**  
> - Nets **cannot** have subfields (e.g., no `wire logic [7:0][7:0] data8;`)
> - Nets must be **packed arrays**, not unpacked arrays (e.g., `wire logic [7:0] data8[7:0];` is illegal).

---

## Variables

Within procedural blocks (like `always` blocks), the left-hand side of an assignment **must** be a variable.

- **4-state variables:** Use `var logic` for values that can be `0`, `1`, `X`, or `Z`.
- **2-state variables:** Use `var bit` for values restricted to `0` or `1`.

**Best practice:** Use the `logic` type for variables in RTL code to allow the simulator to detect indeterminate states (`X`).  
Use `bit` type mainly for iterators in `for` loops or testbenches.

| Type      | Description              | Equivalent         | n-state | Default Sign |
|-----------|-------------------------|--------------------|---------|--------------|
| `integer` | 32-bit variable         | var logic[31:0]    | 4-state | signed       |
| `bit`     | General purpose variable| -                  | 2-state | unsigned     |
| `byte`    | 8-bit variable          | var bit[7:0]       | 2-state | signed       |
| `shortint`| 16-bit variable         | var bit[15:0]      | 2-state | signed       |
| `int`     | 32-bit variable         | var bit[31:0]      | 2-state | signed       |
| `longint` | 64-bit variable         | var bit[63:0]      | 2-state | signed       |

---

## Synthesizable Variable Data Types

- Use **2-state data types** (`bit`) primarily for validation and testbench development. This enhances simulation efficiency.
- Use **4-state data types** (`logic`) for RTL code to catch indeterminate logic.

---

## Logic Data Type

The `logic` data type is versatile:

- By default, `logic` is interpreted as a **variable** (`var logic`).
- For input or inout ports, `logic` is interpreted as a **net** (`wire logic`).

> Variables do **not** support multiple drivers. For multi-driven signals (e.g., tri-state buses), use `wire logic` or `tri logic`.

**General guideline:** Use the `logic` data type for signals. Use `wire logic` or `tri logic` only for multi-driven signals.

---

### Logic (Variable): Declaration and Assignment

#### Scalar declaration:
```verilog
logic a; // 1-bit unsigned variable
```

#### Vector declaration:
```verilog
logic [31:0] data_le; // 32-bit vector, little endian (MSB is bit 31, LSB is bit 0)
logic [0:31] data_be; // 32-bit vector, big endian (MSB is bit 0, LSB is bit 31)
```

#### Signed vector:
```verilog
logic signed [15:0] data_sn; // 16-bit signed variable
```

#### Bit and range select:
```verilog
logic [31:0] bus;
logic [7:0] data8;
assign bus = data_le;           // copy entire data_le into bus
assign a = data_be[5];          // fixed bit select (selects bit at index 5)
assign data8 = data_le[15:8];   // 8-bit part select (bits 15 down to 8)
```

> **Important:** The range in part-selects should follow the declaration's endianness.

---

### Variable Bit Select and Range Select

#### Variable bit select:
```verilog
assign bus[0] = data_le[a];
```

#### Variable range select (`[start +: width]` or `[start -: width]`):
```verilog
// [start +: width] expands to [start : (start + width - 1)]
// [start -: width] expands to [start : (start - width + 1)]
assign data8 = data_le[15-:8]; // equivalent to data_le[15:8]
```

#### Parameterized variable range select:
```verilog
parameter WIDTH = 32;
logic [WIDTH-1:0] data;
logic [7:0] slice;
logic [4:0] start;
assign start = 3;
assign slice = data[start +: WIDTH]; // Accessing a slice based on 'start' and 'WIDTH'
```