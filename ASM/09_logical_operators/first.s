section .text
global _start

_start:
    ; AND
        MOV eax,0b1010
        MOV ebx,0b1100
        AND eax,ebx
    ; OR
        MOV eax,0b1010
        MOV ebx,0b1100
        OR eax,ebx
    ; NOT
        NOT eax

        MOV ebx,eax  ; just for fun, because why NOT? *
        MOV eax,1
        INT 80h

        ; * An interesting note here is that POSIX limits the status code to an 8-bit result. So, you can only see here a value from 0 to 255. In this case 241 or 0xF1, which is the value sent to EBX
