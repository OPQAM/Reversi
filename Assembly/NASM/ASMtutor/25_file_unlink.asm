; Unlink
; Compile with: nasm -f elf 25_file_unlink.asm
; Link with: ld -m elf_i386 25_file_unlink.o -o unlink
; Run with: ./unlink

%include    'functions.asm'

SECTION .data
filename db 'readme.txt', 0h

SECTION .text
global  _start

_start:

    mov     ebx, filename
    mov     eax, 0x0a           ; SYS_UNLINK
    int     80h

    call    quit
