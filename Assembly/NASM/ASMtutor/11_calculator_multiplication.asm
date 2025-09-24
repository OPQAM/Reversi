; Calculator (Multiplication)
; Compile with: nasm -f elf 11_calculator_multiplication.asm
; Link with: ld -m elf_i386 11_calculator_multiplication.o -o calculator_multiplication
; Run with: ./calculator_multiplication

%include        'functions.asm'

SECTION .text
global _start

_start:

    mov     eax, 90
    mov     ebx, 9
    mul     ebx
    call    iprintLF

    call    quit
