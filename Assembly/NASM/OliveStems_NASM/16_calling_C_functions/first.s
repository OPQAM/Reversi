extern test
extern exit

section .data

section .text
global main

main:
        PUSH 1
        PUSH 2
        CALL test
        ; eax will keep the return value, so we push it
        PUSH eax
        CALL exit
