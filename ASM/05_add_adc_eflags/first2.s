section .data


section .text
global _start

_start:
        MOV al,0b11111111
        MOV bl,0b0001
        ADD al,bl
        INT 80h

        ; 0bxxx = binary value
