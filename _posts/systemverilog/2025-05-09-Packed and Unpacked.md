---
number: 9
title: "SV9. SystemVerilog Packed vs. Unpacked arrays"
date: 2025-05-09
categories:
  - SystemVerilog
tags:
  - Array
excerpt: "Ever wondered how packed vs. unpacked arrays really work in SystemVerilog? This article dives into the syntax, memory layout, and use cases of both - with practical examples and code walkthroughs."
header:
  teaser: /assets/images/9- Packed Unpacked Array.png
classes: wide
---



![Simulation Event Scheduling](/assets/images/9- Packed Unpacked Array.png)

Ever wondered how packed vs. unpacked arrays really work in SystemVerilog? This article dives into the syntax, memory layout, and use cases of both - with practical examples and code walkthroughs.


## Video Tutorial

Watch this comprehensive video explanation of Implicit Net Declaration:

<div class="video-container" style="position: relative; padding-bottom: 56.25%; height: 0; overflow: hidden; max-width: 100%; margin: 20px 0;">
  <iframe 
    src="https://www.youtube.com/embed/fN5iwiw5mRU" 
    style="position: absolute; top: 0; left: 0; width: 100%; height: 100%;" 
    frameborder="0" 
    allowfullscreen>
  </iframe>
</div>

# Packed and Unpacked Arrays in SystemVerilog

## Packed Arrays (Sub-fields)

Packed arrays are treated as contiguous sets of bits. They are ideal for modeling hardware registers and buses since the bits are stored together in memory.

### Example

```verilog
logic [1:0][15:0] bus_w; // 32-bit bus: two 16-bit vectors
logic [15:0] data16;
assign data16 = bus_w[1];     // Get upper 16 bits
assign a      = bus_w[0][15]; // Access bit 15 of lower half
```

**Explanation:**
- `bus_w` is a 2D packed array: 2 elements, each 16 bits wide.
- Packed dimensions are declared to the left of the variable name.
- The total width of `bus_w` is 32 bits, and operations like slicing or bit selection are straightforward.

![2-D Packed Array](/assets/images/9- B Two-D Array.png)

---

## Unpacked Arrays

Unpacked arrays represent data where each element can be accessed individually, and each element may itself be a vector. Unlike packed arrays, they are **not stored contiguously** in memory and are more flexible in size and shape. The hardware implementation depends on synthesis tools and can be similar to packed arrays.

### Examples

```verilog
logic [31:0] mem [0:3];         // 4 elements, each 32 bits
logic [15:0] data2d [0:3][0:1]; // 2D array, 4 rows x 2 columns of 16-bit vectors
logic [7:0]  data2d [4][2];     // Same as above, different index
logic        data [0:3];        // 4 elements, each 1 bit
```

### Accessing Elements

```verilog
logic [31:0] data32;
logic [7:0]  data8;

data32 = mem[2];       // Reads the third 32-bit word
data8  = data2d[2][1]; // Reads from row 2, column 1 (8-bit value)
```

---

## List Initialization

SystemVerilog provides a concise way to assign values using list syntax:

```verilog
logic [31:0] d0, d1, d2, d3;
mem = '{32'h0000_0000, 32'h1111_1111, 32'h2222_2222, 32'h3333_3333};
mem = '{d0, d1, d2, d3}; // Uses previously assigned values
```

### 2-D List Assignment

```verilog
logic [15:0] data2d [0:3][0:1];
data2d = '{
    '{8'h00, 8'h01},
    '{8'h02, 8'h03},
    '{8'h04, 8'h05},
    '{8'h06, 8'h07}
};
```

Equivalent to:
```verilog
data2d[0][0] = 8'h00;
data2d[0][1] = 8'h01;
// ...
data2d[3][1] = 8'h07;
```

---

## Default Initialization

Need to zero-out an entire memory? SystemVerilog makes it easy:

```verilog
logic [31:0] mem [0:3];
mem = '{default: '0};
```
This assigns `0` to each of the four 32-bit elements in `mem`.

---

## Mixed Packed-Unpacked Arrays

Consider the following example:

```verilog
logic [2:0][7:0] mem [4];
```

Let's break it down:

- `[2:0][7:0]`: This is a 2-dimensional **packed array**.
  - `[7:0]`: 8-bit field (byte).
  - `[2:0]`: 3 elements of 8 bits each → forms a 24-bit wide vector.
- `mem [4]`: **Unpacked array** of 4 elements.

**Meaning:**
- `mem` is an array of 4 elements (`mem[0]` to `mem[3]`).
- Each element is a 24-bit vector composed of three packed 8-bit segments.

![Mixed Packed-Unpacked Arrays](/assets/images/9- C Mixed Packed-Unpacked Arrays.png)

### Assignment Example

```verilog
mem[1] = 24'hcd_ef12; // The underscore _ is for readability
```
This effectively does:

```verilog
mem[1][2] = 8'hCD; // Most significant byte
mem[1][1] = 8'hEF;
mem[1][0] = 8'h12; // Least significant byte
```

### Sub-field Operations

```verilog
mem[3][2][7:4] = mem[0][1][3:0];
```

Here, we are copying the lower 4 bits of `mem[0][1]` (middle byte of the first element) into the upper 4 bits of `mem[3][2]` (MSB byte of the last element).

![Mixed Packed-Unpacked Arrays](/assets/images/9- D Mixed Packed-Unpacked Arrays.png)

---