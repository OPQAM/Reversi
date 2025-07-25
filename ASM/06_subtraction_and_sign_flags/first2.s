section .data


section .text
global _start

_start:
        MOV eax,3
        MOV ebx,5
        SUB eax,ebx
        INT 80h
