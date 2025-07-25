section .text

global _start

_start:
    MOV edx,0
    MOV eax,9
    MOV ecx,-2

    IDIV ecx
    
    MOV ebx,1
    MOV eax,1
    INT 80h
