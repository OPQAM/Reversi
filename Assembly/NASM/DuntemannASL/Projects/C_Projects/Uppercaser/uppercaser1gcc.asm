; Executable    : uppercaser1gcc
; Version       : 1.0
; Created date  : ---
; Last update   : ---
; Author        : ---
; Architecture  :
; From          :
; Description   : Taken from Jeff Duntemann's book 'x64 Assembly Language Step-by-Step, Programming with Linux. This program converts characters from lower case to uppercase.


; Build using the following commands:
;   nasm -f elf64 uppercaser1gcc.asm -o uppercaser1gcc.o
;   gcc -no-pie uppercaser1gcc.o -o uppercaser1gcc

section .note.GNU-stack noalloc noexec nowrite progbits

section .bss
    Buff resb 1

section .data

section .text
global  main

main:
    mov rbp, rsp    ; for correct debugging

Read:
    mov rax, 0      ; Specify sys_read call
    mov rdi, 0      ; Specify File Descriptot 0: stdin
    mov rsi, Buff   ; Pass address of the buffer to read to
    mov rdx, 1      ; Tell sys_read to read one char from stdin
    syscall         ; Call sys_read

    cmp rax, 0      ; Look at sys_read's return value in RAX
    je  Exit        ; Jump if equal to 0 (EOF) to Exit:
                    ; or continue down to test for lowercase

    cmp byte [Buff], 61h    ; Test against lowercase 'a'
    jb Write                ; Not lowecase, jump
    cmp byte [Buff], 7Ah    ; Test against lowercase 'z'
    ja Write                ; Not lowercase, jump

    sub byte [Buff], 20h    ; We have lowercase, so we subtract 20h
                            ; to make it uppercase and write that

Write:
    mov rax, 1      ; sys_write call
    mov rdi, 1      ; stdout
    mov rsi, Buff   ; Pass address of the character to write
    mov rdx, 1      ; Pass number of characters to write
    syscall         ; Call sys_write
    jmp Read        ; Repeat process by going to the beginning

Exit:
    ret             ; End program
