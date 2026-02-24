# Cryptography Labs

This directory contains practical experiments with classical encryption algorithms, performed during the Cryptography & Security module. The labs utilize both CrypTool 1 (CT1) and CrypTool 2 (CT2) to demonstrate symmetric encryption techniques.

## Tools Used

* **CrypTool 1 (CT1):** Used for quick text-based encryption and educational analysis.
* **CrypTool 2 (CT2):** Used for building visual cryptographic workflows (.cwm files).

## Project Structure

### 1. Caesar Cipher (Substitution)
A monoalphabetic substitution cipher where each letter is shifted by a fixed number.
* **Caesar-cryptool1.txt**: Output from CT1.
    * Input: haytham kennouz 
    * Shift: +3
    * Output: kdbwkdq nhqqrxc 
* **CEASAR-CRYPTOOL2.cwm**: The CrypTool 2 workspace file containing the visual workflow for the Caesar logic
### 2. Vigenère Cipher (Polyalphabetic)
A polyalphabetic substitution method that uses a keyword to shift letters, making it more resistant to frequency analysis than Caesar.
* **Vigenère-cryptool1.txt**: Output from CT1.
    * Input: haytham kennouz 
    * Output: mofyvhs ylsbvzn 
* **vigenere-cryptool2.cwm**: The CrypTool 2 workspace file demonstrating the Vigenère encryption/decryption workflow.

## How to Run

1.  **For .txt files:** Open in any text editor to view the raw input/output pairs.
2.  **For .cwm files:**
    * Install CrypTool 2.
    * Open the .cwm file to view the node-based logic graph.
    * Click "Play" to execute the encryption workflow.


**Student:** Haytham KENNOUZ