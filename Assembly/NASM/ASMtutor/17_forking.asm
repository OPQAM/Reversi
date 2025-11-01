; Fork
; Compile with: nasm -f elf 17_forking.asm
; Link with: ld -m elf_i386 17_forking.o -o fork
; Run with: ./fork

%include        'functions.asm'

SECTION .data
childMsg        db      'This is the child process', 0x00
parentMsg       db      'This is the parent process', 0x00

SECTION .text
global  _start

_start:

    mov     eax, 2          ; SYS_FORK (kernel opcode 2)
    int     80h

    cmp     eax, 0          ; if eax = 0 => child process
    jz      child

parent:
    mov     eax, parentMsg
    call    sprintLF

    call quit

child:
    mov     eax, childMsg
    call    sprintLF

    call quit
