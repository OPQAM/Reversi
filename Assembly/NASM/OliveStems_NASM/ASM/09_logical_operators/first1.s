section .text
global _start

_start:
        MOV eax,0b1010     ;   0x0000000A
        NOT eax            ;   0xFFFFFFF5
        AND eax,0x0000000F ; * 0x00000005

        MOV ebx,eax
        MOV eax,1
        INT 80h
        



        ; * By applying this MASK, we're forcing EAX to become all 0's with the exception of the first 4 bits, which will take whatever EAX value is at that time for that position
