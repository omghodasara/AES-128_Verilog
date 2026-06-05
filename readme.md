# AES-128 Single-Cycle Encryption in Verilog

## Overview
I built a fully working AES-128 encryption module in Verilog. It does the entire encryption process purely in hardware using combinational logic (no clock cycles needed for the intermediate rounds). I verified it using official NIST test vectors.

---

## 1. The Files

### `sbox.v`
This is just a big lookup table. It uses a `case` statement to take an 8-bit input and swap it out for the correct AES 8-bit output.

### `subBytes.v`
This takes the full 128-bit input, chops it into 16 separate bytes, and runs them all through the S-box at the same time using a `generate` loop.

### `shiftRows.v`
This shifts the rows of the 4x4 AES matrix. Row 0 stays exactly the same, Row 1 shifts left by 1 byte, Row 2 shifts by 2 bytes, and Row 3 shifts by 3 bytes. 

### `mixColumns.v`
This mixes up the columns using some special math (Galois Field multiplication). I wrote two small functions inside (`mul2` and `mul3`) to handle the math for the fixed AES matrix.

### `addRoundKey.v`
The simplest module. It just does a 128-bit XOR between the current data and the round key.

### `aesRound.v`
This connects the four main steps together to make one standard AES round. It routes the data like this: `subBytes` -> `shiftRows` -> `mixColumns` -> `addRoundKey`.

### `keyExpansion.v`
This unrolls the entire AES key schedule. Instead of generating keys round by round, it takes the original 128-bit key and combinationally spits out all 11 round keys at exactly the same time. 

### `aes128.v` (Top Module)
This ties everything together. 
* It calls `keyExpansion` to get all the keys.
* It does the initial key addition (Round 0).
* It runs the data through 9 normal rounds using `aesRound`.
* It runs the final 10th round (which explicitly skips the `mixColumns` step, per the AES rules).

---

## 2. Testing (`tb_aes128.v`)

I wrote a simple testbench to plug in the inputs, wait 20ns, and check the outputs. I tested it against 3 standard cases:
1. The standard NIST test case
2. An all-zeros edge case
3. Incrementing numbers (00, 01, 02...)

*Funny note about Test 1:* At first, the expected output I wrote in the comments was wrong. The simulation output didn't match my comment, and I thought my code was broken. But after checking the actual NIST document, my Verilog code was doing the math perfectly, I just had a typo in my testbench comment. Fixed the comment and everything passed.

---

## 3. Bugs & Fixes

* **Backwards Matrix:** At first, I numbered the matrix wires upside down in `shiftRows` and `mixColumns` (I put `[7:0]` in the top left instead of `[127:120]`). This meant the matrix was reading backwards. I fixed it by mapping the Verilog bit slices to the correct spots.
* **Copy-Paste Typo:** In `keyExpansion`, I accidentally named an intermediate wire `w3_sub` instead of `w11_sub` which threw an undeclared identifier error. Easy fix.

---

## Conclusion
The whole project synthesizes properly, runs combinationally, and perfectly matches the expected AES-128 outputs.