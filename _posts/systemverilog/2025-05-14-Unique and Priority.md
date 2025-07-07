---
number: 14
title: "SV14. Unique and Priority Identifiers in SystemVerilog"
date: 2025-05-14
categories:
  - SystemVerilog
tags:
  - Procedural Statements
excerpt: "SystemVerilog provides three special keywords (`unique`, `unique0`, and `priority`) that can be used with `case` and `if` statements to provide synthesis tools with optimization hints and enable runtime checking during simulation."
header:
  teaser: /assets/images/14- Unique and Priority.png
classes: wide
---


![Signed Arithmetic](/assets/images/14- Unique and Priority.png)

## Overview

SystemVerilog provides three special keywords (`unique`, `unique0`, and `priority`) that can be used with `case` and `if` statements to provide synthesis tools with optimization hints and enable runtime checking during simulation.


## Video Tutorial

Watch this comprehensive video explanation of Unique and Priority Identifiersing:

<div class="video-container" style="position: relative; padding-bottom: 56.25%; height: 0; overflow: hidden; max-width: 100%; margin: 20px 0;">
  <iframe 
    src="https://www.youtube.com/embed/ozxD466gopg" 
    style="position: absolute; top: 0; left: 0; width: 100%; height: 100%;" 
    frameborder="0" 
    allowfullscreen>
  </iframe>
</div>

# Unique and Priority Identifiers in Synthesizable SystemVerilog

