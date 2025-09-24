; Calculator (Addition)
; Compile with: nasm -f elf 09_addition_calculator.asm
; Link with: ld -m elf_i386 09_addition_calculator.o -o calculator-addition
; Run with: ./calculator-addition

%include        'functions.asm'

SECTION .text
global _start

_start:

    mov     eax, 90
    mov     ebx, 9
    add     eax, ebx
    call    iprintLF

    call quit
