# Gray Counter Verification using UVM

This project implements a **4-bit Gray Code Counter** designed in Verilog and verified using SystemVerilog with **UVM (Universal Verification Methodology)**. The counter generates a sequence of Gray Code values, where only one bit changes between successive values, making it ideal for clock domain crossing and state machine applications.

## Key Features

- **4-bit Gray Code Counter:** Generates a 4-bit Gray Code sequence.  
- **Synchronous Design:** Counter operates on the rising edge of the clock.  
- **Reset Support:** Asynchronous reset (active high) to initialize the counter.  
- **Binary to Gray Conversion:** The Gray code value is derived directly from the binary counter using bitwise XOR operations:  
  - `gray_count[3] = bin_count[3]`  
  - `gray_count[2] = bin_count[3] ^ bin_count[2]`  
  - `gray_count[1] = bin_count[2] ^ bin_count[1]`  
  - `gray_count[0] = bin_count[1] ^ bin_count[0]`  
- **Binary Count Output:** The current binary counter value is also made available as an output (`bin_count_out`).  
- **Efficient RTL Design:** Developed using Verilog for Register Transfer Level (RTL) implementation.  
- **Comprehensive Verification:** Verified using UVM (Universal Verification Methodology).  
- **Robust Functional Coverage:** Achieved 100% functional coverage through covergroups.  
- **Assertion-Based Verification:** 100% coverage achieved using SystemVerilog Assertions (SVA).  
