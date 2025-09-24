; Calculator (Subtraction)
; Compile with: nasm -f elf 10_calculator_subtraction.asm
; Link with: ld -m elf_i386 10_calculator_subtraction.o -o calculator_subtraction
; Run with: ./calculator_subtraction

%include        'functions.asm'

SECTION .text
global _start

_start:

    mov     eax, 90
    mov     ebx, 9
    sub     eax, ebx
    call    iprintLF

    call    quit
