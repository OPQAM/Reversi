section .text
global _start

_start:
        MOV edx,1111              ; EDX is not zero
        MOV eax,11
        MOV ecx,7000
        DIV ecx

        ; EDX will become the remainder (1)

        MOV ebx,1
        MOV eax,1
        INT 80h

        ; Note: we can't make EDX 0xFFFFFFFF because that would cause an overflow
