section .data


section .text
global _start

_start:
        MOV eax,5
        MOV ebx,3
        SUB eax,ebx
        INT 80h
