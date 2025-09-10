section .text

global _start

_start:
    MOV edx,1
    MOV eax,11
    MOV ecx,2

    DIV ecx
    INT 80h
