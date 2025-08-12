section .data

section .text
global main

addTwo:
        ADD eax,ebx
        RET


main:
        MOV eax,4
        MOV ebx,1
        CALL addTwo
        MOV ebx,eax
        MOV eax,1
        INT 80h

section .note.GNU-stack noalloc noexec nowrite