## Table of Contents
- [Introduction](#introduction)
- [The `unique` Keyword](#the-unique-keyword)
- [The `unique0` Keyword](#the-unique0-keyword)
- [The `priority` Keyword](#the-priority-keyword)
- [Practical Examples](#practical-examples)
- [Common Pitfalls](#common-pitfalls)
- [Best Practices](#best-practices)
- [Summary](#summary)

## Introduction

SystemVerilog provides three special keywords (`unique`, `unique0`, and `priority`) that can be used with `case` and `if` statements to provide synthesis tools with optimization hints and enable runtime checking during simulation.

### Purpose and Benefits

These keywords serve two primary purposes:

1. **Synthesis Optimization**: Inform synthesis tools about the nature of case items, enabling better logic optimization
2. **Simulation Checking**: Provide runtime violation checking to catch design errors during verification

The main benefit is helping synthesis tools distinguish between scenarios that require:
- **Parallel evaluation** (when cases are mutually exclusive)
- **Priority encoding** (when order matters or cases may overlap)

## The `unique` Keyword

The `unique` keyword indicates that case items are mutually exclusive and fully cover all possible input values.

### Simulation Behavior

When using `unique`, the simulator performs runtime checking and issues warnings if:
- **Multiple case items evaluate to true simultaneously**
- **No case items evaluate to true**

### Synthesis Implications

The `unique` keyword informs the synthesis tool that:
- Case items are **mutually exclusive** (only one can be true at a time)
- All possible input values are **fully covered** by the case items
- The tool can **optimize for parallel evaluation** instead of priority encoding
- **No default case is necessary** since all values are covered

### Example:

```verilog
typedef enum logic [2:0] {
    RED    = 3'b001, 
    GREEN  = 3'b010, 
    YELLOW = 3'b100
} colors_t;

colors_t current_color, next_color;

always_comb begin
    unique case (current_color)
        RED:    next_color = YELLOW;
        GREEN:  next_color = RED;
        YELLOW: next_color = GREEN;
        // No default needed - unique tells tools all cases are covered
    endcase
end
```

In this example, the synthesis tool can generate optimized parallel logic instead of a priority encoder because it knows:
1. Only one case can be true at a time (mutually exclusive)
2. All possible enum values are handled (fully covered)

### Important Caveat for Using `unique` Keyword

One caveat for using the `unique` keyword without fully covered `case` or `if` statements (and without `default` or `else` clauses) is that synthesis tools may generate smaller circuits compared to fully covered `case`/`if` statements with explicit `default`/`else` handling. However, the resulting circuit could be **less robust** to environmental noise, and if the circuit state changes to an undefined state, the circuit behavior becomes unpredictable.

> Therefore, it is more robust to always fully cover `case` and `if` statements. In today's technology, removing the `default` statement may only reduce a small number of transistors, but it does not significantly affect the overall circuit area or power consumption, while potentially compromising reliability.


## The `unique0` Keyword

The `unique0` keyword indicates that **at most one** case item can be true, but not all possible values need to be covered.

### Simulation Behavior

The simulator only issues a warning if:
- **Multiple case items evaluate to true simultaneously**
- **No warning** if no case items are true

### Synthesis Implications

The `unique0` keyword tells the synthesis tool:
- Case items are **mutually exclusive**
- **Not all possible values are covered** by case items
- May **infer latches** for uncovered input values
- Can still optimize for parallel evaluation of covered cases

### Important Warning

> **Do NOT use `unique0` for RTL modeling.** The ability for no cases to match can lead to unintentional latch inference, which is generally undesirable in synchronous digital design.

## The `priority` Keyword

The `priority` keyword specifies that the order of case items is important and they should be evaluated sequentially in the order written.

### Simulation Behavior

The simulator issues a warning if:
- **No case items evaluate to true**
- **No warning** for multiple matches (first match wins)

### Synthesis Implications

The `priority` keyword informs the synthesis tool:
- Case items should be evaluated **in order**
- **First matching condition wins**
- Should implement a **priority encoder**
- Optimizes for sequential rather than parallel evaluation

## Practical Examples

### Example 1: Optimized State Machine with `unique`

```verilog
typedef enum logic [1:0] {
    IDLE = 2'b00,
    WORK = 2'b01,
    DONE = 2'b10
} state_t;

state_t current_state, next_state;

always_comb begin
    unique case (current_state)
        IDLE: next_state = start ? WORK : IDLE;
        WORK: next_state = finished ? DONE : WORK;
        DONE: next_state = reset ? IDLE : DONE;
        // All enum values covered - synthesis optimizes for parallel evaluation
    endcase
end
```

### Example 2: Priority Interrupt Controller with `priority`

```verilog
module priority_interrupt_decoder(
    input  logic [3:0] interrupt_req,   // 4 interrupt request inputs
    output logic [1:0] interrupt_id,    // Encoded interrupt ID
    output logic       interrupt_valid  // Valid interrupt present
);
    always_comb begin
        priority case (interrupt_req) inside
            4'b???1: begin  // Interrupt 0 (highest priority)
                interrupt_id    = 2'b00;
                interrupt_valid = 1'b1;
            end
            4'b??10: begin  // Interrupt 1
                interrupt_id    = 2'b01;
                interrupt_valid = 1'b1;
            end
            4'b?100: begin  // Interrupt 2
                interrupt_id    = 2'b10;
                interrupt_valid = 1'b1;
            end
            4'b1000: begin  // Interrupt 3 (lowest priority)
                interrupt_id    = 2'b11;
                interrupt_valid = 1'b1;
            end
            default: begin  // No interrupts
                interrupt_id    = 2'b00;
                interrupt_valid = 1'b0;
            end
        endcase
    end
endmodule
```

This example demonstrates proper use of `priority` where:
- Multiple interrupts can be active simultaneously
- Higher-numbered bit positions have higher priority
- The priority encoder ensures only the highest priority interrupt is serviced

## Common Pitfalls

### Misusing `unique` with Incomplete Coverage

**Incorrect Usage:**
```verilog
module address_decode (
    input  logic [1:0] select,
    output logic       data
);
    always_comb begin
        data = 1'b0; // Default assignment
        unique case (select)
            2'b10: data = 1'b1;
            // ERROR: Missing cases for 2'b00, 2'b01, 2'b11
        endcase
    end
endmodule
```

**Generated library-independent circuit**

![Misusing unique with Incomplete Coverage](/assets/images/14- Unique and Priority - Pitfall Unique Wrong.png)

**Problems with this approach:**
1. `unique` tells the synthesis tool that all possible values are covered, but they're not
2. The tool optimize away the default assignment `data = 1'b0`
3. Undefined behavior for uncovered input values (2'b00, 2'b01, 2'b11)

**Correct Approach:**
```verilog
module address_decode (
    input  logic [1:0] select,
    output logic       data
);
    always_comb begin
        data = 1'b0; // Default assignment
        case (select)  // Remove 'unique' - not all cases covered
            2'b10: data = 1'b1;
            // Default assignment handles all other cases
        endcase
    end
endmodule
```


**Generated library-independent circuit**
![Correct unique with Incomplete Coverage](/assets/images/14- Unique and Priority - Pitfall Unique Correct.png)

## Best Practices

### When to Use Each Keyword

| Keyword | Use Case | Synthesis Result | Best For |
|---------|----------|------------------|----------|
| `unique` | Mutually exclusive, fully covered cases | Parallel evaluation logic | State machines, complete decoders |
| `priority` | Order-dependent evaluation | Priority encoder | Interrupt controllers, nested conditions |
| `unique0` | Mutually exclusive, partially covered | Parallel + potential latches | **Avoid in RTL** |

### Design Guidelines

1. **Use `unique` when you have complete, mutually exclusive coverage**
   - All possible input combinations are explicitly handled
   - Cases cannot overlap
   - Want optimized parallel logic

2. **Use `priority` when order matters**
   - Multiple conditions might be true simultaneously
   - Want to service the first (highest priority) match
   - Need priority encoder behavior

3. **Avoid `unique0` in synthesizable RTL**
   - Can lead to unintentional latch inference
   - Better to use regular `case` with explicit defaults

4. **Let simulation catch violations**
   - Use these keywords during verification to catch design errors
   - Address any warnings that appear during simulation


## Summary

The `unique`, `unique0`, and `priority` keywords are powerful SystemVerilog features that:

- **Improve synthesis results** by providing optimization hints to tools
- **Enable error checking** during simulation to catch design mistakes
- **Make design intent clearer** to both tools and other engineers

**Key takeaways:**
- Use `unique` for complete, mutually exclusive case coverage to get optimized parallel logic
- Use `priority` when evaluation order matters to get optimized priority encoders  
- Avoid `unique0` in RTL design due to potential latch inference issues
- Always verify your assumptions during simulation - let the tools catch violations
- These keywords are about **optimization and verification**, not changing fundamental logic behavior

When used correctly, these keywords help create more efficient hardware implementations while catching potential design errors during the verification process.