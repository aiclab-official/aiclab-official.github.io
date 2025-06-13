---
number: 11
title: "SV11. Signed Arithmetic in SystemVerilog"
date: 2025-05-11
categories:
  - SystemVerilog
tags:
  - Arithmetic
excerpt: "This page summarizes the key rules and pitfalls for synthesizable signed arithmetic in SystemVerilog, focusing on vector size, signed vs. unsigned behavior, and correct handling of carry-in signals. Each section provides code examples and explanations to help hardware designers avoid common mistakes."
header:
  teaser: /assets/images/11- SystemVerilog Signed Arithmetic.png
classes: wide
---



![Signed Arithmetic](/assets/images/11- SystemVerilog Signed Arithmetic.png)

This page summarizes the key rules and pitfalls for synthesizable signed arithmetic in SystemVerilog, focusing on vector size, signed vs. unsigned behavior, and correct handling of carry-in signals. Each section provides code examples and explanations to help hardware designers avoid common mistakes.



## Video Tutorial

Watch this comprehensive video explanation of Signed Arithmetic in SystemVerilog:

<div class="video-container" style="position: relative; padding-bottom: 56.25%; height: 0; overflow: hidden; max-width: 100%; margin: 20px 0;">
  <iframe 
    src="https://www.youtube.com/embed/wumVAdXGWNo" 
    style="position: absolute; top: 0; left: 0; width: 100%; height: 100%;" 
    frameborder="0" 
    allowfullscreen>
  </iframe>
</div>

# Synthesizable Signed Arithmetic in SystemVerilog

This wiki page summarizes the key rules and pitfalls for synthesizable signed arithmetic in SystemVerilog, focusing on vector size, signed vs. unsigned behavior, and correct handling of carry-in signals. Each section provides code examples and explanations to help hardware designers avoid common mistakes.

---

## 1. Vector Size Rules

SystemVerilog operators can be grouped by how they determine operand sizes:

### Self-Determined Operands

- **Definition:** Each operand is evaluated independently, so vector sizes do not need to match.
- **Example:** Logical operators (such as `||`).
- **Code Example:**
    ```verilog
    logic [ 7:0] a;
    logic [15:0] b;
    logic        r;
    assign r = a || b; // Checks if a or b is true, regardless of size
    ```

### Context-Determined Operands

- **Definition:** Operands are sized to match the largest operand, extending smaller ones.
- **Example:** Bitwise operators, e.g., bitwise OR (`|`).
- **Code Example:**
    ```verilog
    logic [ 7:0] a;
    logic [ 8:0] b;
    logic [15:0] r;
    assign r = a | b; // All operands are expanded to 16 bits
    ```

---

## 2. Signed and Unsigned Rules

- **Operation Type:** For arithmetic, comparison, and shift operations:
    - If **all operands are signed**, the operation is signed.
    - If **any operand is unsigned**, the operation is unsigned.
- **Number Formats:**
    - Decimal literals (e.g., `-1`, `2`) are **signed**.
    - Based literals (e.g., `8'hFF`) are **unsigned** by default.
    - Adding `'s` or `'S` (e.g., `8'shFF`) makes a based literal **signed**.
- **Result Types:**
    - **Part-select results** (e.g., `b[15:0]`) are always **unsigned**.
    - **Concatenation results** are always **unsigned**.
    - **Comparison and reduction operations** always yield **unsigned** results.

**Code Example:**
```verilog
logic signed [31:0] s1, s2, s3;
logic        [31:0] u1, u2, u3;
assign u3 = s1 * s2; // signed operation
assign s3 = s1 * u1; // unsigned operation
```

```verilog
logic        [31:0] a;
logic signed [15:0] b;
// b[15:0] is treated as unsigned and zero-extended
assign a = b[15:0]; 
```

---

## 3. Operation Size and Sign-Extension: Casting

Use casting to control vector size and sign interpretation:

```verilog
logic signed [31:0] s1, s3;
logic        [15:0] s4;
logic        [31:0] u1;

assign s3 = s1 * u1;               // unsigned operation (likely a mistake)
assign s3 = s1 * signed'(u1);      // signed operation (u1 cast to signed)
assign s3 = 32'(s1) * signed'(u1); // sign-extend s1 to 32 bits and cast u1 to signed
```

---

## 4. Signed Adder with Carry-In: Common Pitfalls

### (A) Unsigned Carry-In (Incorrect)

- If any operand (e.g., `cin`) is unsigned, the whole addition becomes unsigned.
- If `a` or `b` is negative, the result is not a correct signed sum.

```verilog
module signed_adder (
    input  logic signed [31:0] a,
    input  logic signed [31:0] b,
    input  logic cin,
    output logic signed [31:0] sum,
    output logic cout
);
    // Error: Unsigned cin makes sum unsigned
    assign {cout, sum} = a + b + cin;
endmodule : signed_adder
```

### (B) Signed 1-bit Carry-In (Incorrect)

