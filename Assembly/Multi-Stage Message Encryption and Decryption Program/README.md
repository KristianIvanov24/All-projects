# Multi-Stage Message Encryption and Decryption Program

## Project Description

This program is designed to encrypt and decrypt a message generated from a file in multiple stages, each independent of the others. The message can consist of an arbitrary number of characters, with a maximum of 200 characters. Encryption is performed by pressing "1," and decryption by pressing "2."

**Additional Instructions:**

- The "level of encryption nesting" refers to how many stages of encryption the program can apply to the given message.
  
**Encryption Levels:**

- Weak Encryption:
  - The level of encryption nesting is 1.

- Medium Encryption:
  - The level of encryption nesting is 2.

- Strong Encryption:
  - The level of encryption nesting is >=3.

**Requirements and Implementation:**

- The program is capable of both encrypting and decrypting the message, allowing bidirectional transformation.
- After each encryption/decryption operation, the current state of the message is displayed.
- Encryption and decryption can be invoked in any order. For example, if the program has an encryption nesting level (ENL) of 3, and the message has been encrypted twice, it can be decrypted twice to return to the original message. Attempting further decryption will produce an appropriate error message with proper validation.
- The program employs unique, well-defined, and one-of-a-kind encryption algorithms.

## Usage

1. Run the program.
2. Enter "1" to initiate encryption or "2" for decryption.
3. Follow the on-screen prompts.
4. Observe the encrypted or decrypted message as it progresses through stages.
5. Continue encryption or decryption as desired.
6. Ensure you follow the specified encryption nesting levels.

## Exiting the Program

- To exit the program, enter "e" when prompted for a command.

## Compilation and Execution

This program is written in x86 assembly language. You can assemble and run it using an appropriate assembler and emulator. Ensure that you have the required tools set up for assembly programming.

## Disclaimer

This README provides an overview of the project's purpose, requirements, and execution. As this program is written in assembly language, it may require specific setup and tools to compile and run. Please consult your instructor or documentation for assistance with assembly programming.
