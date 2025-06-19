---
number: 12
title: "SV12. Difference between Bitwise NOT (~) and Logical NOT (!)"
date: 2025-05-12
categories:
  - SystemVerilog
tags:
  - Arithmetic
excerpt: "When working with Verilog or SystemVerilog, it's crucial to understand the distinction between the bitwise NOT operator (`~`) and the logical NOT operator (`!`). While they might seem similar, they behave differently and are intended for distinct purposes. Using them incorrectly can lead to subtle bugs that are hard to track down."
header:
  teaser: /assets/images/12- Diff Bitwise vs Logical Not.png
classes: wide
---



![Signed Arithmetic](/assets/images/12- Diff Bitwise vs Logical Not.png)

When working with Verilog or SystemVerilog, it's crucial to understand the distinction between the bitwise NOT operator (`~`) and the logical NOT operator (`!`). While they might seem similar, they behave differently and are intended for distinct purposes. Using them incorrectly can lead to subtle bugs that are hard to track down.


## Video Tutorial

Watch this comprehensive video explanation of Difference between Bitwise NOT (~) and Logical NOT (!):

<div class="video-container" style="position: relative; padding-bottom: 56.25%; height: 0; overflow: hidden; max-width: 100%; margin: 20px 0;">
  <iframe 
    src="https://www.youtube.com/embed/7QFx2fiupSQ" 
    style="position: absolute; top: 0; left: 0; width: 100%; height: 100%;" 
    frameborder="0" 
    allowfullscreen>
  </iframe>
</div>

## Quick Reference

| Operator | Name | Purpose | Input | Output | Use Case |
|----------|------|---------|-------|--------|----------|
| `~` | Bitwise NOT | Inverts each bit | Any width | Same width as input | Bit manipulation |
| `!` | Logical NOT | Logical negation | Any width | 1-bit (0 or 1) | Boolean conditions |

## Detailed Explanation

### Bitwise NOT (`~`) - Invert Operator

The bitwise NOT operator, also known as the "invert" operator, performs a bit-by-bit inversion of its operand. This means each `0` becomes a `1`, and each `1` becomes a `0`. The result will have the same bit width as the operand. This is also referred to as taking the one's complement.

**Key Characteristics:**
*   Inverts each individual bit of the operand.
*   Returns a value with the same bit width as the operand.

**When to Use `~`:**
*   Use `~` **only** when you need to invert the individual bits of a vector or a scalar value.

**When NOT to Use `~`:**
*   **Do not** use `~` for evaluating logical true/false conditions, especially with multi-bit vectors, as it can lead to unexpected behavior. If any bit in the inverted vector is `1`, the condition will evaluate to true.

**Example:**
```verilog
logic [3:0] data = 4'b1100;
logic [3:0] result = ~data;  // result = 4'b0011
```

### Logical NOT (`!`) - Negate Operator

The logical NOT operator, also known as the "negate" operator, is used for logical negation. It first performs a "reduction OR" on all bits of its operand. If any bit in the operand is `1` (true), the reduction OR results in `1`. If all bits are `0` (false), the result is `0`. If there's an `X` or `Z` and no `1`, the result is `X`. The logical NOT operator then inverts this single-bit result.

**Key Characteristics:**
*   Performs a reduction OR on the operand to get a single 1-bit value (0 for false, 1 for true, X for unknown).
*   Inverts this 1-bit result.
*   **Always** returns a 1-bit value: `1'b1` (true), `1'b0` (false), or `1'bx` (unknown).

**When to Use `!`:**
*   Use `!` **only** to negate the result of a logical expression or a value that represents a true/false condition.

**When NOT to Use `!`:**
*   **Do not** use `!` if your intention is to invert all bits of a multi-bit vector. It will reduce the vector to a single bit before negation.

**Example:**
```verilog
logic [3:0] data = 4'b1100;
logic result = !data;  // result = 1'b0 (because data is not all zeros)
```

## Best Practices

### Correct Usage

#### Use `~` for bit manipulation:
```verilog
logic [7:0] mask = 8'b11110000;
logic [7:0] inverted_mask = ~mask;  // 8'b00001111
```

#### Use `!` for logical conditions:
```verilog
logic enable;
if (!enable) begin
    // Execute when enable is false
end
```

### Common Mistakes

#### Don't use `~` for logical conditions on multi-bit values:
```verilog
logic [3:0] count = 4'b0001;
if (~count) begin  // BUG: ~count = 4'b1110, which evaluates to true!
    // This will execute unexpectedly
end
```

#### Don't use `!` for bit inversion:
```verilog
logic [3:0] data = 4'b1100;
logic [3:0] result = !data;  // BUG: result = 1'b0, not 4'b0011
```

## Complete Code Example

```verilog
module not_operators_example;
    logic       a, r1;
    logic [3:0] b, r2;
    
    initial begin
        // Initialize values
        a = 1'b1;
        b = 4'b1100;
        
        // Bitwise NOT on 1-bit value
        r1 = ~a;        // r1 = 1'b0 OK
        r1 = !a;        // r1 = 1'b0 OK (both work for 1-bit)
        
        // Conditional checks on 1-bit value
        if (~a) $display("~a is true");   // false OK
        if (!a) $display("!a is true");   // false OK
        
        // Operations on multi-bit value
        r2 = ~b;        // r2 = 4'b0011 OK (bitwise invert)
        r1 = !b;        // r1 = 1'b0     OK (logical negate)
        
        // Conditional checks on multi-bit value
        if (~b) $display("~b is true");   // true  BUG!
        if (!b) $display("!b is true");   // false OK
        
        // Correct way to check if all bits are zero
        if (b == 4'b0000) $display("b is all zeros");
        
        // Correct way to check if any bit is set
        if (|b) $display("b has at least one bit set");
    end
endmodule
```

## Guidelines Summary

### When to use `~` (Bitwise NOT):
- Inverting individual bits in a vector
- Creating bit masks
- One's complement operations
- **Never** use for logical true/false conditions on multi-bit values

### When to use `!` (Logical NOT):
- Negating boolean results in conditional statements
- Converting any value to a single-bit true/false result
- **Never** use for bit inversion of multi-bit values

### For Vector Comparisons:
- Use equality operators: `==`, `!=`
- Use relational operators: `<`, `>`, `<=`, `>=`
- Use reduction operators: `|`, `&`, `^` for specific bit operations

## Memory Aid

Think of it this way:
- **`~`** = "**Flip bits**" (bitwise operation)
- **`!`** = "**Is false?**" (logical operation)

Following these guidelines will help you avoid common pitfalls and write more reliable SystemVerilog code.