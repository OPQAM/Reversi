section .data
        list DB 1,2,3,4

section .text
global _start
_start:
        MOV eax,0
        MOV cl,0
loop:
        MOV bl,[list + eax]
        ADD cl,bl
        INC eax
        CMP eax,4
        JE end
end:
        MOV eax,1
        MOV ebx,0
        INT 80h
