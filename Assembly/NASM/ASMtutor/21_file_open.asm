; Open
; Compile with: nasm -f elf 21_file_open.asm
; Link with (64 bit systems require elf_i386 option): ld -m elf_i386 21_file_open.o -o open
; Run with: ./open

%include    'functions.asm'

SECTION .data
filename db 'readme.txt', 0h
contents db 'Hello World!', 0h

SECTION .text
global  _start

_start:

    mov     ecx, 0777o
    mov     ebx, filename
    mov     eax, 8
    int     80h

    mov     edx, 12
    mov     ecx, contents
    mov     ebx, eax
    mov     eax, 4
    int     80h

    mov     ecx, 0          ; flag for readonly access mode (O_RDONLY)
    mov     ebx, filename   
    mov     eax, 5          ; invoking SYS_OPEN (kernel opcode 5)
    int     80h

    call    iprintLF
    call    quit
