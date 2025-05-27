---
number: 8
title: "SV8. SystemVerilog Implicit Net Declaration"
date: 2025-05-08
categories:
  - SystemVerilog
tags:
  - Data Type
  - Net
excerpt: "Tired of silent bugs caused by undeclared signals in SystemVerilog?
This article explains how implicit net declarations work, when they happen, and how to avoid them using best practices like default_nettype none and dot-name/dot-star port connections. Useful tips for writing clear and reliable HDL code."
header:
  teaser: /assets/images/8- Implicit Net Declaration.png
classes: wide
---



![Simulation Event Scheduling](/assets/images/8- Implicit Net Declaration.png)

Tired of silent bugs caused by undeclared signals in SystemVerilog?

This article explains how implicit net declarations work, when they happen, and how to avoid them using best practices like default_nettype none and dot-name/dot-star port connections. Useful tips for writing clear and reliable HDL code.



## Video Tutorial

Watch this comprehensive video explanation of Implicit Net Declaration:

<div class="video-container" style="position: relative; padding-bottom: 56.25%; height: 0; overflow: hidden; max-width: 100%; margin: 20px 0;">
  <iframe 
    src="https://www.youtube.com/embed/aDRsJdgRpf4" 
    style="position: absolute; top: 0; left: 0; width: 100%; height: 100%;" 
    frameborder="0" 
    allowfullscreen>
  </iframe>
</div>

# Nets: Implicit Declarations in SystemVerilog

In SystemVerilog, the response to an **undeclared identifier** varies based on context:

---

## 1. Procedural Assignment (RHS or LHS)

- **Result:** Compilation error if the identifier is undeclared.

```verilog
logic [7:0] faa;
initial begin
    faa = bar; // Error: 'bar' is undeclared
end
```

---

## 2. Continuous Assignment (RHS)

- **Result:** Compilation error if the identifier is undeclared.

```verilog
logic [7:0] faa;
assign foo = bar; // Error: 'bar' is undeclared
```

---

## 3. Continuous Assignment (LHS)

- **Result:** An implicit net (`wire`) is created for the undeclared name. No error or warning.

```verilog
logic [7:0] faa;
assign bar = faa; // 'bar' is implicitly declared as a wire
```

---

## 4. Module Port Connections

- **Result:** Implicit nets are inferred for undeclared signals used in connections. No error or warning.

```verilog
module fullAdder (
    input  logic a, b, cin,
    output logic sum, cout
);
    logic s1, c1, c2;
    
    // Typo: 'cl' should be 'c1'
    halfAdder ha1 (.a(a), .b(b),  .sum(s1), .cout(cl)); 
    // Typo: 's' is undefined    
    halfAdder ha2 (.a(s1), .b(cin), .sum(s), .cout(c2)); 
    assign cout = c1 | c2;
    
endmodule : fullAdder
```

---

# Avoiding Implicit Nets in SystemVerilog

To prevent unintended implicit net declarations, use **dot-name** and **dot-star** shortcuts:

## 1. Dot-Name (`.name`)

Connects a port to a signal with the same name, reducing repetition.

```verilog
halfAdder ha1 (
    .a, // Connects port 'a' to signal 'a'
    .b, // Connects port 'b' to signal 'b'
    .sum(s1), 
    .cout(c1)
);
```

## 2. Dot-Star (`.*`)

Automatically connects all matching port/signal names in scope. For mismatched names (e.g., `sum → s1`), connect explicitly.

```verilog
halfAdder ha1 (
    .sum(s1),  
    .cout(c1),
    .*
);
```

---

### **Benefits of Using Dot-Name / Dot-Star**

- **Fewer typos:** No need to retype names.
- **No implicit nets:** All signals must be declared.
- **Compile-time error detection:** Name or size mismatches are caught early.

---

# Disabling Implicit Net Declarations

To prevent implicit net creation, use the **default_nettype** directive:

- **Start with:**
  ```verilog
  `default_nettype none
  ```
- **End with:**
  ```verilog
  `default_nettype wire
  ```

This ensures all nets must be **explicitly declared**, helping catch typos and undefined signals at compile time.

> **Note:**  
> This setting can affect multiple files and should be used consistently, always in pairs (start and end).  
> Using ``default_nettype none`` is optional, but recommended for robust code.