- Declaring `cin` as `logic signed` causes sign extension:
    - `cin = 1'b0` extends to all zeros (correct).
    - `cin = 1'b1` extends to all ones (`-1`), causing the sum to be `a + b - 1` (incorrect).

```verilog
module signed_adder (
    input  logic signed [31:0] a,
    input  logic signed [31:0] b,
    input  logic signed cin,
    output logic signed [31:0] sum,
    output logic cout
);
    // Error: cin=1 becomes -1 after sign extension
    assign {cout, sum} = a + b + cin;
endmodule : signed_adder
```

### (C) Signed Cast of Carry-In (Still Incorrect)

- Explicitly casting a 1-bit `cin` to signed does not change the width or fix the sign extension issue.

```verilog
module signed_adder (
    input  logic signed [31:0] a,
    input  logic signed [31:0] b,
    input  logic cin,
    output logic signed [31:0] sum,
    output logic cout
);
    // Error: signed'(cin) still sign-extends a 1-bit value
    assign {cout, sum} = a + b + signed'(cin);
endmodule : signed_adder
```

---

## 5. Signed Adder with Correct Carry-In Handling

- **Correct Approach:** Widen `cin` to at least 2 bits before casting.
    - `{1'b0, cin}` forms a 2-bit vector: `00` or `01`.
    - `signed'({1'b0, cin})` interprets this as 0 or 1 (never -1).

```verilog
module signed_adder (
    input  logic signed [31:0] a,
    input  logic signed [31:0] b,
    input  logic cin,
    output logic signed [31:0] sum,
    output logic cout
);
    // Correct: cin is widened before being cast to signed
    assign {cout, sum} = a + b + signed'({1'b0, cin});
endmodule : signed_adder
```

---

## 6. Full Example: Signed Adder

```verilog
module signed_adder (
    input  logic signed [31:0] a,
    input  logic signed [31:0] b,
    input  logic               cin,
    output logic signed [31:0] sum1,  sum2,
    output logic               cout1, cout2
);

    assign {cout1, sum1} = a + b + cin;                 // Incorrect: unsigned cin
    assign {cout2, sum2} = a + b + signed'({1'b0, cin}); // Correct: cin properly widened and cast

endmodule : signed_adder
```

---

## 7. Signed Adder with Unsigned Carry-In: Waveform

![Signed Arithmetic Wave](/assets/images/11- SystemVerilog Signed Arithmetic Wave.png)

---

**Summary:**  
- Always be mindful of operand sizes and signedness in SystemVerilog arithmetic.
- For signed addition with a carry-in, always widen and cast the carry-in correctly to avoid subtle synthesis and simulation bugs.

---

## Testbench for Demonstrating the Results

```verilog
module signed_adder_tb;
    // Test signals
    logic signed [31:0] a, b;
    logic               cin;
    logic signed [31:0] sum1, sum2;
    logic               cout1, cout2;
    
    // Expected results
    logic signed [33:0] expected_result;
    
    // DUT instance
    signed_adder dut (.*);
    
    // Task for test execution
    task test_case(
        input logic signed [31:0] in_a, in_b,
        input logic              in_cin
    );
        a = in_a;
        b = in_b;
        cin = in_cin;
        expected_result = $signed(a) + $signed(b) + $signed({1'b0, cin});
        #5;
        
        // Display results
        $display("\nTime=%0t: a=%0d b=%0d cin=%0b", $time, a, b, cin);
        $display("Method1: sum=%0d, cout=%0b", sum1, cout1);
        $display("Method2: sum=%0d, cout=%0b", sum2, cout2);
        
        // Verify results
        if (sum1 !== sum2)
            $display("Sum mismatch: sum1=%0d sum2=%0d", sum1, sum2);
        if (cout1 !== cout2)
            $display("Cout mismatch: cout1=%0b cout2=%0b", cout1, cout2);
            
        #5;
    endtask

    // Test scenarios
    initial begin
        // Test case 1: Small positive numbers
        test_case(32'd5, 32'd3, 1'b0);
        test_case(32'd5, 32'd3, 1'b1);
        
        // Test case 2: Negative numbers
        test_case(-32'd5, -32'd3, 1'b0);
        test_case(-32'd5, -32'd3, 1'b1);
        
        // Test case 3: Mixed signs
        test_case(32'd5, -32'd3, 1'b0);
        test_case(32'd5, -32'd3, 1'b1);
        
        // Test case 4: Overflow cases
        test_case(32'h7FFFFFFF, 32'd1, 1'b0);
        test_case(32'h7FFFFFFF, 32'd1, 1'b1);
        
        // Test case 5: Negative overflow
        test_case(-32'h80000000, -32'd1, 1'b0);
        test_case(-32'h80000000, -32'd1, 1'b1);
        
        #500;
        
        $finish;
    end

    // Verification properties
    property check_results;
        @(a or b or cin) ##1 
        (sum1 == sum2) && (cout1 == cout2);
    endproperty
    
    assert property(check_results)
        else $error("Result mismatch at time %0t", $time);

endmodule

```