; Count to whatever (itoa) - now with more digits
; Compile with: nasm -f elf 08_countbetter.asm
; Link with: ld -m elf_i386 08_countbetter.o -o countbetter
; Run with: ./countbetter
; For notes, read the 07 assembly script

%include        'functions.asm'

SECTION .text
global _start

_start:

    mov     ecx, 0

nextNumber:
    inc     ecx
    mov     eax, ecx
    call    iprintLF
    cmp     ecx, 101
    jne     nextNumber

    call    quit
