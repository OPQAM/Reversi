; Count to 10 program
; Compile with: nasm -f elf 07_count10.asm
; Link with: ld -m elf_i386 07_count10.asm -o count10
; Run with: ./count10

%include        'functions.asm'

SECTION .text
global  _start

_start:

    mov     ecx, 0          ; initialize ecx to 0

nextNumber:
    inc     ecx

    mov     eax, ecx
    add     eax, 0x30       ; converting from int to ASCII (to print)
    push    eax             ; push onto the stack
    mov     eax, esp        ; get address of character on the stack
    call    sprintLF

    pop     eax             ; clean stack
    cmp     ecx, 0x0a       ; check if we met our last number
    jne     nextNumber

    call    quit
; NOTE: look at the ASCII table. The character after '9' isn't '10'. It's ':'. So that's what you'll be getting as the 10th character to be writen. :)
