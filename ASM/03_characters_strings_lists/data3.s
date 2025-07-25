section .data
    string1 DB "ABA",0  ; again, see notes
    string2 DB "CDE",0

section .text

global _start

_start:
    MOV bl,[string1]
    MOV eax,1
    INT 80h
