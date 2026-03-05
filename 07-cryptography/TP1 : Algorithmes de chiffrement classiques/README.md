# TP 1 (Part 1): Classical Cryptography Algorithms

This practical work (TP) focuses on studying and implementing several classical cryptography algorithms using the **CrypTool** software.

## TP Content

### 1. Caesar Cipher
- **Type**: Monoalphabetic substitution by shift.
- **Analysis**: Frequency analysis was used to identify the shift. Entropy remains unchanged as the statistical structure of the text is preserved (simple alphabet sliding).

### 2. Vigenère Cipher
- **Type**: Polyalphabetic substitution.
- **Key Used**: `CRYPTOOL` (8 characters).
- **Method**: Identified key length through autocorrelation analysis (regular peaks every 8 characters).

### 3. Hill Cipher
- **Type**: Block cipher (polygram substitution).
- **Parameters**: Block size $n=2$ with key `TEST`.
- **Demonstration**: Detailed matrix calculations show the block "HI" transforming into "RY".

### 4. Monoalphabetic Substitution
- **Exercise**: Cryptanalysis of a German text.
- **Method**: Utilized "Probable Words" (such as "DIE" and "DEUTSCHE") to reconstruct the substitution alphabet manually.

### 5. Binary Addition (XOR)
- **Principle**: Stream cipher.
- **Result**: Recovered the hexadecimal key (`12 34 AB CD`) by assuming the most frequent character in the plaintext is 'e' (0x65).

### 6. Playfair Cipher
- **Type**: Digraph substitution using a $5 \times 5$ grid.
- **Key Used**: `PEGASOS`.

---
**Prepared by**: Haytham KENNOUZ  
**Institution**: ENSA Beni Mellal (2025-2026)
