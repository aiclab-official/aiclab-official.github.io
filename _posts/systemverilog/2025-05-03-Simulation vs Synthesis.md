---
number: 3
title: "SV3. Simulation and Synthesis in Digital Design"
date: 2025-05-03
categories:
  - SystemVerilog
tags:
  - simulation
  - synthesis
  - elaboration
excerpt: "Explore the fundamental differences between simulation and synthesis in digital design. Understand how your SystemVerilog code behaves in simulation versus hardware implementation."
header:
  teaser: /assets/images/3- Simulation_Synthesis.png
classes: wide
---



<img src="/assets/images/3- Simulation_Synthesis.png" alt="Simulation vs Synthesis" style="width: 30%; display: block; margin: 0 auto;">





## Video Tutorial

Watch this video explanation of Simulation and Synthesis in Digital Design:

<div class="video-container" style="position: relative; padding-bottom: 56.25%; height: 0; overflow: hidden; max-width: 100%; margin: 20px 0;">
  <iframe 
    src="https://www.youtube.com/embed/1M6stvMG3BE" 
    style="position: absolute; top: 0; left: 0; width: 100%; height: 100%;" 
    frameborder="0" 
    allowfullscreen>
  </iframe>
</div>

## Simulation

Simulation consists of two main steps:

### 1. Compilation
- Reads the source code.
- Decrypts encrypted code.
- Checks for syntax and semantic errors.

### 2. Elaboration
- Constructs the hierarchical structure of the design.
- Expands instantiations.
- Computes parameter values.
- Resolves names.

Elaboration prepares the design for both simulation and synthesis.

---

## Synthesis

Synthesis converts RTL designs into logic gates based on the technology library and user-defined constraints. It involves the following stages:

### 1. Generic Optimization
- Translates HDL code into a generic circuit using technology-independent gates.

### 2. Mapping
- Maps the generic gates to a technology-specific library of standard cells (supplied by the foundry) or to available FPGA resources.

### 3. Optimization
- Ensures the design meets timing, area, and power constraints.
