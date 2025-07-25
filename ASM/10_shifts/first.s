section .text
global _start

_start:
        MOV eax,2
        SHR eax,1         ; 0010 -> 0001
        
        MOV eax,1
        MOV ebx,0
        INT 80h
