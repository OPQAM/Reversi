section .text
global _start

_start:
        MOV eax,11
        MOV ecx,2
        DIV ecx
        INT 80h

; eax = result (5)
; edx = remainder (1)
