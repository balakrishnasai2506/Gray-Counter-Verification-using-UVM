# 🧮 Gray Code Counter Verification using UVM

This project showcases a **4-bit Gray Code Counter** implemented in **Verilog** and verified using **SystemVerilog with UVM (Universal Verification Methodology)**. Designed for robust and accurate state transitions, the counter is ideal for **clock domain crossing**, **state machines**, and other digital applications requiring minimal transition errors.

---

## 🚀 Features

- ✅ **4-bit Gray Code Counter**  
  Generates a standard 4-bit Gray code sequence, where only one bit changes per transition.

- 🔄 **Synchronous Operation**  
  Operates on the rising edge of the clock for stable behavior.

- ♻️ **Asynchronous Reset**  
  Active-high reset to initialize the counter instantly.

- 🔧 **Binary to Gray Code Conversion**  
  Efficient and deterministic conversion:
  ```verilog
  gray_count[3] = bin_count[3];
  gray_count[2] = bin_count[3] ^ bin_count[2];
  gray_count[1] = bin_count[2] ^ bin_count[1];
  gray_count[0] = bin_count[1] ^ bin_count[0];

- **Binary Count Output:** The current binary counter value is also made available as an output (`bin_count_out`).  
- **Efficient RTL Design:** Developed using Verilog for Register Transfer Level (RTL) implementation.  
- **Comprehensive Verification:** Verified using UVM (Universal Verification Methodology).  
- **Robust Functional Coverage:** Achieved 100% functional coverage through covergroups.  
- **Assertion-Based Verification:** 100% coverage achieved using SystemVerilog Assertions (SVA).  
