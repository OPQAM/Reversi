section .data
    char DB 'A'

section .text

global _start

_start:
    MOV bl,[char]
    MOV eax,1
    INT 80h
