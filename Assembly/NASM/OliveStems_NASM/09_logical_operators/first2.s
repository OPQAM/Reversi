section .text
global _start

_start:
        MOV eax,0b1010
        MOV ebx,0b1100
        XOR eax,ebx      ;  0b0110
        
        MOV ebx,0
        MOV eax,1
        INT 80h
