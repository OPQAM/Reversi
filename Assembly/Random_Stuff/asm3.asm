; Processor Registers in IA-32 architecture

; 10 32-bit and 6 16-bit registers

; General Registers (Data registers, pointer registers, index registers)
; Control Registers 
; Index Registers

; DATA REGISTERS

; There are 4 such registers, used for arithmetic, logical and other operations

; Complete 32-bit registers: EAX, EBX, ECX, EDX

; Lower halves of these (16-bits): AX, BX, CX, DX

; Lower and higher halves of these (8-bits): AH, AL, BH, BL, CH, CL, DH, DL

; AX -> Primary accumulator
; BX -> Base register
; CX -> Count register
; DX -> Data register

; POINTER REGISTERS

; 32-bit EIP, ESP, EBP

; 16-bit right portions IP, SP, BP

; IP -> Instruction pointer (offset address of next instruction to execute)
; SP -> Stack pointer
; BP -> Basse pointer

; INDEX REGISTERS

; 32-bit registers: ESI, EDI

; 16-bit rightmost portions: SI, DI

; Used for index addressing and sometimes addition and subtraction

; SI -> Source index
; DI -> Destination index

; CONTROL REGISTERS

; The 32-bit instruction pointer
; The 32-bit flags register

; OF -> Overflow Flag
; DF -> Direction Flag
; IF -> Interrupt Flag
; TF -> Trap Flag
; SF -> Sign Flag
; ZF -> Zero Flag
; AF -> Auxiliary Carry Flag
; PF -> Parity Flag
; CF -> Carry Flag

; Flag:		             |O| D|I|T|S|Z| |A| |P| |C|
; Bit no:	|15|14|13|12|11|10|9|8|7|6|5|4|3|2|1|0|

; SEGMENT REGISTERS

; Segments are specific areas defined in a program for containing data,
; code and stack.

; Code segment  (CS) -> Instructions to be executed
; Data segment  (DS) -> Contains data, constants and work areas
; Stack segment (SS) -> Data and return addresses of procedures or subroutines
; Extra segment (ES), FS and GS, provide additional segments for storing data

; Example from Tutorialspoint:

section .text
    global _Start

_start:
    mov edx, len
