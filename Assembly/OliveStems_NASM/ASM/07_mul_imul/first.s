section .text
global _start

_start:
        ; MUL -> Unsigned values
        ; IMUL -> Signed values
        MOV al,2
        MOV bl,3
        ; MUL automatically makes use of the a register
        MUL bl    ; so, read al = al * bl
        ; the a register is the accumulator register
        INT 80h
